class_name Identity extends Component

var uid: String
var entity_data: EntityData
var entity: Node3D

func initialize(data: Dictionary) -> void:
	uid = str(ResourceUID.create_id())
	entity_data = data.res
	entity = get_parent()
