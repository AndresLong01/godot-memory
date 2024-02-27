extends CanvasLayer

@onready var main_screen = $MainScreen
@onready var game_screen = $GameScreen
@onready var sound = $Sound

func _ready():
	#hacky but it just starts the game proper
	on_game_exit_pressed()
	SignalManager.on_game_exit_pressed.connect(on_game_exit_pressed)
	SignalManager.on_level_selected.connect(on_level_selected)

func show_game(state: bool) -> void:
	game_screen.visible = state
	main_screen.visible = !state

func on_game_exit_pressed() -> void:
	show_game(false)
	GameManager.clear_nodes_of_group(GameManager.GROUP_TILE)
	SoundManager.play_sound(sound, SoundManager.SOUND_MAIN_MENU)

func on_level_selected(level_num: int) -> void:
	show_game(true)
	SoundManager.play_sound(sound, SoundManager.SOUND_IN_GAME)
