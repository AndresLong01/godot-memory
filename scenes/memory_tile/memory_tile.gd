extends TextureButton

class_name MemoryTile

@onready var frame_image = $FrameImage
@onready var item_image = $ItemImage

var item_name: String
var can_select: bool = true

func _ready():
	SignalManager.on_selection_disabled.connect(on_selection_disabled)
	SignalManager.on_selection_enabled.connect(on_selection_enabled)

func get_item_name() -> String:
	return item_name

func reveal(state: bool) -> void:
	frame_image.visible = state
	item_image.visible = state

func setup(dict: Dictionary, image: CompressedTexture2D) -> void:
	frame_image.texture = image
	item_image.texture = dict.item_texture
	item_name = dict.item_name
	reveal(false)

func kill_on_success() -> void:
	z_index = 1
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "disabled", true, 0)
	tween.tween_property(self, "rotation", deg_to_rad(720), .5)
	tween.tween_property(self, "scale", Vector2(1.5, 1.5), .5)
	tween.set_parallel(false)
	tween.tween_interval(0.6)
	tween.tween_property(self, "scale", Vector2(0, 0), 0)

func on_selection_disabled() -> void:
	can_select = false

func on_selection_enabled() -> void:
	can_select = true

func _on_pressed():
	if can_select == true:
		SignalManager.on_tile_selected.emit(self)
