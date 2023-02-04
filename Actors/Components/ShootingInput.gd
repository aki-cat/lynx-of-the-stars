extends Node

@export_node_path("GPUParticles3D")
var cannon_left_path: NodePath
@export_node_path("GPUParticles3D")
var cannon_right_path: NodePath

@export
var laser_shot: PackedScene
@export
var shot_limit: int = 10

@onready
var cannon_left := get_node(cannon_left_path) as GPUParticles3D
@onready
var cannon_right := get_node(cannon_right_path) as GPUParticles3D
@onready
var tree := get_tree().root

var shot_count: int = 0;

func _unhandled_input(event: InputEvent):
	if event.is_action_pressed("ACTION_SHOOT") and shot_count <= shot_limit:
		push_shot()
		shoot_from_cannon(cannon_left)
		shoot_from_cannon(cannon_right)

func shoot_from_cannon(cannon: GPUParticles3D):
	var shot: LaserShot = laser_shot.instantiate()
	self.tree.add_child(shot, false, INTERNAL_MODE_BACK)
	shot.global_transform = cannon.global_transform
	shot.laser_died.connect(self.pop_shot, CONNECT_ONE_SHOT)
	cannon.restart()
	cannon.set_emitting(true)

func push_shot():
	shot_count += 2

func pop_shot(shot):
	shot.queue_free()
	shot_count -= 1
