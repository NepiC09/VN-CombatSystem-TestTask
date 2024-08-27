extends Node2D

func _onRoundStarted():
	UpdateView()
	PrintQueue()

func _onTurnStarted():
	pass

#For Test without Visual
func UpdateView():
	var characterEntities : Dictionary = Combat._instance.GetCharacterEntitiesCopy()
	print()
	for character : Character in characterEntities:
		print(character._Name + " entities:")
		for entity :Entity in characterEntities[character]:
			print("Name: " + entity._Name + " HP: " + str(entity._HP) + " Initative: " + str(entity._CurrentIniative))
		print()

func PrintQueue():
	var Queue : Array[Entity] = Combat._instance.GetQueue()
	print("Current queue:")
	for entity : Entity in Queue:
		print(Combat._instance.getCharacter(entity)._Name + " " + returnEntityString(entity))
	print()

func _onPickManually(character: Character):
	var characterEntites : Dictionary = Combat._instance.GetCharacterEntitiesCopy()
	
	for char: Character in characterEntites:
		if(char == character):
			continue
		else:
			print("Targets:")
			var liveTargets = Combat._instance.getLiveCharacterEntities(char)
			for entity : Entity in liveTargets:
				print(returnEntityString(entity))
	print()

func returnEntityString(entity: Entity) -> String:
	return entity._Name + " " + str(entity._HP) + " " + str(entity._CurrentIniative)
