extends Control

@export var level_button_scene: PackedScene

@onready var hb_levels = $VBoxContainer/HBLevels

func _ready():
	setup_grid()

func create_level_button(level: int) -> void:
	var new_button = level_button_scene.instantiate()
	hb_levels.add_child(new_button)
	new_button.set_level_number(level)

func setup_grid() -> void:
	for level in GameManager.LEVELS:
		create_level_button(level)
