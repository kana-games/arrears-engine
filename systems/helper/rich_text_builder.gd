class_name RichTextBuilder

const ICON = preload("uid://bu3unlmdeo3xg")

static func item(id: String, item_data: ItemData) -> String:
	var data: ItemData
	if id == "" and item_data:
		data = item_data
	else:
		data = Registry.Items.get_entry(id)
	
	var icon: String
	if data.icon:
		icon = "[img=16x16]%s[/img]" % data.icon.resource_path
	else:
		icon = "[img=16x16]%s[/img]" % ICON.resource_path
	
	var link = "[url=item:%s]%s[/url]" % [id, data.display_name]
	return icon + " " + color(link, "light_blue")

static func entity(id: String, entity_data: EntityData = null) -> String:
	var data: EntityData
	if id == "" and entity_data:
		data = entity_data
	else:
		data = Registry.Entities.get_entry(id)
	
	var icon: String
	if data.icon:
		icon = "[img=16x16]%s[/img]" % data.icon.resource_path
	else:
		icon = "[img=16x16]%s[/img]" % ICON.resource_path
	
	var link = "[url=entity:%s]%s[/url]" % [id, data.display_name]
	return icon + " " + color(link, "light_blue")

static func color(message: String, text_color: String) -> String:
	return "[color=%s]%s[/color]" % [text_color, message]
