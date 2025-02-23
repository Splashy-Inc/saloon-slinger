extends RigidBody2D

class_name Drink

signal stopped

var stop_point: Vector2
var max_impulse = 600
var drag = Vector2(-100, 0) # pixels/s/s
var is_stopped = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	if linear_velocity.x > 0:
		apply_force(drag)
		is_stopped = false
	else:
		linear_velocity.x = 0
		if not is_stopped:
			stopped.emit(self)
			is_stopped = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func initialize(stop_point: Vector2):
	var distance_x = abs(stop_point.x - global_position.x)
	drag = Vector2(-(max_impulse * max_impulse / (2 * distance_x)), 0)

func slide(impulse):
	apply_impulse(Vector2(clamp(impulse,0,max_impulse*2), 0))
