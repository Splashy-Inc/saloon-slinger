extends RigidBody2D

class_name Drink

var drag = Vector2(-100,0) # pixels/s/s

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _physics_process(delta: float) -> void:
	if linear_velocity.x > 0:
		apply_force(drag)
	else:
		linear_velocity.x = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(linear_velocity)

func slide(impulse: Vector2, stop_point: Vector2):
	var distance_x = abs(stop_point.x - global_position.x)
	drag = Vector2(-(impulse.x * impulse.x / (2 * distance_x)), 0)
	apply_impulse(impulse)
