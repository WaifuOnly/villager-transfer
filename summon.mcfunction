$summon minecraft:villager $(x) $(y) $(z) $(v)
$particle minecraft:happy_villager $(x) $(y) $(z) 0.4 0.6 0.4 0 20
playsound minecraft:entity.villager.yes player @s ~ ~ ~ 1 1
title @s actionbar {"text":"Villager placed","color":"green"}
return 1
