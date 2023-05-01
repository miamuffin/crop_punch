extends Camera2D

@onready var animation_player = $AnimationPlayer
var value = -1

func _ready():
	animation_player.speed_scale = 1.5

func play_animation_smack():
	if value == -1:
		animation_player.play("smack")
	elif value == 1:
		animation_player.play("smack2")
		
	value *= -1
	
func play_animation_get_hit():
	animation_player.play("get_hit")
