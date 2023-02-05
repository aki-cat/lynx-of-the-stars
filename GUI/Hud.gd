extends Control

@export
var hp_bar: ProgressBar

@export
var overlay: ColorRect

var _timer: Timer = Timer.new()

func _ready():
	_timer.one_shot = true
	add_child(_timer, false, Node.INTERNAL_MODE_BACK)

func update_hp_bar(hp: int):
	hp_bar.value = hp

func update_hp_bar_max_hp(max_hp: int):
	hp_bar.max_value = max_hp

func flash(times: int, interval: float, color: Color = Color.WHITE_SMOKE):
	overlay.color = color
	for i in range(times):
		overlay.visible = true
		_timer.start(interval)
		await(_timer.timeout)
		overlay.visible = false
		_timer.start(interval)
		await(_timer.timeout)
