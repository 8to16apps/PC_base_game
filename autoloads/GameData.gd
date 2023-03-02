extends Node

#-------------------------------------------------------------------------------
# EXAMPLE GAME DATA
#-------------------------------------------------------------------------------
var total_points:int = 0
var game_level = 0

func serialize_example_data()->Dictionary:
	var data:Dictionary = {
		"total_points":total_points,
		"game_level":game_level
	}
	return data


func deserialize_example_data(data:Dictionary):
	total_points = data["total_points"]
	game_level = data["game_level"]

#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------

func new_game():
	#TODO - RESET GAME DATA
	total_points = 0
	game_level = 0
	pass

func save_game():
	var save_game = File.new()
	save_game.open("user://savegame.save", File.WRITE)
	
	#TODO - SERIALIZE GAME DATA
	var example_data:Dictionary = serialize_example_data()
	save_game.store_line(to_json(example_data))
	#----------------------
	
	save_game.close()


func load_game():
	var save_game = File.new()
	if not save_game.file_exists("user://savegame.save"):
		return # Error! We don't have a save to load.
	
	# Load the file line by line and process that dictionary to restore
	# the object it represents.
	save_game.open("user://savegame.save", File.READ)
	
	#TODO - DESERIALIZE GAME DATA
	var example_data = parse_json(save_game.get_line())
	deserialize_example_data(example_data)
	#------------------------
	
	save_game.close()
