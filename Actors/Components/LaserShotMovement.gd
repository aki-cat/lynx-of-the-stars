class_name LaserShot extends Area3D

signal laser_died

@export
var speed: float = 10.0
@export
var lifetime: float = 2.0

func _ready():
	self.monitoring = true
	self.body_entered.connect(_collided)
	var timer = Timer.new()
	add_child(timer, false, Node.INTERNAL_MODE_BACK)
	timer.set_wait_time(lifetime)
	timer.start()
	timer.timeout.connect(die, CONNECT_ONE_SHOT)

func _physics_process(delta):
	self.translate(Vector3.FORWARD * delta * speed)

func die():
	var error := emit_signal(laser_died.get_name(), self)
	if error != OK:
		printerr(error_string(error))

func _collided(something):
	die()
