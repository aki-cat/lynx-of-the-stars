class_name PlayerCamera extends Camera3D

@export
var _chase_speed: float = 10.0

@export
var _margin: Vector2i = Vector2i(10, 10)

@export
var _distance: float = 1.0

@export_node_path("Node3D")
var _target_path: NodePath

@onready
var _target: Node3D = get_node(_target_path) as Node3D

func _physics_process(delta: float):
	follow_distance(delta)
	follow_pan(delta)

func follow_distance(delta: float):
	var origin_z := self.global_transform.origin.z
	var target_z := _target.global_transform.origin.z + _distance
	origin_z += (target_z - origin_z) * delta * _chase_speed
	self.global_transform.origin.z = origin_z


func follow_pan(delta: float):
	var window_size := get_window().size
	var target_pos := unproject_position(_target.global_transform.origin)
	target_pos = target_pos.clamp(
		Vector2i.ONE * _margin,
		window_size - Vector2i.ONE * _margin
	)
	var world_pos := project_position(target_pos, _target.global_transform.origin.z)
	_target.global_transform = _target.global_transform.interpolate_with(
		_target.global_transform.translated(
			world_pos - _target.global_transform.origin
		), .25
	)
