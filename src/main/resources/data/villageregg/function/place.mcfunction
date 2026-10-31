# Called with {x:..,y:..,z:..} as the player holding the egg.
$data modify storage villageregg:tmp q set value {x:$(x),y:$(y),z:$(z)}
data modify storage villageregg:tmp q.v set from entity @s SelectedItem.components."minecraft:custom_data".vegg
data modify storage villageregg:tmp ok set value 0b
execute store success storage villageregg:tmp ok byte 1 run function villageregg:summon with storage villageregg:tmp q
execute if data storage villageregg:tmp {ok:1b} unless entity @s[gamemode=creative] run item modify entity @s weapon.mainhand villageregg:consume
return 1
