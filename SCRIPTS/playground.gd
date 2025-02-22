extends Node

@export var drink_scene: PackedScene

var cur_drink: Drink
@onready var drink_spawn_point: Marker2D = $Bartop/DrinkSpawnPoint
@onready var drink_stop_point: Marker2D = $Bartop/DrinkStopPoint
@onready var drinks_layer: Node = $Bartop/Drinks
var previous_cursor_x = 0
@onready var viewport = get_viewport()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("slide"):
		previous_cursor_x = viewport.get_mouse_position().x

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("slide"):
		cur_drink = _spawn_drink()
	
	if event.is_action_released("slide") and cur_drink:
		var player_impulse_x = viewport.get_mouse_position().x - previous_cursor_x
		cur_drink.slide(player_impulse_x * 20)

func _spawn_drink():
	var drink = drink_scene.instantiate()
	if drink is Drink:
		drink.initialize(drink_stop_point.global_position)
		drink.global_position = drink_spawn_point.global_position
		drinks_layer.add_child(drink)
		return drink
	else:
		return null
