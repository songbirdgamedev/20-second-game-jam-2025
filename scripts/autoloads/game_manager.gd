extends Node


enum State {
	MENU_START,
	PLAYING_20,
	PLAYING_ENDLESS,
	GAME_OVER_LOSE,
	GAME_OVER_WIN,
	MENU_PLAYED
}

var game_state: State
var time_left: float


func _ready() -> void:
	game_state = State.MENU_START


func get_game_state() -> State:
	return game_state


func start_game_timed() -> void:
	game_state = State.PLAYING_20
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func start_game_endless() -> void:
	game_state = State.PLAYING_ENDLESS
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func end_game() -> void:
	if time_left == 0:
		game_state = State.GAME_OVER_LOSE
	else:
		game_state = State.GAME_OVER_WIN
	get_tree().call_deferred("change_scene_to_file", "res://scenes/game_over.tscn")


func show_menu() -> void:
	game_state = State.MENU_PLAYED
	get_tree().change_scene_to_file("res://scenes/start_screen.tscn")
