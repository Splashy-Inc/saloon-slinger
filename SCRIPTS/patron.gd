extends CharacterBody2D

class_name Patron

signal finished

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@export var bar_slot: BarSlot
const SPEED = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if bar_slot:
		$DrinkTimer.start()
		finished.connect(bar_slot._on_patron_finished)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if bar_slot:
		if global_position.distance_to(bar_slot.global_position) > 5:
			var direction = global_position.direction_to(bar_slot.global_position)
			velocity = direction * SPEED
			animated_sprite_2d.play("walk")
		elif get_parent() != bar_slot:
			velocity = Vector2.ZERO
			global_position = bar_slot.global_position
			reparent(bar_slot)
			$DrinkTimer.start()
			finished.connect(bar_slot._on_patron_finished)
			if animated_sprite_2d.animation != "drink":
				animated_sprite_2d.play("default")
		move_and_slide()

func drink():
	if animated_sprite_2d.animation == "drink" and animated_sprite_2d.is_playing():
		print("Already drinking")
	else:
		animated_sprite_2d.play("drink")

func _on_animation_finished() -> void:
	if animated_sprite_2d.animation == "drink":
		finished.emit()
		queue_free()

func _on_drink_timer_timeout() -> void:
	if (animated_sprite_2d.animation != "drink" or not animated_sprite_2d.is_playing()) and bar_slot:
		var new_drink = bar_slot.get_drink()
		if new_drink:
			if new_drink is Drink:
				new_drink.queue_free()
				drink()
				new_drink = null
