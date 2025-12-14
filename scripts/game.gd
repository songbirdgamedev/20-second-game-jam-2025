extends Node2D


@onready var cup: AnimatableBody2D = $Cup
@onready var ball: RigidBody2D = $Ball
@onready var rope: Node2D = $Rope


func _ready() -> void:
	rope.joints[0].node_a = cup.get_path()
	rope.joints[-1].node_b = ball.get_path()
