extends Area2D
class_name Firewall

@onready var animated_sprite_2d = $AnimatedSprite2D

@export var speed = 220
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	global_position.y += speed * delta
