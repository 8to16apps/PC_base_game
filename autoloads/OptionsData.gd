extends Node

var ResolutionNames:Array = [
	"1024x564",
	"1280x720",
	"1600x900",
	"1920x1080"
]

var ResolutionValues:Array = [
	Vector2(1024, 564),
	Vector2(1280, 720),
	Vector2(1600, 900),
	Vector2(1920, 1080)
]

#-------------------------------------------------------------------------------
#Options data
#-------------------------------------------------------------------------------
var full_screen:bool = false
var screen_resolution:int = 3
var music_volumen:float = 0.15
var fx_volumen:float = 0.15

func serialize_options_data()->Dictionary:
	var data:Dictionary = {
		"full_screen":full_screen,
		"screen_resolution":screen_resolution,
		"music_volumen":music_volumen,
		"fx_volumen":fx_volumen
	}
	return data


func deserialize_options_data(data:Dictionary):
	full_screen = data["full_screen"]
	screen_resolution = data["screen_resolution"]
	music_volumen = data["music_volumen"]
	fx_volumen = data["fx_volumen"]
#-------------------------------------------------------------------------------

func save_options():
	var save_game = File.new()
	save_game.open("user://options.save", File.WRITE)
	
	var options_data:Dictionary = serialize_options_data()
	save_game.store_line(to_json(options_data))
	
	save_game.close()


func load_options():
	var save_game = File.new()
	if not save_game.file_exists("user://options.save"):
		return # Error! We don't have a save to load.
	
	# Load the file line by line and process that dictionary to restore
	# the object it represents.
	save_game.open("user://options.save", File.READ)
	
	var options_data = parse_json(save_game.get_line())
	deserialize_options_data(options_data)
	
	save_game.close()
	
	OS.window_fullscreen = full_screen
	OS.window_size = ResolutionValues[screen_resolution]
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear2db(music_volumen) )
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("FX"), linear2db(fx_volumen) )

