class_name Character extends Resource

@warning_ignore("unused_private_class_variable")
@export var _Name : String

@warning_ignore("unused_signal")
signal pickManuallyAction
@warning_ignore("unused_signal")
signal turnEnded
@warning_ignore("unused_signal")
signal effectInflicting

var targetEntity: Entity
var currentOwnEntity: Entity

func pickRandom():
	pass

func pickManually():
	pass

@warning_ignore("unused_parameter")
func targetSelected(entity: Entity):
	pass
	
func inflictEffect():
	pass

func startTurn():
	pass

func endTurn():
	pass
