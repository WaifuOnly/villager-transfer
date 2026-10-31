# Called with {uuid:"<villager uuid>"} as the player. Copies the villager into an egg.
$data modify storage villageregg:tmp v set from entity $(uuid)
data modify storage villageregg:tmp v.id set value "minecraft:villager"

# remove things that only make sense in the old place
data remove storage villageregg:tmp v.Pos
data remove storage villageregg:tmp v.Motion
data remove storage villageregg:tmp v.Rotation
data remove storage villageregg:tmp v.UUID
data remove storage villageregg:tmp v.Passengers
data remove storage villageregg:tmp v.leash
data remove storage villageregg:tmp v.FallDistance
data remove storage villageregg:tmp v.Fire
data remove storage villageregg:tmp v.PortalCooldown
data remove storage villageregg:tmp v.Brain.memories."minecraft:job_site"
data remove storage villageregg:tmp v.Brain.memories."minecraft:potential_job_site"
data remove storage villageregg:tmp v.Brain.memories."minecraft:home"
data remove storage villageregg:tmp v.Brain.memories."minecraft:meeting_point"

# text for the egg
data modify storage villageregg:tmp a set value {title:"Villager",level:1,trades:0}
execute if data storage villageregg:tmp v.VillagerData{profession:"minecraft:none"} run data modify storage villageregg:tmp a.title set value "Unemployed Villager"
execute if data storage villageregg:tmp v.VillagerData{profession:"minecraft:nitwit"} run data modify storage villageregg:tmp a.title set value "Nitwit Villager"
execute if data storage villageregg:tmp v.VillagerData{profession:"minecraft:armorer"} run data modify storage villageregg:tmp a.title set value "Armorer Villager"
execute if data storage villageregg:tmp v.VillagerData{profession:"minecraft:butcher"} run data modify storage villageregg:tmp a.title set value "Butcher Villager"
execute if data storage villageregg:tmp v.VillagerData{profession:"minecraft:cartographer"} run data modify storage villageregg:tmp a.title set value "Cartographer Villager"
execute if data storage villageregg:tmp v.VillagerData{profession:"minecraft:cleric"} run data modify storage villageregg:tmp a.title set value "Cleric Villager"
execute if data storage villageregg:tmp v.VillagerData{profession:"minecraft:farmer"} run data modify storage villageregg:tmp a.title set value "Farmer Villager"
execute if data storage villageregg:tmp v.VillagerData{profession:"minecraft:fisherman"} run data modify storage villageregg:tmp a.title set value "Fisherman Villager"
execute if data storage villageregg:tmp v.VillagerData{profession:"minecraft:fletcher"} run data modify storage villageregg:tmp a.title set value "Fletcher Villager"
execute if data storage villageregg:tmp v.VillagerData{profession:"minecraft:leatherworker"} run data modify storage villageregg:tmp a.title set value "Leatherworker Villager"
execute if data storage villageregg:tmp v.VillagerData{profession:"minecraft:librarian"} run data modify storage villageregg:tmp a.title set value "Librarian Villager"
execute if data storage villageregg:tmp v.VillagerData{profession:"minecraft:mason"} run data modify storage villageregg:tmp a.title set value "Mason Villager"
execute if data storage villageregg:tmp v.VillagerData{profession:"minecraft:shepherd"} run data modify storage villageregg:tmp a.title set value "Shepherd Villager"
execute if data storage villageregg:tmp v.VillagerData{profession:"minecraft:toolsmith"} run data modify storage villageregg:tmp a.title set value "Toolsmith Villager"
execute if data storage villageregg:tmp v.VillagerData{profession:"minecraft:weaponsmith"} run data modify storage villageregg:tmp a.title set value "Weaponsmith Villager"
data modify storage villageregg:tmp a.level set from storage villageregg:tmp v.VillagerData.level
execute store result storage villageregg:tmp a.trades int 1 run data get storage villageregg:tmp v.Offers.Recipes
data modify storage villageregg:tmp a.v set from storage villageregg:tmp v

function villageregg:give with storage villageregg:tmp a
return 1
