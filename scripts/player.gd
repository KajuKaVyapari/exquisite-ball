extends RigidBody2D


onready var present_tilemap = get_parent().get_node("present_tilemap")
onready var past_tilemap = get_parent().get_node("past_tilemap")
onready var present_tween = get_parent().get_node("present_tilemap/tilemap_tween")
onready var past_tween = get_parent().get_node("past_tilemap/tilemap_tween")

var gravity_direction = "down"
var time = "present"


func _ready():
	
	past_tilemap.modulate = Color("#00ffffff")


func _physics_process(delta):
	
	# Gravity Switching
	if Input.is_action_just_pressed("ui_down"):
		gravity_direction = "down"
		apply_central_impulse(Vector2.DOWN * 50)
		Physics2DServer.area_set_param(get_world_2d().space, Physics2DServer.AREA_PARAM_GRAVITY_VECTOR, Vector2.DOWN)
	elif Input.is_action_just_pressed("ui_up"):
		gravity_direction = "up"
		apply_central_impulse(Vector2.UP * 50)
		Physics2DServer.area_set_param(get_world_2d().space, Physics2DServer.AREA_PARAM_GRAVITY_VECTOR, Vector2.UP)
	elif Input.is_action_just_pressed("ui_left"):
		gravity_direction = "left"
		apply_central_impulse(Vector2.LEFT * 50)
		Physics2DServer.area_set_param(get_world_2d().space, Physics2DServer.AREA_PARAM_GRAVITY_VECTOR, Vector2.LEFT)
	elif Input.is_action_just_pressed("ui_right"):
		apply_central_impulse(Vector2.RIGHT * 50)
		gravity_direction = "right"
		Physics2DServer.area_set_param(get_world_2d().space, Physics2DServer.AREA_PARAM_GRAVITY_VECTOR, Vector2.RIGHT)
	
	
	if Input.is_action_just_pressed("rewind"):
		
		
		# Rewind Mechanic
		
		Engine.time_scale = 0.8
		
		if time == "present":
			collision_layer = 4
			present_tween.interpolate_property(present_tilemap, "modulate", present_tilemap.modulate, Color("#00ffffff"), 1)
			past_tween.interpolate_property(past_tilemap, "modulate", past_tilemap.modulate, Color("#ffffff"), 1)
			present_tween.start()
			past_tween.start()
			time = "past"
		
		elif time == "past":
			collision_layer = 2
			present_tween.interpolate_property(present_tilemap, "modulate", present_tilemap.modulate, Color("#ffffff"), 1)
			past_tween.interpolate_property(past_tilemap, "modulate", past_tilemap.modulate, Color("#00ffffff"), 1)
			present_tween.start()
			past_tween.start()
			time = "present"


func _on_tilemap_tween_tween_completed():
	Engine.time_scale = 1
