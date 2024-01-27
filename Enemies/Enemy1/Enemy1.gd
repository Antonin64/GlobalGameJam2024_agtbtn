extends CharacterBody2D

@onready var path_follow = get_parent()
@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")

@export var speed = 0

func _ready():
	state_machine.start("fly", true)

func _process(delta):
	if state_machine.get_current_node() == "End":
		queue_free()

func _physics_process(delta):
	get_parent().set_progress(get_parent().get_progress() + speed * delta)
