class_name PlayerCharacter extends Character


func startTurn():
	pickManually()

func endTurn():
	targetEntity = null
	turnEnded.emit()

func pickManually():
	pickManuallyAction.emit(self)

func targetSelected(entity: Entity):
	if(entity == null):
		push_error("Entity can't be null")
		return
	
	targetEntity = entity
	
	print("Target Selected: " + entity._Name + " " + str(entity._HP) + " " + str(entity._CurrentIniative))
	
	#should be choose Effect, but in test there's 1 effect 
	inflictEffect()

func inflictEffect():
	var damage = randi_range(0, 10)
	#Picked effect in future 
	var effect : DamageEffect = DamageEffect.new(targetEntity, [damage])
	currentOwnEntity.inflictEffect(effect, targetEntity)
	
	print(self._Name + " " + currentOwnEntity._Name + " attacked " + targetEntity._Name + " with damage: " + str(damage))
	print()
	endTurn()
