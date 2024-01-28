extends Node2D

var is_open = false
var player = null
@onready var timer = $Timer
@onready var animation = $Sprite2D/AnimationPlayer
@export var player_path = "../../CharacterBody2D"
@export var open_timer = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node(player_path)
	timer.wait_time = open_timer
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !animation.is_playing():
		animation.play("idle")
		if timer.is_stopped():
			timer.start()
			is_open = false


func _on_area_2d_body_entered(body):
	if !is_open && body == player:
		player.die()

func _on_area_2_dopen_body_entered(body):
	if is_open && body == player:
		player.die()


func _on_timer_timeout():
	$AudioStreamPlayer2D.play()
	timer.stop()
	is_open = true
	animation.play("move")
