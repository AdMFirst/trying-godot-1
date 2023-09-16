extends Node

const SAVE_PATH = "res://savegame.bin"

func saveGame():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var data: Dictionary = {
		"playerHP": Game.playerHP,
		"playerGold": Game.playerGold
	}
	var jsonData = JSON.stringify(data)
	file.store_line(jsonData)

func loadGame():
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if FileAccess.file_exists(SAVE_PATH):
		if not file.eof_reached():
			var curent_line = JSON.parse_string(file.get_line())
			if curent_line:
				Game.playerGold = curent_line["playerGold"]
				Game.playerHP = curent_line["playerHP"]
	
	


