extends CharacterBody2D

@onready var path_follow = get_parent()
@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")

@export var speed = 0

var player = null
var last_position = 0

func get_animation_for(direction: Vector2):
	if direction.x < 0:
		scale.x = 1
	if direction.x > 0:
		scale.x = -1

func _ready():
	player = get_node("../../../../../CharacterBody2D")
	state_machine.start("fly", true)
	last_position = global_position

func _process(_delta):
	if state_machine.get_current_node() == "End":
		queue_free()
	get_animation_for(last_position - global_position)
	last_position = global_position

func _physics_process(delta):
	get_parent().set_progress(get_parent().get_progress() + speed * delta)


func _on_area_2d_body_entered(body):
	if body == player:
		player.die()
