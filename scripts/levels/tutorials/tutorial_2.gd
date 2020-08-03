extends Node2D


var i = 0


func _on_tilemap_tween_started(object, key):
	if i == 0:
		get_node("hint_tween").interpolate_property(get_node("tutorial_2_hint3"), "modulate", Color("#00ffffff"), Color("#ffffff"), .5, Tween.TRANS_CUBIC, Tween.EASE_OUT)
		get_node("hint_tween").start()
		i += 1
