extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print($Drink.linear_velocity)

func _input(event: InputEvent) -> void:
	if event.is_action_released("slide"):
		$Drink.apply_impulse(Vector2(100,0))
