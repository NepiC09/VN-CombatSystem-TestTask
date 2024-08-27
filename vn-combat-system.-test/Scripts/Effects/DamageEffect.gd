class_name DamageEffect extends BaseEffect

var damage: float

func _init(entity: Entity, args: Array):
	if(entity == null):
		push_error("Target Enity can't be null")
		return
	
	if(args.size() != 1):
		push_error("DamageEffect should be with 1 argument!")
		return
	
	if(!(args[0] is float or args[0] is int)):
		push_error("DamageEffect argument should be float")
		return
	
	if( args[0] < 0):
		push_error("Damage can't be less then 0")
	
	damage = args[0]
	
	_EntityTarget = entity


func OnAdd():
	_EntityTarget.applyDamage(damage)

func OnRemove():
	_EntityTarget.removeEffect(self)
