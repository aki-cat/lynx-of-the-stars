extends Node

@export
var base_speed: float = 20

@export
var fast_speed: float = 30

@export
var slow_speed: float = 10

@export
var acceleration: float = 10

@onready
var body: CharacterBody3D = self.owner as CharacterBody3D

@onready
var speed: float = base_speed

func _physics_process(delta: float):
	self.body.translate(Vector3.FORWARD * self.speed * delta)
	if Input.is_action_pressed("ACTION_ACCELERATE"):
		print("Accelerate")
		self.speed = lerpf(self.speed, self.fast_speed, delta * acceleration)
	elif Input.is_action_pressed("ACTION_BREAK"):
		print("Break")
		self.speed = lerpf(self.speed, self.slow_speed, delta * acceleration)
	else:
		self.speed = lerpf(self.speed, self.base_speed, delta * acceleration)
