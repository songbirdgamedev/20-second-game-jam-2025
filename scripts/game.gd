extends Node2D


@onready var cup: AnimatableBody2D = $Cup
@onready var ball: RigidBody2D = $Ball
@onready var rope: Node2D = $Rope
@onready var time_left: Label = $TimeLeft
@onready var timer: Timer = $Timer


func _ready() -> void:
	rope.joints[0].node_a = cup.get_path()
	rope.joints[-1].node_b = ball.get_path()


func _process(delta: float) -> void:
	time_left.text = str(int(timer.time_left))
