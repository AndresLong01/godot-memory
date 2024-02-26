extends Node

var item_images: Array = []

# Called when the node enters the scene tree for the first time.
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
