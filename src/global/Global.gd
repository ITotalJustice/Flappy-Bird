extends Node


const SAVEPATH := "user://flappy_bird.save"

export (int) var VERSION := gen_version(0, 0, 1)
export (int) var MIN_SAVE_VERSION := gen_version(0, 0, 1)
onready var highscore := 0


# on startup, we create a savefile.
func _ready():
	var file := File.new()
	if file.file_exists(SAVEPATH):
		load_game()
		pass


func save_game():
	var save_data := {
		"version": VERSION,
		"highscore": highscore
	}
	var file = File.new()
	file.open(SAVEPATH, File.WRITE)
	file.store_string(to_json(save_data))
	file.close()


func load_game():
	var file = File.new()
	if file.file_exists(SAVEPATH):
		file.open(SAVEPATH, File.READ)
		var data = parse_json(file.get_as_text())
		var save_version = data["version"]
		print("save version: ", save_version)
		if save_version >= MIN_SAVE_VERSION:
			highscore = data["highscore"]
			print("loaded highscore: ", highscore)
		file.close()

	
func new_score(score: int) -> bool:
	if score > highscore:
		highscore = score
		save_game()
		return true
	return false

func gen_version(major: int, minor: int, macro: int) -> int:
	return (major << 24) | (minor << 16) | (macro << 8)
