extends CanvasLayer


@onready var label: Label = $Label

var game_state: GameManager.State


func _ready() -> void:
	game_state = GameManager.get_game_state()
	if game_state == GameManager.State.GAME_OVER_LOSE:
		label.text = "GAME OVER
		Try again?"
	elif game_state == GameManager.State.GAME_OVER_WIN:
		label.text = "Congratulations! 
		" + str(snappedf(GameManager.time_left, 0.01)) + "s left!"


func _on_play_button_pressed() -> void:
	GameManager.start_game_timed()


func _on_endless_button_pressed() -> void:
	GameManager.start_game_endless()
