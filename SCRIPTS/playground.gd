extends Node

@export var drink_scene: PackedScene
@export var patron_scene: PackedScene

var cur_drink: Drink
@onready var drink_spawn_point: Marker2D = $Bartop/DrinkSpawnPoint
@onready var drink_stop_point: Marker2D = $Bartop/DrinkStopPoint
@onready var drinks_layer: Node = $Bartop/Drinks
var previous_cursor_x = 0
@onready var viewport = get_viewport()
var mobile_drag_speed = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if not cur_drink and $Bartender/Bartender.animation != "sling":
		cur_drink = _spawn_drink()
		cur_drink.filled.connect(_on_drink_filled)
		$Bartop/Tap.play("pour")
		$Bartop/Tap/AudioStreamPlayer.play()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("slide"):
		$Bartender/Bartender.play("tap")
		previous_cursor_x = viewport.get_mouse_position().x
	
	if event.is_action_released("slide") and cur_drink:
		var player_impulse_x = viewport.get_mouse_position().x - previous_cursor_x
		#if mobile_drag_speed != Vector2.ZERO:
			#player_impulse_x = mobile_drag_speed.x
			#$Label.text = str(player_impulse_x)
		
		if player_impulse_x > 0 and cur_drink.slide(player_impulse_x * 4):
			cur_drink = null
			$Bartender/Bartender.play("sling")
			return
		$Bartender/Bartender.play("default")
	
	#if event is InputEventScreenDrag:
		#mobile_drag_speed = event.relative
		#$Label.text = str(mobile_drag_speed)
		
func _spawn_drink():
	var drink = drink_scene.instantiate()
	if drink is Drink:
		drink.initialize(drink_stop_point.global_position)
		drink.global_position = drink_spawn_point.global_position
		drinks_layer.add_child(drink)
		return drink
	else:
		return null

func _on_bar_slot_emptied(bar_slot: BarSlot) -> void:
	_spawn_patron($Bartop/Door.global_position, bar_slot)
	
func _spawn_patron(spawn_point: Vector2, bar_slot: BarSlot):
	var new_patron = patron_scene.instantiate()
	if new_patron is Patron:
		$Patrons.add_child(new_patron)
		new_patron.global_position = spawn_point
		new_patron.bar_slot = bar_slot

func _on_drink_filled(drink: Drink):
	if drink == cur_drink:
		$Bartop/Tap.play("idle")
		$Bartop/Tap/AudioStreamPlayer.stop()

func _on_bartender_animation_finished() -> void:
	$Bartender/Bartender.play("default")
