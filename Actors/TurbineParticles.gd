extends Node3D

@onready
var camera: Camera3D = get_tree().get_root().get_camera_3d()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	for node in self.get_children():
		var child: Node3D = (node as Node3D)
		child.look_at(camera.transform.origin, Vector3.UP)
