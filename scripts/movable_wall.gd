extends Node2D


onready var all_tilemap = $all_tilemap
onready var wall_timer = $wall_timer
onready var wall_tween = $wall_tween


func _on_button_body_entered(body):
	all_tilemap.collision_mask = 0
	wall_tween.interpolate_property(all_tilemap, "modulate", Color("#fffffff"), Color("#00ffffff"), .5, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	wall_tween.start()


func _on_button_body_exited(body):
	wall_timer.start()


func _on_wall_timer_timeout():
	all_tilemap.collision_mask = 7
	wall_tween.interpolate_property(all_tilemap, "modulate", Color("#00ffffff"), Color("#ffffff"), .5, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	wall_tween.start()
