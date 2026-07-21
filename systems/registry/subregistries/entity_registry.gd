class_name EntityRegistry extends BaseRegistry

func _ready() -> void:
	registry_name = "Entities"
	scan_folder(PathConstants.ENTITIES, StringConstants.NAMESPACE, "entity.tres")
	
	if _entries.is_empty():
		Log.warn("No resources found.", "Entities")

func log_registry(name_space: String, resource: DataResource):
	Log.info("Registered: " + RichTextBuilder.entity("", resource) + " ("+ name_space + ":" + resource.id + ")", registry_name)
