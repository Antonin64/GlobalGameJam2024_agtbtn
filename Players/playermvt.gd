extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var move_dir = 0 #only on x
var shoot_dir = Vector2(0, 0) #on 360°
var can_double_jump = false
var last_jump = 0
var is_living = true
var boosted_dir = 0
var boosted_time = 0
const bulletPath = preload('res://weapons/bullet.tscn')
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var sprite = $"Sprite2D"
@onready var coyote_timer = $"CoyoteTimer"
@onready var gravity_timer = $"DoYouBelieveInGravity?"
@onready var animation = $Sprite2D/AnimationPlayer
@export var fart_particles : PackedScene
@export var speed_amplifier = 0.75

func fart():
	var fart_instance : GPUParticles2D = fart_particles.instantiate()
	fart_instance.position = sprite.position
	fart_instance.position.y += 15
	add_child(fart_instance)
	fart_instance.emitting = true
	Input.start_joy_vibration(0,0.35,0.35,0.5)
	
func die():
	is_living = false
	$Sprite2D.hide()
	preload("res://Menu/Death/DeathTransition.tscn")
	if $GPUParticles2D.emitting == false:
		$GPUParticles2D.emitting = true

func _physics_process(delta):
	move_dir = -Input.get_action_strength("move_left") + Input.get_action_strength("move_right")
	# Add the gravity.
	if (!is_living):
		return
	if move_dir < 0 && is_on_floor():
		sprite.flip_h = 1
		animation.play("walk_right")
	elif move_dir > 0 && is_on_floor():
		sprite.flip_h = 0
		animation.play("walk_right")
	elif is_on_floor():
		animation.play("idle")
	
	if is_on_floor():
		can_double_jump = true
		boosted_dir = 0
		boosted_time = 0
	if not is_on_floor() && boosted_time == 0:
		var amplifier = 1.0
		if gravity_timer.is_stopped():
			amplifier = 1.75
		velocity.y += gravity * delta * amplifier

	# Handle jump.
	if Input.is_action_just_pressed("jump") and (is_on_floor() or not coyote_timer.is_stopped()):
		velocity.y = JUMP_VELOCITY * 0.80
		coyote_timer.start()
		gravity_timer.start()
		animation.play("jump_right")
	elif Input.is_action_just_pressed("jump") and not is_on_floor() and can_double_jump:
		boosted_dir = move_dir * 3
		boosted_time = 10
		gravity_timer.start()
		velocity.y = 0
		fart()
		can_double_jump = false
		animation.play("jump_right")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = move_dir
	if boosted_time > 0 && !is_on_floor():
		direction = boosted_dir
		boosted_time -= 1
	if direction:
		velocity.x = direction * SPEED * speed_amplifier
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
