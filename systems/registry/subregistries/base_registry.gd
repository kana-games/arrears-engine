class_name BaseRegistry extends Node

var _entries: Dictionary = {}

var registry_name := "Null"

func register(id: String, data: Resource):
	if _entries.has(id):
		Log.warn("Registry: Overwriting existing ID '%s" % id)
	_entries[id] = data

func get_entry(id: String) -> Resource:
	var new_id := normalize_id(id)
	
	if not _entries.has(new_id):
		Log.error("ID '%s' not found." % new_id, "Registry")
		return null
	return _entries[new_id]

func has(id: String) -> bool:
	return _entries.has(normalize_id(id))

func get_all() -> Array:
	return _entries.values()

func get_all_ids() -> PackedStringArray:
	return _entries.keys()

func unregister(id: String):
	_entries.erase(id)

func normalize_id(id: String) -> String:
	if id.contains(":"):
		return id
	return StringConstants.NAMESPACE + ":" + id

# Scanning

func scan_folder(path: String, name_space: String, ends_with := ".tres") -> void:
	var dir = DirAccess.open(path)
	if not dir: 
		return
	
	dir.list_dir_begin()
	
	var entry = dir.get_next()
	while entry != "":
		var full_path := path.path_join(entry)
		
		if dir.current_is_dir():
			if entry != "." and entry != "..":
				scan_folder(full_path, name_space, ends_with)
		elif entry.ends_with(ends_with):
			_try_register(full_path, name_space)
		
		entry = dir.get_next()
	
	dir.list_dir_end()

func _try_register(path: String, name_space: String) -> void:
	var resource := load(path) as DataResource
	
	if resource == null:
		return
	
	if resource.id.is_empty():
		Log.warn("Resource at %s has no name set." % path, registry_name)
		return
	
	_entries[name_space + ":" + resource.id] = resource
	log_registry(name_space, resource)

func log_registry(name_space: String, resource: DataResource):
	Log.info("Registered: " + name_space + ":" + resource.id, registry_name)
