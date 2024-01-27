extends Sprite2D

func _ready():
	await get_tree().create_timer(1).timeout
	Kill()

func Kill():
	$"../GPUParticles2D".emitting = true
	queue_free()
