extends ParallaxBackground

@onready var parallax_layer = $ParallaxLayer


func _physics_process(delta):
	parallax_layer.motion_offset.x -= 30 * delta
	parallax_layer.motion_offset.y -= 30 * delta

