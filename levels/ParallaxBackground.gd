extends ParallaxBackground


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
@onready var stripes_1 = $stripes1
@onready var stripes_2 = $stripes2


func _physics_process(delta):
	stripes_1.motion_offset.x += 5 * delta
	stripes_1.motion_offset.y += 5 * delta
	
	stripes_2.motion_offset.x -= 15 * delta
	stripes_2.motion_offset.y -= 15 * delta
