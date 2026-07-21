class_name CommandRegistry extends Node

var _commands: Dictionary = {}

func _ready() -> void:
	_scan_directory(PathConstants.COMMANDS, StringConstants.NAMESPACE)
	#_scan_directory("-mod folder here-")

func _scan_directory(path: String, name_space: String) -> void:
	var dir = DirAccess.open(path)
	if not dir: 
		return
	
	dir.list_dir_begin()
	
	var entry = dir.get_next()
	while entry != "":
		var full_path := path.path_join(entry)
		
		if dir.current_is_dir():
			if entry != "." and entry != "..":
				_scan_directory(full_path, name_space)
		elif entry.ends_with(".gd"):
			_try_register(full_path, name_space)
		
		entry = dir.get_next()
	
	dir.list_dir_end()

func _try_register(path: String, name_space: String) -> void:
	var command = load(path)
	if not command:
		return
	var instance: Command = command.new()
	if not instance is Command:
		return
	if instance.command_name == "":
		push_warning("Command at %s has no command name set." % path)
		return
	_commands[name_space + ":" + instance.command_name] = instance
	for alt_name in instance.alternative_names:
		_commands[name_space + ":" + alt_name] = instance
		Log.info("Registered Command: " + name_space + ":" + alt_name, "Commands")
	Log.info("Registered Command: " + name_space + ":" + instance.command_name, "Commands")

func get_entry(command_name: StringName) -> Command:
	if command_name.contains(":"):
		return _commands.get(command_name, null)
	else:
		return _commands.get(StringConstants.NAMESPACE + ":" + command_name, null)
	

func get_all() -> Dictionary:
	return _commands
