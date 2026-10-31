# Villager Egg (Fabric, Minecraft 26.3)

Move villagers easily without losing their trades.

- **Pick up:** Shift + right-click a villager. It becomes a villager egg that remembers
  its profession, level, trades, discounts, name, age and biome type.
- **Place:** right-click a block with that egg. The villager appears exactly as it was.
- Works on servers (vanilla clients can join, no client mod needed) and in singleplayer/LAN.

Notes:
- A villager that has never traded keeps its job only if a workstation is near where you place it.
  Once it has traded, it keeps its profession.
- Eggs are used up when placed (not in creative).

Build: upload to GitHub, run the "build" workflow, download artifact `villager-egg-jar`.
Install: put the jar and Fabric API in `mods/`.
