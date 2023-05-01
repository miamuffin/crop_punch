extends Area2D
class_name Knives

@onready var sprite_2d = $Sprite2D
@onready var shadow = $shadow


var direction = 1
var rotation_speed = 5
var speed = 180

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	sprite_2d.rotate(rotation_speed * direction * delta)
	
	global_position.y += speed * delta
	if global_position.y > 236:
		sprite_2d.z_index = 6
