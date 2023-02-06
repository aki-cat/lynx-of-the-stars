class_name RigidShootable extends Node

@export_node_path("Node")
var _hp_path: NodePath

@onready
var _hp: HP = get_node(_hp_path) as HP

@export
var _body: RigidBody3D = self.owner as RigidBody3D

func _ready():
	_body.body_entered.connect(_hp.take_damage.bind(1))
	_hp.has_died.connect(self.die)

func die():
	self.owner.queue_free()
