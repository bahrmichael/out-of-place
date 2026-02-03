extends Node

var highscore = 0
var score = 0

signal highscore_changed(int)
signal score_changed(int)

const FILE_NAME = "user://score.json"

func update_score(s: int) -> void:
	score_changed.emit(s)
	if s > highscore:
		highscore = s
		highscore_changed.emit(s)

func _ready() -> void:
	var file = FileAccess.open(FILE_NAME, FileAccess.READ)
	if file:
		var json = JSON.new()
		json.parse(file.get_as_text())
		var data = json.data
		if "highscore" in data:
			highscore = data["highscore"]
	
	highscore_changed.connect(_on_highscore_changed)

func _on_highscore_changed(s: int) -> void:
	var file = FileAccess.open(FILE_NAME, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify({"highscore": s}))
	
