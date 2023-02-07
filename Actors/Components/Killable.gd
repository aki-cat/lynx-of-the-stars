class_name Killable extends Node

enum EDeathType {
	INVALID,
	PLAYER,
	FIGHTER,
	ASTEROID,
}

@export
var _type: EDeathType = EDeathType.INVALID

@export
var _hp: HP

func _ready():
	pass
