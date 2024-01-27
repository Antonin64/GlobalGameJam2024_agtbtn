extends Sprite2D

func Kill():
	$"../GPUParticles2D".emitting = true
	queue_free()

func _on_area_2d_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	emit_signal("mine_exploded")
	Kill()
