extends Node
var squish1 = preload("res://assets/sounds/squish1.ogg")
var squish2 = preload("res://assets/sounds/squish2.ogg")
var squish3 = preload("res://assets/sounds/squish3.ogg")
var skate_turn = preload("res://assets/sounds/skate_turn.ogg")
var skate = preload("res://assets/sounds/skate.ogg")
var skate2 = preload("res://assets/sounds/skate2.ogg")
var skate3 = preload("res://assets/sounds/skate3.ogg")
var skateland = preload("res://assets/sounds/skateland.ogg")
var slap = preload("res://assets/sounds/slap.ogg")
var fire_slap = preload("res://assets/sounds/fire_slap.ogg")
var knife_slap = preload("res://assets/sounds/knive_slap.ogg")

var chill_song = preload("res://assets/sounds/chill_song.ogg")
var song = preload("res://assets/sounds/CSG_puerileboss.mp3")
var menu_song = preload("res://assets/sounds/menu.ogg")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
@onready var audio_stream_player = $Music/AudioStreamPlayer
@onready var sounds = $Sounds
func play_sound(sound):
	for splayer in sounds.get_children():
		if not splayer.playing:
			splayer.stream = sound
			splayer.play()
			break
	
func play_music(song):
	normalize_music()
	audio_stream_player.stream = song
	audio_stream_player.play()
	
func stop_music():
	audio_stream_player.stop()
	
func distort_music():
	var tween = create_tween()
	tween.tween_property(audio_stream_player, "pitch_scale", 0.01, 3.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

func normalize_music():
	audio_stream_player.pitch_scale = 1.0


func _on_audio_stream_player_finished():
	audio_stream_player.play()
