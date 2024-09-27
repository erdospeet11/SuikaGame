extends Node2D

# Declare an array to hold the PackedScenes
var packed_scenes : Array
var not_spawned : bool 

@onready var boss_scene = preload("res://boss.tscn")

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
	if Global.score_label.value >= 500 and not_spawned == false:
		boss_scene.instantiate()
	
	if Input.is_action_just_pressed("place"):
		instantiate_random_scene()

# Function to instantiate a random PackedScene
func instantiate_random_scene():
	if packed_scenes.size() > 0:
		var random_index = randi() % packed_scenes.size()
		var scene_instance = packed_scenes[random_index].instantiate()
		add_child(scene_instance)
		# Optionally set the position of the instance to where the mouse clicked
		var pposition = get_global_mouse_position()
		scene_instance.position = Vector2(pposition.x, 45)
		print("Instantiated scene: ", random_index)
