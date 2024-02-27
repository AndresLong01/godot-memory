extends TextureButton

@onready var label = $Label
@onready var sound = $Sound

var level_number: int = 0;

func _ready():
	pass

func set_level_number(level: int) -> void:
	level_number = level
	var level_data = GameManager.LEVELS[level_number]
	label.text = "%sx%s" % [level_data.rows, level_data.cols]

func _on_pressed():
	SoundManager.play_button_click(sound)
	SignalManager.on_level_selected.emit(level_number)
