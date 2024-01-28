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
var on_floor_before = false
var can_fart = true

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
	if can_fart:
		Input.start_joy_vibration(0,0.35,0.35,0.5)
	
func die():
	$AudioStreamPlayer3.play()
	is_living = false
	$Sprite2D.hide()
	preload("res://Menu/Death/DeathTransition.tscn")
	if $GPUParticles2D.emitting == false:
		$GPUParticles2D.emitting = true
		
func jump_pad(rotation):
	velocity.y = JUMP_VELOCITY * 1.4
	coyote_timer.stop()
	gravity_timer.start()
	await get_tree().create_timer(0.01).timeout
	animation.play("jump_right")
	
func jump_pad_right(rotation):
	boosted_dir = 4
	boosted_time = 10
	velocity.y = 0
	coyote_timer.stop()
	gravity_timer.start()
	await get_tree().create_timer(0.01).timeout
	animation.play("jump_right")
	
func jump_pad_left(rotation):
	boosted_dir = -4
	boosted_time = 10
	velocity.y = 0
	coyote_timer.stop()
	gravity_timer.start()
	await get_tree().create_timer(0.01).timeout
	animation.play("jump_right")
	
func dash(amt):
	can_double_jump = true
	boosted_dir = amt
	boosted_time = 10

func _physics_process(delta):
	move_dir = -Input.get_action_strength("move_left") + Input.get_action_strength("move_right")
	# Add the gravity.
	if (!is_living):
		return
	if move_dir < 0:
		sprite.flip_h = 1
		if is_on_floor():
			animation.play("walk_right")
	elif move_dir > 0:
		sprite.flip_h = 0
		if is_on_floor():
			animation.play("walk_right")
	elif is_on_floor():
		animation.play("idle")
	
	if is_on_floor():
		on_floor_before = true
		if on_floor_before == false:
			$AudioStreamPlayer2.play()
		can_double_jump = true
		boosted_dir = 0
		boosted_time = 0
		coyote_timer.start()
	if not is_on_floor() && boosted_time == 0:
		var amplifier = 1.0
		if gravity_timer.is_stopped():
			amplifier = 1.25
		velocity.y += gravity * delta * amplifier
	if Input.is_action_just_pressed("main_shoot"):
		$Node2D/brosse_pos/brosse/return_poop.play("return_anim", -1, 1, false)

	# Handle jump.
	if Input.is_action_just_pressed("jump") and (is_on_floor() || !coyote_timer.is_stopped()):
		$AudioStreamPlayer.play()
		coyote_timer.stop()
		velocity.y = JUMP_VELOCITY * 0.80
		gravity_timer.start()
		animation.play("jump_right")
	elif Input.is_action_just_pressed("jump") and not is_on_floor() and can_double_jump:
		boosted_dir = move_dir * 3
		boosted_time = 10
		gravity_timer.start()
		print(Input.get_action_strength("move_up"))
		velocity.y = - Input.get_action_strength("move_up") * 320
		velocity.normalized()
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
	pass

func _on_gpu_particles_2d_finished():
	get_tree().change_scene_to_file("res://Menu/Death/DeathTransition.tscn")
