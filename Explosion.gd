extends AnimatedSprite2D

@onready var splat = $Splat

# Called when the node enters the scene tree for the first time.
func _ready():
	rotation_degrees = randf_range(-180, 180)
	scale = Vector2(randf_range(1.2, 2.8), randf_range(1.2, 2.8))

# Called every frame. 'delta' is the elapsed time since the previous frame.

	
func set_color(what):
	match what:
		0:
			modulate = Color(0, 100, 0, 0.2)
		1:
			modulate = Color(0, 100, 0.1, 0.5)
		2:
			modulate = Color(100, 15, 0, 0.5)
		3:
			modulate = Color(1, 0.2, 0.1, 0.5)
	splat.modulate = modulate
	var rand_frame = randi()% 4
	splat.frame = rand_frame
	$AnimationPlayer.play("fade")


func _on_animation_finished():
	pass


func _on_animation_player_animation_finished(anim_name):
	queue_free()
