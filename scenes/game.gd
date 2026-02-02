extends Control

@onready var label: Label = $CenterContainer/VBoxContainer/Word
@onready var transition_timer: Timer = $TransitionTimer
@onready var duration_label: Label = $CenterContainer/VBoxContainer/DurationLabel
@onready var analytics_request: HTTPRequest = $AnalyticsRequest
@onready var streak_label: Label = $CenterContainer/VBoxContainer/StreakLabel
@onready var difficulty_label: Label = $CenterContainer/VBoxContainer/DifficultyLabel
@onready var audio_stream_player_success: AudioStreamPlayer = $AudioStreamPlayerSuccess
@onready var audio_stream_player_failure: AudioStreamPlayer = $AudioStreamPlayerFailure



# Increase this when you make a change significant enough that new telemetry
# data should not be compared to previous data anymore.
const TELEMETRY_DATA_VERSION = 2

var telemetry: Telemetry

var timestamp_word_shown: int
var duration: int

var selected_word: String

var difficulty = 1
var streak = 0

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
			audio_stream_player_success.play()
			label.add_theme_color_override("font_color", Color.GREEN)
			streak += 1
			if streak % 5 == 0:
				# Every 3 words done correctly give you a difficulty bump
				difficulty += 3
		else:
			audio_stream_player_failure.play()
			label.add_theme_color_override("font_color", Color.RED)
			streak = 0
			difficulty = 1
		
		print("%s not in %s: %s" % [character, selected_word, character not in selected_word])
		
		streak_label.text = "Streak: %d" % streak
		difficulty_label.text = "Difficulty: %d" % difficulty
			
		transition_timer.start()
		duration = timestamp_key_pressed - timestamp_word_shown
		duration_label.text = "%ds %dms" % [duration / 1000, duration % 1000]
		
		var request_data = {
			"version": TELEMETRY_DATA_VERSION,
			"event": "input_evaluated",
			"word": selected_word,
			"duration": duration,
			"correct": correct,
			"character": character
		}
		telemetry.push(request_data)

func _pick_word() -> void:
	var words = Words.get_words_for_difficulty(difficulty)
	# Remove last word from the options so that it doesn't show up immediately again
	words.remove_at(words.find(selected_word))
	selected_word = words[randi_range(0, len(words) - 1)]
	selected_word = selected_word.to_lower()
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
