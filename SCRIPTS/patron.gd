extends AnimatedSprite2D

class_name Patron

signal finished

@export var bar_slot: BarSlot

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$DrinkTimer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func drink():
	if animation == "drink" and is_playing():
		print("Already drinking")
	else:
		play("drink")

func _on_animation_finished() -> void:
	if animation == "drink":
		finished.emit()
		queue_free()

func _on_drink_timer_timeout() -> void:
	if (animation != "drink" or not is_playing()) and bar_slot:
		var new_drink = bar_slot.get_drink()
		if new_drink:
			if new_drink is Drink:
				new_drink.queue_free()
				drink()
				new_drink = null
