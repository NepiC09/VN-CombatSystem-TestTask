class_name Combat

static var _instance : Combat

var _CharacterEntities :Dictionary
var _TempEntityArray :Array[Entity]
var _Queue: Array[Entity]

var _CurrentCharacter :Character

signal roundStarted
signal turnStarted
signal pickManuallyAction


func _init() -> void:
	if(_instance == null):
		_instance = self
	else:
		push_error("Can't be more than 1 Combat instance!")
		return


func startCombat():
	if(_CharacterEntities.size() == 0):
		push_error("There's no characters in combat")
	
	startRound()


func endCombat():
	var liveCharacters : Array[Character] = getLiveCharacters()
	print(liveCharacters[0]._Name + " is a Winner!")
	reset()


func startRound():
	setInitiative()
	CreateQueue()
	
	roundStarted.emit()
	for character : Character in _CharacterEntities:
		for entity : Entity in _CharacterEntities[character]:
			entity.OnUpdate()
	startTurn()


func endRound():
	if getLiveCharacters().size() > 1:
		startRound()
	else:
		endCombat()

func startTurn():
	turnStarted.emit()
	var currentEntity = _Queue.pop_front()
	_CurrentCharacter = getCharacter(currentEntity)
	_CurrentCharacter.currentOwnEntity = currentEntity
	_CurrentCharacter.startTurn()


func _onTurnEnded():
	if(_Queue.size() == 0):
		endRound()
	elif(getLiveCharacters().size() == 1):
		endRound()
	else:
		startTurn()


func addCharacter(character: Character):
	if(character == null):
		push_error("Character can't be null")
		return
	
	if(_CharacterEntities.has(character)):
		push_error("Characters already in combat!")
		return
	
	var entities : Array[Entity]
	_CharacterEntities[character] = entities
	character.pickManuallyAction.connect(_onPickManuallyAction)
	character.turnEnded.connect(_onTurnEnded)


func addEntity(character: Character, entity: Entity):
	if(character == null):
		push_error("Character can't be null")
		return
	
	if(!_CharacterEntities.has(character)):
		push_error("Characters not in combat!")
		return
	
	if(entity == null):
		push_error("Entity can't be null")
		return
	
	if(entity in _CharacterEntities[character]):
		push_error("Entity alreay in _CharacterEntities")
		return
	
	if(entity in _TempEntityArray):
		push_error("Entity alreay in others Character")
		return
	
	_CharacterEntities[character].push_back(entity)
	_TempEntityArray.push_back(entity)
	entity.died.connect(_onEntityDied)

func _onEntityDied(entity: Entity):
	if entity not in _Queue:
		return
	
	_Queue.erase(entity)

func setInitiative():
	for entity: Entity in _TempEntityArray:
		var minRandInitativeUpdate = -3
		var maxRandInitativeUpdate = 3
		entity.changeInitiative(randi_range(minRandInitativeUpdate, maxRandInitativeUpdate))


func CreateQueue():
	var tempQueue : Array[Entity] 
	for character : Character in _CharacterEntities:
		tempQueue.append_array(getLiveCharacterEntities(character))
	
	tempQueue.sort_custom(func(a: Entity, b: Entity):
		return a._CurrentIniative > b._CurrentIniative)
	
	_Queue.append_array(tempQueue)


func reset():
	_CharacterEntities.clear()
	_TempEntityArray.clear()


func _onPickManuallyAction(character : Character):
	if character == null:
		push_error("character can't be null")
		return
	pickManuallyAction.emit(character)


func _onTargetPicked(numberOfEntity: int):
	if numberOfEntity == 0:
		push_error("number of entity can't be 0")
		return
	
	var i : int = 1
	for character : Character in _CharacterEntities:
		if character == _CurrentCharacter:
			continue
		else:
			for entity : Entity in getLiveCharacterEntities(character):
				if(numberOfEntity == i):
					if(entity == null):
						push_error("Entity can't be null")
						return
					
					_CurrentCharacter.targetSelected(entity)
					return
				else:
					i += 1


func GetQueue():
	return _Queue.duplicate()


func getCharacter(entity: Entity) -> Character:
	if(entity == null):
		push_error("Entity can't be null")
		return null
	
	for character : Character in _CharacterEntities.keys():
		if(entity in _CharacterEntities[character]):
			return character
	
	return null


func GetCharacterEntitiesCopy() -> Dictionary:
	return _CharacterEntities.duplicate()

func getRandomEnemyEntity(character: Character) -> Entity:
	var countOfCharacters = _CharacterEntities.size()
	var randomIndexCharacter = randi_range(0, countOfCharacters-2)
	
	var index = 0
	for char : Character in _CharacterEntities:
		if char == character:
			continue
		
		if(index == randomIndexCharacter):
			return _CharacterEntities[char].pick_random()
		
		index += 1
	
	return null

func getLiveCharacterEntities(character: Character) -> Array[Entity]:
	if character == null:
		push_error("Character can't be null")
	
	if character not in _CharacterEntities.keys():
		push_error("Character not in CharacterEntities")
	
	var liveEntities : Array[Entity]
	for entity : Entity in _CharacterEntities[character]:
		if entity._HP <= 0:
			continue
		liveEntities.append(entity)
	
	return liveEntities


func getLiveCharacters() -> Array[Character]:
	var characters: Array[Character]
	
	for character : Character in _CharacterEntities:
		if getLiveCharacterEntities(character).size() > 0:
			characters.append(character)
	
	return characters
