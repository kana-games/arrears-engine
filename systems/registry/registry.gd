# global Registry
extends Node

signal initialized

var Commands: CommandRegistry
var Entities: EntityRegistry
var Items: ItemRegistry

func initialize():
	Commands = await add(CommandRegistry.new())
	Entities = await add(EntityRegistry.new())
	Items = await add(ItemRegistry.new())
	
	initialized.emit()

func add(collection: Node) -> Node:
	collection.name = collection.get_script().get_global_name()
	Log.info("Added " + collection.name, "Registry")
	Log.indent += 1
	add_child(collection)
	Log.indent -= 1
	Log.ln()
	await get_tree().process_frame
	return collection
