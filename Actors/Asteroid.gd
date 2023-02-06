extends RigidBody3D

@export
var scales: PackedFloat32Array

func _ready():
	var idx: int = randi_range(0, scales.size() - 1)
	for c in get_children():
		var child := c as Node3D
		if child:
			child.scale_object_local(Vector3.ONE * scales[idx])
