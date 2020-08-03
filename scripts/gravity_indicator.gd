extends Sprite


onready var tween = $gravity_indicator_tween

export var time = 1


func rotate_with_tween(degree):
	tween.interpolate_property(self, "rotation_degrees", rotation_degrees, degree, time, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	tween.start()
