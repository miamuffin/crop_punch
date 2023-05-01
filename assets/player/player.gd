extends CharacterBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var collision_shape_2d = $Hitbox/CollisionShape2D
@onready var audio_stream_player = $AudioStreamPlayer
@onready var attack_delay = $AttackDelay
@onready var jump_delay = $JumpDelay
@onready var animation_player = $shadow/AnimationPlayer
@onready var shadow = $shadow
@onready var skate_sound_delay = $SkateSoundDelay
@onready var flash = $flash
@onready var firewall_hurt_box_shape = $FirewallHurtBox/FirewallHurtBoxShape

var is_controlled = false
var jumping = false
var invincible = false
var shadow_starting_y = 0

var health = 3

func _process(delta):
	shadow.global_position.y = shadow_starting_y
	if is_controlled:
		if not get_viewport().get_mouse_position().x <= 160 and not get_viewport().get_mouse_position().x >= 340:
			position.x = get_viewport().get_mouse_position().x
		else:
			if manipulate_cursor:
				if get_viewport().get_mouse_position().x <= 160:
					get_viewport().warp_mouse(Vector2(160, get_viewport().get_mouse_position().y))
				elif get_viewport().get_mouse_position().x >= 340:
					get_viewport().warp_mouse(Vector2(340, get_viewport().get_mouse_position().y))

var was_just_in_air = false
var can_play_skate = true
func _input(event):
	if is_controlled:
		if event is InputEventMouseMotion:
			if event.get_relative().x != 0:
				if can_play_skate and not jumping:
					skate_sound_delay.start()
					var rand = randi()% 2
					match rand:
						0:
							SoundPlayer.play_sound(SoundPlayer.skate)
						1:
							SoundPlayer.play_sound(SoundPlayer.skate2)
					can_play_skate = false
				
			if event.get_relative().x < 0:
				if animated_sprite_2d.rotation_degrees < 12:
					animated_sprite_2d.rotate(0.005)
			if event.get_relative().x > 0:
				if animated_sprite_2d.rotation_degrees > -12:
					animated_sprite_2d.rotate(-0.005)

var manipulate_cursor = false
var camera2d
func _ready():
	Global.player_health = health
	shadow_starting_y = shadow.global_position.y
	is_controlled = true
	collision_shape_2d.disabled = true
	camera2d = get_parent().get_node("Camera2D")

func _physics_process(delta):
	animated_sprite_2d.rotation_degrees = move_toward(animated_sprite_2d.rotation_degrees, 0, 1.5)
	if is_controlled:	
		if Input.is_action_just_pressed("mouse1"):
			if animated_sprite_2d.animation == "idle" and attack_delay.is_stopped():
				#is_controlled = false
				audio_stream_player.play()
				animated_sprite_2d.play("swing")
				attack_delay.start()
		if Input.is_action_just_pressed("mouse2"):
			if not jumping:
				SoundPlayer.play_sound(SoundPlayer.skate3)
				firewall_hurt_box_shape.disabled = true
				jumping = true
				jump_delay.start()
				var tween = create_tween()
				jump_squish()
				tween.tween_property(self, "position:y", position.y - 30, 0.2).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
				tween.tween_property(self, "position:y", position.y, 0.2).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
				animation_player.play("shadow_fade")
				await(tween.finished)
				jumping = false
				firewall_hurt_box_shape.disabled = false
			if manipulate_cursor:
				get_viewport().warp_mouse(Vector2(get_viewport().get_mouse_position().x, 150))

	if not jumping and was_just_in_air:
		skate_sound_delay.start()
		SoundPlayer.play_sound(SoundPlayer.skateland)
	was_just_in_air = jumping
	
func _notification(what):
	if what == NOTIFICATION_WM_MOUSE_ENTER:
		manipulate_cursor = true
	elif what == NOTIFICATION_WM_MOUSE_EXIT:
		manipulate_cursor = false

func jump_squish():
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1.2, 0.7), 0.05).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "scale", Vector2(1, 1), 0.15)

func _on_animated_sprite_2d_animation_finished():
	animated_sprite_2d.play("idle")
	if manipulate_cursor:
		get_viewport().warp_mouse(Vector2(get_viewport().get_mouse_position().x, 150))
		get_viewport().warp_mouse(Vector2(position.x, get_viewport().get_mouse_position().y))
	is_controlled = true

func _on_hurt_box_area_entered(area):
	if area is SmallProjectile:
		area.queue_free()
		if not invincible:
			SoundPlayer.play_sound(SoundPlayer.slap)
			get_hit()
	if area is Knives:
		if not invincible:
			SoundPlayer.play_sound(SoundPlayer.knife_slap)
			get_hit()


func _on_animated_sprite_2d_frame_changed():
	if animated_sprite_2d.animation == "swing":
		match animated_sprite_2d.frame:
			0:
				collision_shape_2d.disabled = false
			1:
				collision_shape_2d.disabled = false
			4:
				collision_shape_2d.disabled = true

func get_hit():
	flash.play("flash")
	invincible = true
	
	health -= 1
	Global.player_health = health
	if health <= 0:
		
		SoundPlayer.distort_music()
		is_controlled = false
		get_parent().slow_down()
		animated_sprite_2d.modulate = Color(100, 0, 0, 1)
		flash.play("DIE")
		await get_tree().create_timer(1.5, false).timeout
		
		Trans.play_in_trans()
		await(Trans.in_ended)
		Engine.time_scale = 1.0
		Global.set_highscore()
		
		get_parent().reset_game()
		Trans.play_out_trans()
	
	var tween = create_tween()
	tween.tween_property(animated_sprite_2d, "rotation_degrees", randf_range(-60, 60), 0.2).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT_IN)
	tween.parallel().tween_property(animated_sprite_2d, "skew", randf_range(-1.5, 1.5), 0.2).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT_IN)
	tween.parallel().tween_property(animated_sprite_2d, "scale:x", randf_range(2, 3), 0.2).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT_IN)
	tween.tween_property(animated_sprite_2d, "rotation_degrees", 0, 0.4).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property(animated_sprite_2d, "skew", 0, 0.4).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property(animated_sprite_2d, "scale:x", 1, 0.2).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	camera2d.play_animation_get_hit()
	
func _on_hitbox_area_entered(area):
	if area is SmallProjectile:
		area.explode()
		Global.score += 1
		camera2d.play_animation_smack()

func _on_jump_delay_timeout():
	#jumping = false
	pass


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "shadow_fade":
		animation_player.play("shadow_appear")


func _on_skate_sound_delay_timeout():
	can_play_skate = true


func _on_flash_animation_finished(anim_name):
	if anim_name == "flash":
		$Invincibility.start()
		flash.play("blink")


func _on_invincibility_timeout():
	flash.play("RESET")
	invincible = false


func _on_firewall_hurt_box_area_entered(area):
	if area is Firewall:
		if not jumping and not invincible:
			area.queue_free()
			SoundPlayer.play_sound(SoundPlayer.fire_slap)
			get_hit()
		if invincible:
			area.queue_free()
