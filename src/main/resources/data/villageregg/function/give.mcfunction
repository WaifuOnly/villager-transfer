$give @s minecraft:villager_spawn_egg[minecraft:custom_data={vegg:$(v)},minecraft:custom_name={"text":"$(title)","color":"green","italic":false},minecraft:lore=[{"text":"Level $(level) | $(trades) trades","color":"gray","italic":false},{"text":"Right-click a block to place it back.","color":"dark_gray","italic":false}],minecraft:enchantment_glint_override=true] 1
$title @s actionbar {"text":"Captured: $(title) (Level $(level))","color":"green"}
playsound minecraft:entity.villager.celebrate player @s ~ ~ ~ 1 1.2
particle minecraft:happy_villager ~ ~1 ~ 0.4 0.6 0.4 0 20
