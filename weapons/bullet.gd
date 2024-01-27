extends CharacterBody2D

var bullet_velocity = Vector2(1, 0)
var speed =  300

func _physics_process(delta):
	var collision_info = move_and_collide(bullet_velocity.normalized() * delta * speed)
