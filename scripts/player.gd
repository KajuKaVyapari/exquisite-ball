extends RigidBody2D


onready var present_items = get_parent().get_node("present_items")
onready var past_items = get_parent().get_node("past_items")
onready var present_tween = get_parent().get_node("present_items/present_tilemap/tilemap_tween")
onready var past_tween = get_parent().get_node("past_items/past_tilemap/tilemap_tween")
onready var gravity_indicator = get_parent().get_node("gravity_indicator")
onready var level_indicator = get_parent().get_node("level_indicator")

var gravity_direction = "down"
var time = "present"


func _ready():
	
	past_items.modulate = Color("#00ffffff")
	Physics2DServer.area_set_param(get_world_2d().space, Physics2DServer.AREA_PARAM_GRAVITY_VECTOR, Vector2.DOWN)
	get_parent().get_node("time_indicator").text = time.capitalize()
	
	var level_name = get_tree().get_current_scene().get_name().replace("_", " ").capitalize()
	level_indicator.text  = level_name
	


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

			present_tween.interpolate_property(present_items, "modulate", present_items.modulate, Color("#00ffffff"), .5)
			past_tween.interpolate_property(past_items, "modulate", past_items.modulate, Color("#ffffff"), .5)
			present_tween.start()
			past_tween.start()
			time = "past"
		
		elif time == "past":
			collision_layer = 2
			present_tween.interpolate_property(present_items, "modulate", present_items.modulate, Color("#ffffff"), .5)
			past_tween.interpolate_property(past_items, "modulate", past_items.modulate, Color("#00ffffff"), .5)
			present_tween.start()
			past_tween.start()
			time = "present"
		get_parent().get_node("time_indicator").text = time.capitalize()
		
		for box in get_tree().get_nodes_in_group("box"):
			box.collision_layer = collision_layer


func _on_tilemap_tween_tween_completed():
	Engine.time_scale = 1
