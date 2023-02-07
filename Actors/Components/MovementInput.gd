extends Node

const ANGLE_TILT := PI * 0.25
const TRANSFORM_INTERPOLATION := 0.25

signal collided_with_body(collision: PhysicsBody3D)

@export
var handling: float = 20.0
@export
var planar_speed: float = 40.0

@onready
var body: CharacterBody3D = owner

# attributes
var _steering: Vector2 = Vector2.ZERO

func _physics_process(delta: float):
	var steer_input := get_steering_input()
	update_steering(steer_input, delta)
	set_steering_angle()
	move_body(delta)

func get_steering_input() -> Vector2:
	var steer_input := Vector2.ZERO;
	steer_input.x =\
		Input.get_action_strength("STEER_RIGHT") \
		- Input.get_action_strength("STEER_LEFT")
	steer_input.y =\
		Input.get_action_strength("STEER_DOWN") \
		- Input.get_action_strength("STEER_UP")
	if steer_input.length_squared() > 1:
		steer_input = steer_input.normalized()
	return steer_input

func update_steering(steer_input: Vector2, delta: float):
	self._steering += (steer_input - self._steering) * delta * handling
	if self._steering.length_squared() > 1:
		self._steering = self._steering.normalized()
	self._steering = self._steering * 0.9 # decay

func set_steering_angle():
	var target_transform = self.body.transform.looking_at(
		self.body.transform.origin + Vector3(self._steering.x, self._steering.y, -2),
		Vector3.UP.rotated(Vector3.BACK, -self._steering.x * ANGLE_TILT)
	)
	self.body.transform = self.body.transform.interpolate_with(
		target_transform,
		TRANSFORM_INTERPOLATION
	)

func move_body(delta: float):
	# self.body.move_and_collide(
	# 	Vector3(self._steering.x, self._steering.y, 0) * self.planar_speed * delta
	# )
	self.body.velocity += Vector3(self._steering.x, self._steering.y, 0) * self.planar_speed * 10 * delta
	self.body.velocity *= 0.9
	if self.body.move_and_slide():
		var collision: KinematicCollision3D = self.body.get_last_slide_collision()
		var collision_normal: Vector3 = collision.get_normal(0)
		emit_signal(collided_with_body.get_name(), collision.get_collider(0))
		self.owner.velocity += collision_normal * 256
