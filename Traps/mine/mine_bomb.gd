extends Sprite2D

var player = null
var particle = null
@export var player_path = "../../CharacterBody2D"

func _ready():
	player = get_node(player_path)

func Kill():
	$"../AudioStreamPlayer".play()
	$"../GPUParticles2D".emitting = true
	queue_free()

func _on_area_2d_body_entered(body):
	Kill()
	if body == player:
		player.die()
