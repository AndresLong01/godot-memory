extends Node

class_name Scorer

@onready var sound = $Sound
@onready var reveal_timer = $RevealTimer

var selections: Array = []
var target_pairs: int = 0
var moves_made: int = 0
var pairs_made: int = 0

func _ready():
	SignalManager.on_tile_selected.connect(on_tile_selected)
	SignalManager.on_game_exit_pressed.connect(on_game_exit_pressed)

func get_moves_made_str() -> String:
	return str(moves_made)

func get_pair_made_str() -> String:
	return '%s / %s' % [pairs_made, target_pairs]

func clear_new_game(total_pairs: int) -> void:
	selections.clear()
	pairs_made = 0
	moves_made = 0
	target_pairs = total_pairs

func selections_are_pair() -> bool:
	if selections[0].get_instance_id() == selections[1].get_instance_id():
		return false
	
	return  selections[0].get_item_name() == selections[1].get_item_name()

func kill_tiles() -> void:
	for selection in selections:
		selection.kill_on_success()
	
	pairs_made += 1
	SoundManager.play_sound(sound, SoundManager.SOUND_SUCCESS)

func update_selections() -> void:
	reveal_timer.start()
	if selections_are_pair() == true:
		kill_tiles()

func check_pair_made(tile: MemoryTile) -> void:
	selections.append(tile)
	
	if selections.size() != 2:
		return
	
	SignalManager.on_selection_disabled.emit()
	moves_made += 1
	
	update_selections()

func hide_selections() -> void:
	for selection in selections:
		selection.reveal(false)

func check_game_over() -> void:
	if pairs_made >= target_pairs:
		SignalManager.on_game_over.emit(moves_made)

func on_tile_selected(tile: MemoryTile) -> void:
	SoundManager.play_tile_click(sound)
	tile.reveal(true)
	check_pair_made(tile)

func _on_reveal_timer_timeout():
	if selections_are_pair() == false:	
		hide_selections()
	selections.clear()
	check_game_over()
	SignalManager.on_selection_enabled.emit()

func on_game_exit_pressed() -> void:
	reveal_timer.stop()
