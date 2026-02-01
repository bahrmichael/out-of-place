extends Control

@onready var label: Label = $CenterContainer/VBoxContainer/Word
@onready var transition_timer: Timer = $TransitionTimer
@onready var duration_label: Label = $CenterContainer/VBoxContainer/DurationLabel
@onready var analytics_request: HTTPRequest = $AnalyticsRequest


const ANALYTICS_URL = "https://webhook.site/8ba3c7f5-8ee4-49e5-bb2c-35e7cfc5df68"

var session_id = "%s" % [Time.get_datetime_string_from_system()]

var timestamp_word_shown: int
var duration: int

var selected_word: String

func _ready() -> void:
	_pick_word()

func _input(event):
	if event is InputEventKey and event.pressed:
		# if the timer is running, we mapped a key and the result is shown
		if not transition_timer.is_stopped():
			return
		var timestamp_key_pressed = Time.get_ticks_msec()
		var character = get_character(event)
		var correct = character not in selected_word
		if correct:
			label.add_theme_color_override("font_color", Color.GREEN)
		else:
			label.add_theme_color_override("font_color", Color.RED)
		transition_timer.start()
		duration = timestamp_key_pressed - timestamp_word_shown
		duration_label.text = "%ds %dms" % [duration / 1000, duration % 1000]
		
		var request_data = {
			"word": selected_word,
			"duration": duration,
			"correct": correct,
			"session_id": session_id,
			"character": character
		}
		analytics_request.request(ANALYTICS_URL, [], HTTPClient.METHOD_POST, JSON.stringify(request_data))

func _pick_word() -> void:
	var words = ["Random", "Rhythm", "Godot", "Play", "Zoo", "Party", "Animals", "Penguin", "Game", "Jens", "Michael", "The world would be a better place, if we all ate Tiramisu all day long."]
	selected_word = words[randi_range(0, len(words) - 1)]
	label.text = selected_word
	label.add_theme_color_override("font_color", Color.WHITE)
	timestamp_word_shown = Time.get_ticks_msec()
	duration_label.text = "Press a letter that's not in the word above."

func get_character(event: InputEventKey) -> String:
	var physical_keycode = event.physical_keycode
	var key_string = OS.get_keycode_string(physical_keycode)
	return key_string.to_lower()

func _on_timer_timeout() -> void:
	_pick_word()
