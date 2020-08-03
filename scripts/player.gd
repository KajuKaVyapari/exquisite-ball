extends RigidBody2D


onready var present_tilemap = get_parent().get_node("present_tilemap")
onready var past_tilemap = get_parent().get_node("past_tilemap")
onready var present_tween = get_parent().get_node("present_tilemap/tilemap_tween")
onready var past_tween = get_parent().get_node("past_tilemap/tilemap_tween")
onready var gravity_indicator = get_parent().get_node("gravity_indicator")

var gravity_direction = "down"
var time = "present"


func _ready():
	
	past_tilemap.modulate = Color("#00ffffff")
	Physics2DServer.area_set_param(get_world_2d().space, Physics2DServer.AREA_PARAM_GRAVITY_VECTOR, Vector2.DOWN)
	get_parent().get_node("time_indicator").text = time.capitalize()


func _physics_process(delta):
	
	# Gravity Switching
	if Input.is_action_just_pressed("ui_down") and not gravity_direction == "down":
		gravity_direction = "down"
		apply_central_impulse(Vector2.DOWN * 5)
		Physics2DServer.area_set_param(get_world_2d().space, Physics2DServer.AREA_PARAM_GRAVITY_VECTOR, Vector2.DOWN)
		gravity_indicator.rotate_with_tween(90)
	elif Input.is_action_just_pressed("ui_up") and not gravity_direction == "up":
		gravity_direction = "up"
		apply_central_impulse(Vector2.UP * 5)
		Physics2DServer.area_set_param(get_world_2d().space, Physics2DServer.AREA_PARAM_GRAVITY_VECTOR, Vector2.UP)
		gravity_indicator.rotate_with_tween(-90)
	elif Input.is_action_just_pressed("ui_left") and not gravity_direction == "left":
		gravity_direction = "left"
		apply_central_impulse(Vector2.LEFT * 5)
		Physics2DServer.area_set_param(get_world_2d().space, Physics2DServer.AREA_PARAM_GRAVITY_VECTOR, Vector2.LEFT)
		gravity_indicator.rotate_with_tween(180)
	elif Input.is_action_just_pressed("ui_right") and not gravity_direction == "right":
		apply_central_impulse(Vector2.RIGHT * 5)
		gravity_direction = "right"
		Physics2DServer.area_set_param(get_world_2d().space, Physics2DServer.AREA_PARAM_GRAVITY_VECTOR, Vector2.RIGHT)
		gravity_indicator.rotate_with_tween(0)
	
	
	if Input.is_action_just_pressed("rewind"):
		
		
		# Rewind Mechanic
		
		Engine.time_scale = 0.8
		
		if time == "present":
			collision_layer = 4
			present_tween.interpolate_property(present_tilemap, "modulate", present_tilemap.modulate, Color("#00ffffff"), .5)
			past_tween.interpolate_property(past_tilemap, "modulate", past_tilemap.modulate, Color("#ffffff"), .5)
			present_tween.start()
			past_tween.start()
			time = "past"
		
		elif time == "past":
			collision_layer = 2
			present_tween.interpolate_property(present_tilemap, "modulate", present_tilemap.modulate, Color("#ffffff"), .5)
			past_tween.interpolate_property(past_tilemap, "modulate", past_tilemap.modulate, Color("#00ffffff"), .5)
			present_tween.start()
			past_tween.start()
			time = "present"
		get_parent().get_node("time_indicator").text = time.capitalize()


func _on_tilemap_tween_tween_completed():
	Engine.time_scale = 1
