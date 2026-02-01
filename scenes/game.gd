extends Control

@onready var label: Label = $CenterContainer/VBoxContainer/Word
@onready var transition_timer: Timer = $TransitionTimer
@onready var duration_label: Label = $CenterContainer/VBoxContainer/DurationLabel

var timestamp_word_shown: int
var duration: int

var selected_word: String

func _ready() -> void:
	_pick_word()

func _input(event):
	# if the timer is running, we mapped a key and the result is shown
	if not transition_timer.is_stopped():
		return
	var timestamp_key_pressed = Time.get_ticks_msec()
	if event is InputEventKey and event.pressed:
		if is_good_key(event):
			label.add_theme_color_override("font_color", Color.GREEN)
		else:
			label.add_theme_color_override("font_color", Color.RED)
		transition_timer.start()
		duration = timestamp_key_pressed - timestamp_word_shown
		duration_label.text = "%ds %dms" % [duration / 1000, duration % 1000]

func _pick_word() -> void:
	var words = ["Game", "Jens", "Michael", "The world would be a better place, if we all ate Tiramisu all day long."]
	selected_word = words[randi_range(0, len(words) - 1)]
	label.text = selected_word
	label.add_theme_color_override("font_color", Color.WHITE)
	timestamp_word_shown = Time.get_ticks_msec()
	duration_label.text = "Press a letter that's not in the word above."
	

func is_good_key(event: InputEventKey) -> bool:
	var physical_keycode = event.physical_keycode
	var key_string = OS.get_keycode_string(physical_keycode)
	var c = key_string.to_lower()
	if c in selected_word:
		return false
	else:
		return true

func _on_timer_timeout() -> void:
	_pick_word()
