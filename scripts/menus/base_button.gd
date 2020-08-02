extends Button


export(PackedScene) var scene_to_load


func _on_base_button_pressed():
	get_tree().change_scene_to(scene_to_load)
