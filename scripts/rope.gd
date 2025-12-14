extends Node2D


@onready var line: Line2D = $Line2D
@onready var joints: Array[PinJoint2D] = [
	$Segments/RigidBody2D/PinJoint2D,
	$Segments/RigidBody2D2/PinJoint2D2,
	$Segments/RigidBody2D3/PinJoint2D3,
	$Segments/RigidBody2D4/PinJoint2D4,
	$Segments/RigidBody2D4/PinJoint2D5
]

func _process(_delta: float) -> void:
	var points: PackedVector2Array = PackedVector2Array()

	for joint in joints:
		points.append(joint.global_position)

	line.global_position = Vector2.ZERO
	line.points = get_smooth_points(points)


func get_smooth_points(
	_points: PackedVector2Array,
	resolution: int = 10,
	extrapolate_end_points: bool = true
) -> PackedVector2Array:
	var points: PackedVector2Array = _points.duplicate()

	if extrapolate_end_points:
		points.insert(0, points[0] - (points[1] - points[0]))
		points.append(points[-1] + (points[-1] - points[-2]))

	if points.size() < 4:
		return points

	var smooth_points: PackedVector2Array = PackedVector2Array()

	for i in range(1, points.size() - 2):
		var p: PackedVector2Array = PackedVector2Array()
		for j in range(-1, 3):
			p.append(points[i + j])

		for k in resolution:
			var t: PackedFloat32Array = PackedFloat32Array([k, 0, 0, 0])
			t[1] = t[0] / resolution
			t[2] = t[1] ** 2
			t[3] = t[1] ** 3

			var q: Vector2 = 0.5 * (
				(2.0 * p[1])
				+ (-p[0] + p[2]) * t[1]
				+ (2.0 * p[0] - 5.0 * p[1] + 4 * p[2] - p[3]) * t[2]
				+ (-p[0] + 3.0 * p[1] - 3.0 * p[2] + p[3]) * t[3]
			)

			smooth_points.append(q)

	return smooth_points
