extends CharacterBody2D

var bullet_velocity = Vector2(1, 0)
var speed =  300
var playerPath = "../../../Node2D/Player"

func _ready():
	$fire_poop/AnimationPlayer.play("fire_anim", -1, 1, false)

func _physics_process(delta):
	var collision_info = move_and_collide(bullet_velocity.normalized() * delta * speed)

func _on_area_2d_body_entered(body):
	print("boss hit")
	if body == get_node(playerPath):
		get_node(playerPath).die()

func _on_return_zone_body_entered(body):
	if body == get_node(playerPath) and get_node("../../../Node2D/Player/return_poop").is_playing():
		bullet_velocity = get_parent().global_position - self.global_position
		self.look_at(get_parent().global_position)
		$Area2D.set_collision_mask_value(6, true)

func _on_area_2d_area_entered(area):
	if area == get_node("../Boss/Area2D"):
		print("boss hit")
		get_parent().get_node("Boss").lose_hp()
