extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var move_dir = 0 #only on x
var shoot_dir = Vector2(0, 0) #on 360°
const bulletPath = preload('res://weapons/bullet.tscn')
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	shoot_dir.x = -Input.get_action_strength("aim_left") + Input.get_action_strength("aim_right")
	shoot_dir.y = +Input.get_action_strength("aim_down") - Input.get_action_strength("aim_up")
	move_dir = -Input.get_action_strength("move_left") + Input.get_action_strength("move_right")
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump"):# and is_on_floor():
		velocity.y = JUMP_VELOCITY

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
	#$Node2D.rotate(shoot_dir.angle())
	$Node2D.look_at(get_global_mouse_position())

func shoot():
	var bullet = bulletPath.instantiate()
	get_parent().add_child(bullet)
	bullet.position = $Node2D/Marker2D.global_position
	bullet.bullet_velocity = shoot_dir * 500
