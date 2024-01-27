extends CharacterBody2D

var player = null

@onready var path_follow = get_parent()
@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")

@export var speed = 0

func _ready():
	player = get_node("../../../../../CharacterBody2D")
	state_machine.start("walk", true)

func _process(delta):
	pass

func _physics_process(delta):
	get_parent().set_progress(get_parent().get_progress() + speed * delta)

func _on_area_2d_body_entered(body):
	if body == player:
		player.die()
