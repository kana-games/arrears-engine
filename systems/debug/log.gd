# Log
extends Node

var indent := 0

func _log(message: String, _sender := "", color := ""):
	var full := ""
	
	for i in range(indent):
		full += "   "
	
	if _sender != "":
		full += "[" + _sender + "] "
	
	if color != "":
		full += RichTextBuilder.color(message, color)
	else:
		full += message
	
	print_rich(full)
	
	if UIManager.console:
		UIManager.console.print_line(full)

func info(message: String, sender := "") -> void:
	_log(message, sender)

func warn(message: String, sender := "") -> void:
	_log(message, sender, "orange")

func error(message: String, sender := "") -> void:
	_log(message, sender, "red")

func ln(amount := 1):
	for i in range(amount):
		print("")
