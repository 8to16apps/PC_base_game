extends PopupDialog

signal exit_pressed
signal continue_pressed

func _on_Yes_pressed():
	emit_signal("exit_pressed")
	hide()


func _on_No_pressed():
	emit_signal("continue_pressed")
	hide()


func _on_Survey_meta_clicked(meta):
	var _ret = OS.shell_open(str(meta))


#func _ready():
#	show()
