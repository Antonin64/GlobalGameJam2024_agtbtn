extends Node2D

var player = null

@export var player_path = "../../CharacterBody2D"
@onready var animation = $Sprite2D/AnimationPlayer
@onready var timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node(player_path)
	

func Kill():
	pass

func _on_area_2d_body_entered(body):
	if body == player && timer.is_stopped():
		timer.start()
		var jumpDir = Vector2(0, -1).rotated(deg_to_rad(rotation_degrees))
		var velocity = jumpDir.normalized()
		player.velocity.y = velocity.y * 500
		print(velocity)
		player.dash(velocity.x * 4)
		$AudioStreamPlayer2D.play()
		animation.play("animate")
