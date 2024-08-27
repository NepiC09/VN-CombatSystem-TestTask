# VN CombatSystem TestTask
## ENGLISH DESCRIPTION
### Features:
-You can add new effects. It could be a heal, a different type of damage, or anything else you want.
-Effects can be merged into Skill class in the future and define how effects are applied in it.
-Any number of opponents and players (Character) and entities (Entity) can be supported.
-At the moment, one effect (Damage) is invoked for all. A choice of effect or Skill can be added in the future.

### Not realized yet
-No choice of target among your own creatures (e.g. to heal your own characters).


###Specifics:
The effects themselves process their own action and are stored at the target (Entity) in the array of effects:
-----------OnAdd allows you to take an action when applied
-----------OnUpdate allows you to take an action when the effect is updated (round, tick or whatever).
-----------OnRemove allows you to take an action when the effect is removed (and removes itself from the Entity).

Effects are triggered by the Entity itself, they get the target via Combat in both random and special selections.

Characters (Character) do not store their creatures (Entity). This information is stored in Combat.

Combat has a division into rounds and turns. Each has its own signal, which you can subscribe to (e.g. for visualisation).

The selection of the opponent (Entity) is done through signals. The signal from the Character goes to Combat, and then Combat sends a signal outside the system for the selection interface.

The system is rigidly independent of display and selection (But for the moment some outputs are in the system).

The setup and interface is implemented in CombatScene. Linking signals, character creation and more.


## RUSSIAN DESCRIPTION
### Фичи:
-Можно добавлять новые эффекты. Это может быть хил, другой тип урона или что угодно другое
-Эффекты в будущем можно объединить в класс Skill и в нём определять как эффекты применяются
-Поддерживается любое количество противников и игроков (Character) и сущностей (Entity)
-На данный момент вызывается у всех один эффект (Damage). В Будущем можно добавить выбор эффекта или Skill

### Ещё не реализовано:
-Нет выбора цели среди собственных существ (Например хилить своих персов)

### Особенности:
Эффекты сами обрабатывают своё действие и хранятся у цели (Entity) в массиве эффектов:
-----------OnAdd позволяет сделать действие при наложении
-----------OnUpdate позволяет сделать действие при обновлении эффекта (раунд, тик или что угодно)
-----------OnRemove позволяет сделать действие при снятие эффекта (и удаляет себя у существа (Entity))

Эффекты вызывают сами существа (Entity), цель они получают через Combat и в рандоме, и в специальном выборе
Персонажи (Character) не хранят своих существ (Entity). Эта информация хранится в Combat

В Combat есть разделение на раунды и ходы. У каждого есть свой сигнал, на которые можно подписаться (например для визуализации)

Выбор противника (Entity) происходит через сигналы. Сигнал от Character поступает в Combat, и дальше Combat отправляет сигнал вне системы для интерфейса выбора

Система жёстко независима от отображения и выбора (Но на данный момент некоторые выводы находятся в системе)

Настройка и интерфейс реализованы в CombatScene. Связь сигналов, создание персонажей и прочее
