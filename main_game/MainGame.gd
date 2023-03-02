extends Node

export var __M_E_N_U_S__ = "----------"
export(NodePath) onready var in_game_menu = get_node(in_game_menu)
export(NodePath) onready var exit_popup = get_node(exit_popup)
export(NodePath) onready var return_to_menu = get_node(return_to_menu)
export var __S_C_E_N_E_S__ = "----------"
export(String) var MainMenuScene

func _ready():
	#TODO - SETUP THE GAME HUD
	in_game_menu.visible = false
	return_to_menu.visible = false
	exit_popup.visible = false

func _notification(what):
	if what == NOTIFICATION_WM_QUIT_REQUEST:
		exit_popup.show()
		get_tree().paused = true

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		in_game_menu.visible = true
		get_tree().paused = true


func _on_No_pressed():
	get_tree().paused = false


func _on_Yes_pressed():
	GameData.save_game()
	get_tree().quit()


func _on_InGameMenu_exit_pressed():
	get_tree().paused = false


func _on_InGameMenu_new_game():
	GameData.new_game()
	get_tree().paused = false
	var _error = get_tree().reload_current_scene()


func _on_InGameMenu_main_menu():
	return_to_menu.show()
	get_tree().paused = true


func _on_InGameMenu_quit():
	exit_popup.show()
	get_tree().paused = true


func _on_MainMenu_Yes_pressed():
	return_to_menu.hide()
	var _ret = get_tree().change_scene(MainMenuScene)


func _on_MainMenu_No_pressed():
	return_to_menu.hide()
	GameData.save_game()
	get_tree().paused = false
