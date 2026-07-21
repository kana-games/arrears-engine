class_name ItemRegistry extends BaseRegistry

func _ready() -> void:
	registry_name = "Items"
	scan_folder(PathConstants.ITEMS, StringConstants.NAMESPACE, "item.tres")
	
	if _entries.is_empty():
		Log.warn("No resources found.", "Items")

func log_registry(name_space: String, resource: DataResource):
	Log.info("Registered: " + RichTextBuilder.item("", resource) + " ("+ name_space + ":" + resource.id + ")", registry_name)
