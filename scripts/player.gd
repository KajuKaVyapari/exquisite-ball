extends RigidBody2D


var gravity = 15
var gravity_direction = "down"


func _ready():
	
	get_parent().get_node("past_tilemap").visible = false


func _physics_process(delta):
	
	# Gravity Switching
	if Input.is_action_just_pressed("ui_down"):
		gravity_direction = "down"
		Physics2DServer.area_set_param(get_world_2d().space, Physics2DServer.AREA_PARAM_GRAVITY_VECTOR, Vector2.DOWN)
	elif Input.is_action_just_pressed("ui_up"):
		Physics2DServer.area_set_param(get_world_2d().space, Physics2DServer.AREA_PARAM_GRAVITY_VECTOR, Vector2.UP)
	elif Input.is_action_just_pressed("ui_left"):
		gravity_direction = "left"
		Physics2DServer.area_set_param(get_world_2d().space, Physics2DServer.AREA_PARAM_GRAVITY_VECTOR, Vector2.LEFT)
	elif Input.is_action_just_pressed("ui_right"):
		gravity_direction = "right"
		Physics2DServer.area_set_param(get_world_2d().space, Physics2DServer.AREA_PARAM_GRAVITY_VECTOR, Vector2.RIGHT)
	
	
	if Input.is
