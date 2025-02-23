extends StaticBody2D

signal bar_slot_emptied

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_bar_slot_emptied(bar_slot: BarSlot) -> void:
	bar_slot_emptied.emit(bar_slot)
