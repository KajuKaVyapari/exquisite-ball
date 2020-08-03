extends Area2D

export(String, FILE) var scene_to_load


func _on_win_object_body_entered(body):
	if body.name == "player":
		get_tree().change_scene(scene_to_load)
