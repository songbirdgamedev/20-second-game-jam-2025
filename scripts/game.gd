extends Node2D


@onready var cup: AnimatableBody2D = $Cup
@onready var ball: RigidBody2D = $Ball
@onready var rope: Node2D = $Rope
@onready var time_left: Label = $TimeLeft
@onready var timer: Timer = $Timer
@onready var menu_button: Button = $MenuButton
@onready var win_area: Area2D = $Cup/WinArea
@onready var win_delay: Timer = $WinDelay

var game_state: GameManager.State


func _ready() -> void:
	game_state = GameManager.get_game_state()

	if game_state == GameManager.State.PLAYING_20:
		time_left.show()
		menu_button.hide()
	elif game_state == GameManager.State.PLAYING_ENDLESS:
		time_left.hide()
		menu_button.show()

	rope.joints[0].node_a = cup.get_path()
	rope.joints[-1].node_b = ball.get_path()


func _process(_delta: float) -> void:
	if game_state == GameManager.State.PLAYING_20:
		time_left.text = str(snappedf(timer.time_left, 0.1))


func _on_win_area_body_entered(_body: Node2D) -> void:
	win_delay.start()
	await win_delay.timeout
	if not win_area.has_overlapping_bodies():
		return

	timer.paused = true
	if game_state == GameManager.State.PLAYING_20:
		GameManager.time_left = timer.time_left + win_delay.wait_time
		GameManager.end_game()


func _on_timer_timeout() -> void:
	if win_area.has_overlapping_bodies():
		GameManager.time_left = win_delay.wait_time - win_delay.time_left
	else:
		GameManager.time_left = timer.time_left
	GameManager.end_game()


func _on_menu_button_pressed() -> void:
	GameManager.show_menu()
