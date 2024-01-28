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
		animation.play("animate")
		await get_tree().create_timer(0.1).timeout
		player.jump_pad_left(rotation_degrees)
		timer.start()