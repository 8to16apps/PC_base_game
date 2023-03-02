extends Control

export var __M_E_N_U_S__ = "----------"
export(NodePath) onready var menu = get_node(menu)
export(NodePath) onready var options = get_node(options)
export(NodePath) onready var confirm_popup = get_node(confirm_popup)
export var __B_U_T_T_O_N_S__ = "----------"
export(NodePath) onready var continueBtn = get_node(continueBtn)
export(NodePath) onready var new_game = get_node(new_game)
export var __S_C_E_N_E_S__ = "----------"
export(String) var NewGameScene


func _ready():
	OptionsData.load_options()
	
	_on_Back_pressed()

func _notification(what):
	if what == NOTIFICATION_WM_QUIT_REQUEST:
		_on_Exit_pressed()

func _on_Continue_pressed():
	GameData.load_game()
	_on_NewGame_pressed()


func _on_NewGame_pressed():
	GameData.new_game()
	#TODO - RESET MAIN GAME STATE
	get_tree().change_scene(NewGameScene)


func _on_Options_pressed():
	menu.visible = false
	options.visible = true


func _on_Exit_pressed():
	confirm_popup.popup()


func _on_Yes_pressed():
	get_tree().quit()


func _on_Back_pressed():
	menu.visible = true
	options.visible = false
	
	var save_game = File.new()
	if not save_game.file_exists("user://savegame.save"):
		continueBtn.disabled = false
		new_game.grab_focus()
	else:
		continueBtn.grab_focus()
