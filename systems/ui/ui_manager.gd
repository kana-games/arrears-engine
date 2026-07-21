# UIManager
extends Node

var chat: Control
var console: Control
var debug_log: Control
var debug_info: Control

var interactable_prompt: Control
var interactable_label: Label


var active_ui: Control

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("escape"):
		_switch_ui(null)
		return
	
	if event.is_action_pressed("toggle_chat"):
		_switch_ui(chat)

func _switch_ui(ui: Control):
	if ui == null:
		if active_ui:
			active_ui.visible = false
		PlayerManager.local_player.override_movement = false
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		return
	
	if active_ui != ui and active_ui:
		active_ui.visible = false
	 
	active_ui = ui
	active_ui.visible = true
	PlayerManager.local_player.override_movement = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
