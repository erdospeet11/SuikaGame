extends Node2D

# Declare an array to hold the PackedScenes
var packed_scenes : Array

# Called when the node enters the scene tree for the first time
func _ready():
	# Load your scenes into the array
	packed_scenes = [
		preload("res://red.tscn"),
		preload("res://green.tscn"),
		preload("res://blue.tscn"),
		preload("res://yellow.tscn")
	]
	print("Packed scenes loaded: ", packed_scenes.size())

	# Initialize the global score label
	Global.score_label = $CanvasLayer/Score

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("place"):
		instantiate_random_scene()

# Function to instantiate a random PackedScene
func instantiate_random_scene():
	if packed_scenes.size() > 0:
		var random_index = randi() % packed_scenes.size()
		var scene_instance = packed_scenes[random_index].instantiate()
		add_child(scene_instance)
		# Optionally set the position of the instance to where the mouse clicked
		scene_instance.position = get_global_mouse_position()
		print("Instantiated scene: ", random_index)
