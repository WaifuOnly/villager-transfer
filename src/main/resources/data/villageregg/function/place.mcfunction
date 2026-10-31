# Called with {x:..,y:..,z:..} as the player holding the egg.
$data modify storage villageregg:tmp q set value {x:$(x),y:$(y),z:$(z)}
data modify storage villageregg:tmp q.v set from entity @s SelectedItem.components."minecraft:custom_data".vegg
function villageregg:summon with storage villageregg:tmp q
return 1
