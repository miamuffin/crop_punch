extends Area2D
class_name SmallProjectile

@export var speed = 180
@onready var animated_sprite_2d = $AnimatedSprite2D
var explosion_scene = preload("res://assets/projectiles/explosion.tscn")
var cur_animation

func _ready():
	randomize()
	var rand = randi() % 4
	match rand:
		0:
			animated_sprite_2d.play("cucumber")
			cur_animation = 0
		1:
			animated_sprite_2d.play("kiwi")
			cur_animation = 1
		2:
			animated_sprite_2d.play("orange")
			cur_animation = 2
		3:
			animated_sprite_2d.play("tomato")
			cur_animation = 3


func _physics_process(delta):
	global_position.y += speed * delta


func explode():
	randomize()
	var what_sound = randi()% 3
	match what_sound:
		0:
			SoundPlayer.play_sound(SoundPlayer.squish1)
		1:
			SoundPlayer.play_sound(SoundPlayer.squish2)
		2:
			SoundPlayer.play_sound(SoundPlayer.squish3)
	
	var explosion_inst = explosion_scene.instantiate()
	get_parent().add_child(explosion_inst)
	explosion_inst.set_color(cur_animation)
	explosion_inst.global_position = global_position
	queue_free()
