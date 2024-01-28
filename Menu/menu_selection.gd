extends Control


func _ready():
	$Menu/ButtonsContainer/Didactitiel.grab_focus()

func _on_didactitiel_pressed():
	Global.scene = "res://map/didac_map.tscn"
	Global.launch_next_map()


func _on_level_1_pressed():
	Global.scene = "res://map/niveau_med.tscn"
	Global.launch_next_map()


func _on_level_2_pressed():
	Global.scene = "res://map/Maptuto.tscn"
	Global.launch_next_map()


func _on_boss_pressed():
	Global.scene = "res://map/mapbosscopiedencule.tscn"
	Global.launch_next_map()
