# global EntityManager
extends Node

var _entities: Dictionary[StringName, Node3D] = {}

func spawn(entity_id: StringName, pos: Vector3) -> Node3D:
	var entity_data := Registry.Entities.get_entry(entity_id) as EntityData

func register(node: Node3D) -> void:
	var id := node.find_child("Identity") as Identity
	if id:
		_entities[id.uid] = node

func unregister(uid: StringName) -> void:
	_entities.erase(uid)

func get_by_uid(uid: StringName) -> Node3D:
	return _entities[uid]

func get_by_tag(tag: String) -> Array:
	return _entities.values().filter(
		func(entity): 
			var id := entity.find_child("Identity") as Identity
			if id:
				return id.has_tag(tag)
	)

func get_all() -> Array[Node3D]:
	return _entities.values()
