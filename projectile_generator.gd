extends Node2D

var fruit_scene = preload("res://assets/projectiles/small_projectile.tscn")
var fire_scene = preload("res://assets/projectiles/firewall.tscn")
var knives_scene = preload("res://assets/projectiles/knives.tscn")
@onready var fruits = $fruits
@onready var fruit_timer = $fruit_timer
@onready var fires = $fires
@onready var firewall_timer = $firewall_timer
@onready var knives = $knives


# Called when the node enters the scene tree for the first time.
func _ready():
	#firewall_timer.start()
	#fruit_timer.start()
	#spawn_knives(128)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func spawn_fruit(xpos):
	var fruit_inst = fruit_scene.instantiate()
	fruits.add_child(fruit_inst)
	fruit_inst.global_position.x = xpos
	fruit_inst.speed = Global.small_projectile_spd
	
func spawn_knives(xpos):
	var knives_inst = knives_scene.instantiate()
	knives.add_child(knives_inst)
	knives_inst.global_position.x = xpos
	knives_inst.speed = Global.knives_spd
	
func spawn_firewall(xpos):
	var fire_inst = fire_scene.instantiate()
	fires.add_child(fire_inst)
	fire_inst.global_position.x = xpos
	fire_inst.speed = Global.firewall_spd
	
func _on_fruit_timer_timeout():
	var rando = randi() % 10
	if rando > 4:
		spawn_fruit(0)
	elif rando > 2:
		spawn_knives(160)
	else:
		spawn_firewall(155)


func _on_projectile_destroyer_area_entered(area):
	area.queue_free()


func _on_firewall_timer_timeout():
	spawn_firewall(150)
