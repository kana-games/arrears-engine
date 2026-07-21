class_name Identity extends Component

var uid: String
var data: EntityData
var entity: Node3D

func _ready() -> void:
	entity = get_parent()
	uid = str(ResourceUID.create_id())

func initialize(_data: Dictionary):
	
