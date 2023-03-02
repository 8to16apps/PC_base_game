extends Control

signal exit_pressed
signal new_game
signal main_menu
signal quit

onready var options = $Options
onready var menu = $Menu

func _ready():
	options.visible = false
	menu.visible = true

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		_on_Continue_pressed()


func _on_Continue_pressed():
	visible = false
	emit_signal("exit_pressed")


func _on_NewGame_pressed():
	emit_signal("new_game")


func _on_Options_pressed():
	menu.visible = false
	options.visible = true


func _on_Options_close_pressed():
	menu.visible = true
	options.visible = false


func _on_MainMenu_pressed():
	emit_signal("main_menu")


func _on_Quit_pressed():
	emit_signal("quit")
