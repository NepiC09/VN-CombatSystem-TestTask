class_name BaseEffect

var _EntityTarget: Entity

func _init(entity: Entity, args: Array):
	if(entity == null):
		push_error("Target Enity can't be null")
		return
	
	_EntityTarget = entity

func OnAdd():
	pass

func OnUpdate():
	pass

func OnRemove():
	pass
