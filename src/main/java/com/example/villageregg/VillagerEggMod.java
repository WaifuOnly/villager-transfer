package com.example.villageregg;

import java.util.Locale;
import net.fabricmc.api.ModInitializer;
import net.fabricmc.fabric.api.event.player.UseBlockCallback;
import net.fabricmc.fabric.api.event.player.UseEntityCallback;
import net.minecraft.ChatFormatting;
import net.minecraft.core.BlockPos;
import net.minecraft.core.component.DataComponents;
import net.minecraft.core.registries.BuiltInRegistries;
import net.minecraft.network.chat.Component;
import net.minecraft.server.MinecraftServer;
import net.minecraft.server.level.ServerLevel;
import net.minecraft.server.level.ServerPlayer;
import net.minecraft.world.InteractionHand;
import net.minecraft.world.InteractionResult;
import net.minecraft.world.entity.Entity;
import net.minecraft.world.item.ItemStack;
import net.minecraft.world.item.component.CustomData;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Villager Egg.
 *
 * Shift + right-click a villager: it turns into a villager egg that stores ALL of its data
 * (profession, level, trades, discounts, name, age, biome type...).
 * Right-click a block with that egg: the villager is placed back exactly as it was.
 *
 * The data copying is done by the functions in data/villageregg/function, so it works with
 * whatever the villager's data looks like in this Minecraft version. Nothing custom is
 * registered, so vanilla clients can join a server that has this mod.
 */
public class VillagerEggMod implements ModInitializer {

    public static final Logger LOGGER = LoggerFactory.getLogger("villageregg");

    @Override
    public void onInitialize() {
        // Pick up: shift + right-click a villager.
        UseEntityCallback.EVENT.register((player, level, hand, entity, hit) -> {
            if (hand != InteractionHand.MAIN_HAND || player.isSpectator()) return InteractionResult.PASS;
            if (!player.isShiftKeyDown() || !isVillager(entity)) return InteractionResult.PASS;
            if (!(player instanceof ServerPlayer sp) || !(level instanceof ServerLevel sl)) {
                return InteractionResult.SUCCESS; // client side: do not open the trade screen
            }
            boolean ok = run(sl, sp, "function villageregg:make_egg {uuid:\"" + entity.getUUID() + "\"}");
            if (ok) {
                entity.discard(); // the egg exists now, so remove the villager
            } else {
                sp.sendSystemMessage(Component.literal("Could not turn this villager into an egg.")
                        .withStyle(ChatFormatting.RED), true);
            }
            return InteractionResult.SUCCESS;
        });

        // Place: right-click a block while holding a villager egg made by this mod.
        UseBlockCallback.EVENT.register((player, level, hand, hit) -> {
            if (hand != InteractionHand.MAIN_HAND || player.isSpectator()) return InteractionResult.PASS;
            ItemStack held = player.getItemInHand(hand);
            if (!isVillagerEgg(held)) return InteractionResult.PASS;
            if (!(player instanceof ServerPlayer sp) || !(level instanceof ServerLevel sl)) {
                return InteractionResult.SUCCESS; // client side: the server does the placing
            }
            BlockPos at = hit.getBlockPos().relative(hit.getDirection());
            String cmd = String.format(Locale.ROOT, "function villageregg:place {x:%.2f,y:%d,z:%.2f}",
                    at.getX() + 0.5, at.getY(), at.getZ() + 0.5);
            if (run(sl, sp, cmd)) {
                if (!sp.isCreative()) held.shrink(1);
            } else {
                sp.sendSystemMessage(Component.literal("Could not place this villager.")
                        .withStyle(ChatFormatting.RED), true);
            }
            return InteractionResult.SUCCESS;
        });

        LOGGER.info("Villager Egg loaded.");
    }

    private static boolean isVillager(Entity entity) {
        return BuiltInRegistries.ENTITY_TYPE.getKey(entity.getType()).toString().equals("minecraft:villager");
    }

    /** True for a villager spawn egg that carries the data saved by this mod. */
    private static boolean isVillagerEgg(ItemStack stack) {
        if (stack == null || stack.isEmpty()) return false;
        if (!BuiltInRegistries.ITEM.getKey(stack.getItem()).toString().equals("minecraft:villager_spawn_egg")) {
            return false;
        }
        CustomData cd = stack.get(DataComponents.CUSTOM_DATA);
        return cd != null && cd.copyTag().toString().contains("vegg");
    }

    /** Runs a function as the player, at the player. True if it ran and finished (returned 1). */
    private static boolean run(ServerLevel level, ServerPlayer sp, String functionCall) {
        MinecraftServer server = level.getServer();
        String cmd = "execute as " + sp.getUUID() + " at @s run " + functionCall;
        try {
            var source = server.createCommandSourceStack().withSuppressedOutput();
            int result = server.getCommands().getDispatcher().execute(cmd, source);
            return result > 0;
        } catch (Exception e) {
            LOGGER.error("Villager Egg command failed: {}", cmd, e);
            return false;
        }
    }
}
