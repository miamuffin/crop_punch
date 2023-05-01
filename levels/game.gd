extends Node2D

@onready var player = $Player
var gaming = false
@onready var interface = $Interface

@onready var sprite_2d_2 = $Sprite2D2
@onready var sprite_2d = $Sprite2D
@onready var iocons = $iocons
@onready var parallax_background = $ParallaxBackground
@onready var vignette = $Control/vignette
@onready var vignette_desktop = $vignette_desktop

@onready var projectile_generator = $Control/projectile_generator
@onready var texts = $texts

@onready var highscore = $texts/high_score/highscore
@onready var tutorial = $tutorial

# Called when the node enters the scene tree for the first time.
func _ready():
	hide_gameplay()
	highscore.text = str(Global.best_score)
	SoundPlayer.play_music(SoundPlayer.menu_song)

func hide_gameplay():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	player.is_controlled = false
	interface.visible = false
	player.visible = false
	sprite_2d.visible = false
	sprite_2d_2.visible = false
	parallax_background.visible = false
	vignette.visible = false
	vignette_desktop.visible = false
	texts.visible = true
	tutorial.visible = false

func slow_down():
	var tween = create_tween()
	tween.tween_property(Engine, "time_scale", 0.4, 3.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	tween.parallel().tween_property(vignette, "scale", Vector2(1, 1), 3.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	
func reset_game():
	get_tree().change_scene_to_file("res://levels/game.tscn")

@onready var parallax_background_2 = $ParallaxBackground2

func show_gameplay():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	player.is_controlled = true
	interface.visible = true
	player.visible = true
	sprite_2d.visible = true
	sprite_2d_2.visible = true
	parallax_background.visible = true
	iocons.visible = false
	vignette.visible = true
	vignette_desktop.visible = false
	texts.visible = false
	parallax_background_2.visible = false
	

func _on_button_pressed():
	Trans.play_in_trans()
	await(Trans.in_ended)
	Trans.play_out_trans()
	show_gameplay()
	var atk_patterns = projectile_generator.find_child("AttackPatterns")
	atk_patterns.start_game()
	atk_patterns.difficulty = 0

func _on_button_2_pressed():
	Trans.play_in_trans()
	await(Trans.in_ended)
	Trans.play_out_trans()
	show_gameplay()
	var atk_patterns = projectile_generator.find_child("AttackPatterns")
	atk_patterns.start_game()
	atk_patterns.difficulty = 1

func _on_button_3_pressed():
	Trans.play_in_trans()
	await(Trans.in_ended)
	Trans.play_out_trans()
	show_gameplay()
	var atk_patterns = projectile_generator.find_child("AttackPatterns")
	atk_patterns.start_tutorial()
	interface.visible = false
