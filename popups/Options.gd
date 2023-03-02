extends Control

signal close_pressed

onready var music = $MenuBox/Music
onready var fx = $MenuBox/FX
onready var resolution = $MenuBox/Resolution
onready var full_screen = $MenuBox/FullScreen

func _ready():
	add_items()
	full_screen.set_pressed_no_signal(OS.window_fullscreen)
	resolution.select( OptionsData.screen_resolution )
	music.value = OptionsData.music_volumen
	fx.value = OptionsData.fx_volumen
	music.grab_focus()

func add_items():
	for name in OptionsData.ResolutionNames:
		resolution.add_item(name)


func _on_Resolution_item_selected(index):
	OptionsData.screen_resolution = index
	OS.window_size = OptionsData.ResolutionValues[index]


func _on_FullScreen_pressed():
	OptionsData.full_screen = !OS.window_fullscreen
	OS.window_fullscreen = !OS.window_fullscreen


func _on_Back_pressed():
	OptionsData.save_options()
	emit_signal("close_pressed")


func _on_Music_value_changed(value):
	OptionsData.music_volumen = value
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear2db(value) )


func _on_FX_value_changed(value):
	OptionsData.fx_volumen = value
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("FX"), linear2db(value) )
