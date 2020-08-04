extends Area2D

export(String, FILE) var scene_to_load


func _on_win_object_body_entered(body):
	if body.is_in_group("box"):
		body.queue_free()
	yield(get_tree(), "idle_frame")
	if not get_tree().has_group("box"):
		get_tree().change_scene(scene_to_load)
