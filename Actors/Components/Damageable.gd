class_name Damageable extends Node

signal has_died
signal has_taken_damage(updated_hp: int)

enum EdamageableType {
	NONE,
	PLAYER,
	ENEMY,
	BOSS,
}

@export_category("Meta")
@export var _type: EdamageableType = EdamageableType.NONE
@export var _collision_area: Area3D

@export_category("Damage Info")
@export var _max_hp: int = 10
@export var _invincibility_period: float = .25

var _damage: int = 0
var _timer: Timer

func _enter_tree():
	_timer = Timer.new()
	_timer.one_shot = true
	add_child(_timer, false, Node.INTERNAL_MODE_BACK)

func _exit_tree():
	remove_child(_timer)
	_timer.queue_free()

func _ready():
	if _type == EdamageableType.PLAYER:
		connect_with_hud()
	_collision_area.area_entered.connect(_on_attack_received)

func _physics_process(delta):
	check_for_death()

func connect_with_hud():
	Hud.update_hp_bar_max_hp(self._max_hp)
	Hud.update_hp_bar(self.get_hp())
	has_taken_damage.connect(Hud.update_hp_bar)

func take_damage(amount: int):
	self._damage = clamp(self._damage + amount, 0, self._max_hp)
	emit_signal(has_taken_damage.get_name(), get_hp())

func check_for_death():
	if get_hp() <= 0:
		emit_signal("has_died")

func is_invincible():
	return !_timer.is_stopped()
	
func start_invincibility():
	_timer.start(_invincibility_period)

func get_hp() -> int:
	return self._max_hp - self._damage

func _on_attack_received(area: Area3D):
	# TBD: check if area is hostile
	if is_invincible():
		return
	start_invincibility()
	take_damage(1)

func _on_physical_contact(body: PhysicsBody3D):
	# TBD: check if body is solid (i.e. map boundaries)
	if is_invincible():
		return
	start_invincibility()
	take_damage(3)
	if _type == EdamageableType.PLAYER:
		Hud.flash(1, .1, Color(0, 0, 0, .5))
