extends Node2D

@export var CombatView : Node2D 
@export var TargetPick : Node2D
@export var EntiteArray: Array[Entity]

@onready var combat: Combat = Combat.new()

#КОСТЫЛЬ ДЛЯ ТЕСТА
func _ready() -> void:
	combat.roundStarted.connect(CombatView._onRoundStarted)
	combat.turnStarted.connect(CombatView._onTurnStarted)
	combat.pickManuallyAction.connect(CombatView._onPickManually)
	combat.pickManuallyAction.connect(TargetPick._onPickManually)
	TargetPick.entityPicked.connect(combat._onTargetPicked)
	
	SetUpCombat()
	combat.startCombat()

func SetUpCombat():
	var player = PlayerCharacter.new()
	player._Name = "Player"
	var enemy = EnemyCharacter.new()
	enemy._Name = "Enemy"
	
	combat.addCharacter(player)
	combat.addCharacter(enemy)
	
	EntiteArray.shuffle()
	
	var i = 0
	for entity: Entity in EntiteArray:
		if(i >= 8):
			break
		if(i % 2 == 0):
			combat.addEntity(player, entity.duplicate())
		else:
			combat.addEntity(enemy, entity.duplicate())
		i+=1
