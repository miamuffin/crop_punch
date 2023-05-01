extends CanvasLayer

@onready var animation_player = $AnimationPlayer

signal in_ended
signal out_ended

func play_in_trans():
	animation_player.play("in")
	
func play_out_trans():
	animation_player.play("out")

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "in":
		emit_signal("in_ended")
	else:
		emit_signal("out_ended")
