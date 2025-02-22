extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

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
		print("Finished drinking!")
