extends Node2D

var player = null

@export var player_path = "../CharacterBody2D"

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node(player_path)

func Kill():
	queue_free()

func _on_area_2d_body_entered(body):
	print("b")
	if body == player:
		player.die()
	Kill()
