extends Node2D

signal entityPicked
var numberOfEntity: int
var countOfTargets : int = 0

func _init() -> void:
	set_process_unhandled_input(false)

func _onPickManually(character: Character):
	var characterEntites : Dictionary = Combat._instance.GetCharacterEntitiesCopy()
	
	countOfTargets = 0
	for char in characterEntites:
		if char == character:
			continue
		
		countOfTargets += Combat._instance.getLiveCharacterEntities(char).size()
		print(countOfTargets)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_released():
		
		if event.keycode == KEY_1 && countOfTargets >= 1:
			print("You choosed: 1")
			entityPicked.emit(1)
		elif event.keycode == KEY_2 && countOfTargets >= 2:
			print("You choosed: 1")
			entityPicked.emit(2)
		elif event.keycode == KEY_3 && countOfTargets >= 3:
			print("You choosed: 3")
			entityPicked.emit(3)
		elif event.keycode == KEY_4 && countOfTargets >= 4:
			print("You choosed: 4")
			entityPicked.emit(4)
		elif event.keycode == KEY_5 && countOfTargets >= 5:
			print("You choosed: 5")
			entityPicked.emit(5)
		elif countOfTargets == 0:
			print("No targets")
		else:
			print("You choosed wrong Entity. Choose from 1 to " + str(countOfTargets))
