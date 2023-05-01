extends CanvasLayer
@onready var label = $MarginContainer/MarginContainer/Label
@onready var sprite_2d = $MarginContainer/MarginContainer2/Sprite2D

@onready var animation_player = $MarginContainer/MarginContainer2/Sprite2D/AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	prev_health = Global.player_health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

var prev_health
var disabled = false



func _physics_process(delta):
	if not disabled:
		label.text = str(Global.score)
		
		if Global.player_health != prev_health:
			animation_player.play("hit")
			match Global.player_health:
				2:
					sprite_2d.play("2hp")
				1:
					sprite_2d.play("1hp")
				0:
					sprite_2d.play("0hp")
					
		prev_health = Global.player_health
