extends Control

@onready var transition_timer: Timer = $TransitionTimer
@onready var label: Label = $MarginContainer/VBoxContainer/VBoxContainer/Word
@onready var duration_label: Label = $MarginContainer/VBoxContainer/VBoxContainer/DurationLabel
@onready var streak_label: Label = $MarginContainer/VBoxContainer/VBoxContainer/StreakLabel
@onready var highscore_label: Label = $MarginContainer/VBoxContainer/VBoxContainer/HighscoreLabel

@onready var audio_stream_player_success: AudioStreamPlayer = $AudioStreamPlayerSuccess
@onready var audio_stream_player_failure: AudioStreamPlayer = $AudioStreamPlayerFailure
@onready var analytics_request: HTTPRequest = $AnalyticsRequest
@onready var text_request: HTTPRequest = $TextRequest


# Increase this when you make a change significant enough that new telemetry
# data should not be compared to previous data anymore.
const TELEMETRY_DATA_VERSION = 3

var telemetry: Telemetry
var text_retriever: TextRetriever

var timestamp_word_shown: int
var duration: int

var selected_word: String = ""
var next_word: String = ""

var streak = 0

func _ready() -> void:
	Score.score_changed.connect(_on_score_changed)
	Score.highscore_changed.connect(_on_highscore_changed)
	
	telemetry = Telemetry.create(Time.get_datetime_string_from_system(), analytics_request)
	text_request.request_completed.connect(_on_text_request_completed)
	text_retriever = TextRetriever.create(text_request)
	text_retriever.get_text("a", 15)
	# We're picking the first word at the end of _on_text_request_completed
	
	_on_highscore_changed(Score.highscore)

func _on_score_changed(s: int) -> void:
	streak_label.text = "Streak: %d" % s

func _on_highscore_changed(s: int) -> void:
	highscore_label.text = "Highscore: %d" % s

func _on_text_request_completed(result, response_code, headers, body) -> void:
	var j = JSON.parse_string(body.get_string_from_utf8())
	next_word = j["text"]

	# Special handling for when we didn't init the first word yet at the beginning of the session
	if selected_word == "":
		_pick_word()

func _input(event):
	if event is InputEventKey and event.pressed:
		# if the timer is running, we mapped a key and the result is shown
		if not transition_timer.is_stopped():
			return
		var timestamp_key_pressed = Time.get_ticks_msec()
		var character = get_character(event)
		if character not in letters:
			return
		var correct = character not in selected_word
		if correct:
			audio_stream_player_success.play()
			label.add_theme_color_override("font_color", Color.GREEN)
			streak += 1
			Score.update_score(streak)
		else:
			audio_stream_player_failure.play()
			label.add_theme_color_override("font_color", Color.RED)
			streak = 0
			Score.update_score(streak)
		
		_increase_added_weight(character)
		
		print("%s not in %s: %s" % [character, selected_word, character not in selected_word])
			
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

func get_random_lowercase_letter() -> String:
	return String(char(randi() % 26 + 97))

var letters = "abcdefghijklmnopqrstuvwxyz"
var letter_weights = []

func _pick_word() -> void:
	selected_word = next_word
	next_word = ""
	label._reset()
	label.text = selected_word
	selected_word = selected_word.to_lower()
	label.add_theme_color_override("font_color", Color.WHITE)
	timestamp_word_shown = Time.get_ticks_msec()
	duration_label.text = "Press a letter (a-z) that's not in the text above."
	
	# preload the next word
	if len(letter_weights) == 0:
		letter_weights.resize(26)
		letter_weights.fill(1)
	
	var rng = RandomNumberGenerator.new()
	var included_letter = letters[rng.rand_weighted(letter_weights)]
	print(included_letter)
	_update_weights(included_letter)
	text_retriever.get_text(included_letter, streak + 15)

var letter_frequencies = { "a": 8.167, "b": 1.492, "c": 2.782, "d": 4.253, "e": 12.702, "f": 2.228, "g": 2.015, "h": 6.094, "i": 6.966, "j": 0.153, "k": 0.772, "l": 4.025, "m": 2.406, "n": 6.749, "o": 7.507, "p": 1.929, "q": 0.095, "r": 5.987, "s": 6.327, "t": 9.056, "u": 2.758, "v": 0.978, "w": 2.360, "x": 0.150, "y": 1.974, "z": 0.074 }
# todo michael: init all of them with 0. i was too lazy to do that.
var letters_used = { "a": 0, "b": 0, "c": 0, "d": 0, "e": 0, "f": 0, "g": 2.015, "h": 6.094, "i": 6.966, "j": 0.153, "k": 0.772, "l": 4.025, "m": 2.406, "n": 6.749, "o": 7.507, "p": 1.929, "q": 0.095, "r": 5.987, "s": 6.327, "t": 9.056, "u": 2.758, "v": 0.978, "w": 2.360, "x": 0.150, "y": 1.974, "z": 0.074 }

func _update_weights(included_letter: String) -> void:
	var idx = letters.find(included_letter)
	for i in range(len(letter_weights)):
		var l = letters[i]
		if i == idx:
			letter_weights[i] = 0
		else:
			letter_weights[i] += 15 - letter_frequencies[l]
		
		letter_weights[i] += letters_used[l]

var additional_weights = []

func _increase_added_weight(letter: String) -> void:
	if letters_used[letter] > 1:
		letters_used[letter] *= 2
	else:
		letters_used[letter] += 1

func get_character(event: InputEventKey) -> String:
	var physical_keycode = event.physical_keycode
	var key_string = OS.get_keycode_string(physical_keycode)
	return key_string.to_lower()

func _on_timer_timeout() -> void:
	_pick_word()

class TextRetriever:
	
	const URL = "https://game-telemetry.michael-dc8.workers.dev/text"
	var http_node: HTTPRequest
	
	func get_text(included_letter: String, length: int) -> void:
		http_node.request("%s?letter=%s&length=%d" % [URL, included_letter, length], ["X-API-Key: ec7e89f4c5bd7d95a7a99aef86d3c08956ee7be115877f13bbb5817e85ce8d7a"])
	
	static func create(http_node: HTTPRequest) -> TextRetriever:
		var t = TextRetriever.new()
		t.http_node = http_node
		return t

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
