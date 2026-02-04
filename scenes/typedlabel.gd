extends Label

@export var typing_speed := 0.02 # seconds per character

var _elapsed := 0.0

func _ready():
	visible_characters = 0

func _process(delta):
	_elapsed += delta
	if _elapsed >= typing_speed:
		_elapsed = 0
		if visible_characters < text.length():
			visible_characters += 1

func _reset():
		_elapsed = 0.0
		visible_characters = 0
