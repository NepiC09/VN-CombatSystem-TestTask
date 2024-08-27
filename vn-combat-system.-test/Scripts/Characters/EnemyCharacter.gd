class_name EnemyCharacter extends Character

func startTurn():
	pickRandom()

func endTurn():
	targetEntity = null
	turnEnded.emit()

func pickRandom():
	targetEntity = Combat._instance.getRandomEnemyEntity(self)
	
	#Should be a choose, but now only 1 effect
	inflictEffect()

func inflictEffect():
	var damage = randi_range(0, 10)
	var effect : DamageEffect = DamageEffect.new(targetEntity, [damage])
	currentOwnEntity.inflictEffect(effect, targetEntity)
	
	print(self._Name + " " + currentOwnEntity._Name + " attacked " + targetEntity._Name + " with damage: " + str(damage))
	print()
	endTurn()
