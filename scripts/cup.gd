extends AnimatableBody2D


var dragging: bool = false
var offset: Vector2 = Vector2.ZERO


func _process(_delta: float) -> void:
	if dragging:
		global_position = get_global_mouse_position() - offset


func _on_button_down() -> void:
	dragging = true
	offset = get_global_mouse_position() - get_global_position()


func _on_button_up() -> void:
	dragging = false
