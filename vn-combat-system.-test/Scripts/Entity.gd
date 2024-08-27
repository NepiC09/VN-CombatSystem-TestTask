class_name Entity extends Resource

@warning_ignore("unused_private_class_variable")
@export var _Name: String

@export_group("Parameters")
@export_range(15,25) var _HP: int

@export_subgroup("Initiative")
@export var _MinInitative: int = 4
@export var _MaxInitative: int = 8
@export var _Initiative: int 

@export_subgroup("Damage")
@warning_ignore("unused_private_class_variable")
@export var _MinDamage: float = 1
@warning_ignore("unused_private_class_variable")
@export var _MaxDamage: float = 10

var _CurrentIniative : int
@warning_ignore("unused_private_class_variable")
var _Damage : float
var _Effects : Array

signal died

func _ready():
	if(_Initiative < _MinInitative or _Initiative > _MaxInitative):
		push_error("Initative not clamped in min and max")
		return
	
	_CurrentIniative = _Initiative

func changeInitiative(initiative: int):
	_CurrentIniative = _Initiative
	_CurrentIniative += initiative

#Updating every round previous 
func OnUpdate():
	for effect :BaseEffect in _Effects:
		effect.OnUpdate()
	
	for effect :BaseEffect in _Effects:
		effect.OnRemove()

#adding Effects to targets
func inflictEffect(effect: BaseEffect, entityTarget: Entity):
	if(entityTarget == null):
		push_error("Entity can't be null")
		return
	
	if(effect == null):
		push_error("Effect can't be null")
		return
	
	entityTarget.applyEffect(effect)

#applyng effect and addint in _Effects
func applyEffect(effect: BaseEffect):
	if(effect == null):
		push_error("Effect can't be null")
		return
	
	effect.OnAdd()
	_Effects.append(effect)

#removing effect from _Effects
func removeEffect(effect: BaseEffect):
	if(effect == null):
		push_error("Effect can't be null")
		return
	
	if(!(effect in _Effects)):
		push_error("Effect not in _Effects")
		return
	_Effects.erase(effect)


func applyDamage(damage: float):
	if(damage < 0):
		push_error("damage can't be less 0")
		return
	
	_HP -= damage
	
	if(_HP < 0):
		_HP = 0
		died.emit(self)
