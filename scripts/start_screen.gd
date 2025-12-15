extends CanvasLayer


@onready var endless_button: Button = $EndlessButton


var game_state: GameManager.State


func _ready() -> void:
	game_state = GameManager.get_game_state()
	if game_state == GameManager.State.MENU_START:
		endless_button.hide()
	elif game_state == GameManager.State.MENU_PLAYED:
		endless_button.show()


func _on_play_button_pressed() -> void:
	GameManager.start_game_timed()


func _on_endless_button_pressed() -> void:
	GameManager.start_game_endless()
