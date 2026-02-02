extends Control

@onready var label: Label = $CenterContainer/VBoxContainer/Word
@onready var transition_timer: Timer = $TransitionTimer
@onready var duration_label: Label = $CenterContainer/VBoxContainer/DurationLabel
@onready var analytics_request: HTTPRequest = $AnalyticsRequest

var telemetry: Telemetry

var timestamp_word_shown: int
var duration: int

var selected_word: String

func _ready() -> void:
	telemetry = Telemetry.create(Time.get_datetime_string_from_system(), analytics_request)
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
			"character": character
		}
		telemetry.push(request_data)

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

class Telemetry:
	
	const ANALYTICS_URL = "https://game-telemetry.michael-dc8.workers.dev/events"
	
	var session_id: String
	var http_node: HTTPRequest
	
	func push(event: Dictionary) -> void:
		event["session_id"] = session_id
		# Mediocre security attempt; API also has rate limiting. List endpoint has a different key.
		http_node.request(ANALYTICS_URL, ["X-API-Key: ec7e89f4c5bd7d95a7a99aef86d3c08956ee7be115877f13bbb5817e85ce8d7a"], HTTPClient.METHOD_POST, JSON.stringify(event))
	
	static func create(session_id: String, http_node: HTTPRequest) -> Telemetry:
		var t = Telemetry.new()
		t.http_node = http_node
		t.session_id
		return t
