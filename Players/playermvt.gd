extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var move_dir = 0 #only on x
var shoot_dir = Vector2(0, 0) #on 360°
var can_double_jump = false
var last_jump = 0
const bulletPath = preload('res://weapons/bullet.tscn')
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite = $AnimatedSprite2D
@onready var coyote_timer = $CoyoteTimer
@onready var gravity_timer = $"DoYouBelieveInGravity?"
@export var fart_particles : PackedScene

func fart():
	var fart_instance : GPUParticles2D = fart_particles.instantiate()
	fart_instance.position = animated_sprite.position
	fart_instance.position.y += 15
	add_child(fart_instance)
	fart_instance.emitting = true
	Input.start_joy_vibration(0,0.35,0.35,0.5)
	
func die():
	$AnimatedSprite2D.hide()
	preload("res://Menu/Death/DeathTransition.tscn")
	$GPUParticles2D.emitting = true

func _physics_process(delta):
	move_dir = -Input.get_action_strength("move_left") + Input.get_action_strength("move_right")
	# Add the gravity.
	if move_dir < 0:
		animated_sprite.play("run_left")
	elif move_dir > 0:
		animated_sprite.play("run_right")
	else:
		animated_sprite.play("Idle")
	
	if is_on_floor():
		can_double_jump = true
	if not is_on_floor():
		var amplifier = 1.0
		if gravity_timer.is_stopped():
			amplifier = 1.75
		velocity.y += gravity * delta * amplifier

	# Handle jump.
	if Input.is_action_just_pressed("jump") and (is_on_floor() or not coyote_timer.is_stopped()):
		velocity.y = JUMP_VELOCITY * 0.80
		coyote_timer.start()
		gravity_timer.start()
	elif Input.is_action_just_pressed("jump") and not is_on_floor() and can_double_jump:
		velocity.y = JUMP_VELOCITY * 1.15
		gravity_timer.start()
		fart()
		can_double_jump = false

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = move_dir
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	if Input.is_action_just_pressed("main_shoot"):
		shoot()

func shoot():
	shoot_dir.x = -Input.get_action_strength("aim_left") + Input.get_action_strength("aim_right")
	shoot_dir.y = +Input.get_action_strength("aim_down") - Input.get_action_strength("aim_up")
	var bullet = bulletPath.instantiate()
	get_parent().add_child(bullet)
	bullet.global_position = $Node2D.global_position
	bullet.bullet_velocity = shoot_dir

func _on_gpu_particles_2d_finished():
	get_tree().change_scene_to_file("res://Menu/Death/DeathTransition.tscn")
