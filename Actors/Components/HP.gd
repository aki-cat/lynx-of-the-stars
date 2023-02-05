extends Node

signal has_died
signal has_taken_damage(updated_hp: int)

@export
var invincibility_period: float = .5

@export
var max_hp: int = 10
var damage: int = 0

@onready
var _timer := Timer.new()

func _ready():
	add_child(_timer, false, Node.INTERNAL_MODE_BACK)
	_timer.stop()
	_timer.one_shot = true
	Hud.update_hp_bar_max_hp(self.max_hp)
	Hud.update_hp_bar(self.get_hp())
	has_taken_damage.connect(Hud.update_hp_bar)

func take_damage(amount: int):
	self.damage = clamp(self.damage + amount, 0, self.max_hp)
	emit_signal(has_taken_damage.get_name(), get_hp())

func check_for_death():
	if get_hp() <= 0:
		emit_signal(has_died.get_name())

func get_hp() -> int:
	return self.max_hp - self.damage

func _on_physical_contact(normal: Vector3):
	if !_timer.is_stopped():
		return
	_timer.start(invincibility_period)
	self.owner.velocity += normal * 512
	take_damage(3)
	Hud.flash(3, .05, Color(.9, .25, .25, .75))
