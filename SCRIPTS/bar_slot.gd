extends Node2D

class_name BarSlot

signal emptied

var drinks = []
var drink_queue = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_drink_area_body_entered(body: Node2D) -> void:
	if body is Drink and not body in drinks:
		drinks.append(body)
		body.stopped.connect(_on_drink_stopped)

func _on_drink_area_body_exited(body: Node2D) -> void:
	drinks.erase(body)
	drink_queue.erase(body)
	if body is Drink:
		body.stopped.disconnect(self._on_drink_stopped)

func _on_drink_stopped(drink: Drink):
	if not drink in drink_queue:
		drink_queue.append(drink)

func get_drink():
	if not drink_queue.is_empty():
		var drink = drink_queue.pop_front()
		return drink

func _on_patron_finished():
	emptied.emit(self)
