extends Node

const FRAME_IMAGES: Array = [
	preload("res://assets/frames/blue_frame.png"),
	preload("res://assets/frames/green_frame.png"),
	preload("res://assets/frames/red_frame.png"),
	preload("res://assets/frames/yellow_frame.png"),
]

var item_images: Array = []

func _ready():
	load_item_images()

func add_file_to_list(name: String, path: String) -> void:
	var item_dict = {
		"item_name": name.rsplit(".")[0],
		"item_texture": load(path + "/" + name)
	}
	
	item_images.append(item_dict)

func load_item_images() -> void:
	var path = "res://assets/glitch"
	var dir = DirAccess.open(path)
	
	if not dir:
		print("ERROR:", path)
		return
	
	var file_names = dir.get_files()
	
	for file in file_names:
		if ".import" not in file:
			add_file_to_list(file, path)

func get_random_item_image() -> Dictionary:
	return item_images.pick_random()

func get_image(index: int) -> Dictionary:
	return item_images[index]

func get_random_frame_image() -> CompressedTexture2D:
	return FRAME_IMAGES.pick_random()

func shuffle_images() -> void:
	item_images.shuffle()
