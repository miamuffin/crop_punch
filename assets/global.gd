extends Node

var firewall_spd = 220
var	small_projectile_spd = 180
var knives_spd = 180

var player_health = 3

var score = 0
var best_score = 0

func set_highscore():
	if best_score < score:
		best_score = score
	score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
