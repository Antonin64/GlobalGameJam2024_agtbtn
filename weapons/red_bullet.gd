extends CharacterBody2D

var bullet_velocity = Vector2(1, 0)
var speed =  450
var playerPath = "../../../Node2D/Player"

func _ready():
	$fire_poop/AnimationPlayer.play("fire_anim", -1, 1, false)

func _physics_process(delta):
	var collision_info = move_and_collide(bullet_velocity.normalized() * delta * speed)

func _on_area_2d_body_entered(body):
	if body == get_node(playerPath):
		get_node(playerPath).die()
