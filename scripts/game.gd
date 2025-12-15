extends Node2D


@onready var cup: AnimatableBody2D = $Cup
@onready var ball: RigidBody2D = $Ball
@onready var rope: Node2D = $Rope
@onready var time_left: Label = $TimeLeft
@onready var timer: Timer = $Timer
@onready var points: Label = $Points
@onready var menu_button: Button = $MenuButton
@onready var win_area: Area2D = $Cup/WinArea


var game_state: GameManager.State
var win_count: int = 0


func _ready() -> void:
	game_state = GameManager.get_game_state()

	if game_state == GameManager.State.PLAYING_20:
		time_left.show()
		points.hide()
		menu_button.hide()
	elif game_state == GameManager.State.PLAYING_ENDLESS:
		time_left.hide()
		points.show()
		menu_button.show()
		points.text = "0"

	rope.joints[0].node_a = cup.get_path()
	rope.joints[-1].node_b = ball.get_path()


func _process(_delta: float) -> void:
	if game_state == GameManager.State.PLAYING_20:
		time_left.text = str(snappedf(timer.time_left, 0.1))
	
	if timer.time_left == 0:
		GameManager.time_left = timer.time_left
		GameManager.end_game()


func _on_win_area_body_entered(_body: Node2D) -> void:
	await get_tree().create_timer(0.75).timeout
	if not win_area.has_overlapping_bodies():
		return
	win_count += 1
	timer.paused = true
	# show confetti
	if game_state == GameManager.State.PLAYING_20:
		GameManager.time_left = timer.time_left + 0.75
		GameManager.end_game()
	elif game_state == GameManager.State.PLAYING_ENDLESS:
		points.text = str(win_count)
		


func _on_menu_button_pressed() -> void:
	GameManager.show_menu()
