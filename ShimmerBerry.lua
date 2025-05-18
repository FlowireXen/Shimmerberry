--- STEAMODDED HEADER
--- MOD_NAME: Shimmerberry
--- MOD_ID: SEMBY
--- PREFIX: SEMBY
--- MOD_AUTHOR: [Flowire]
----------------------------------------------
------------MOD CODE -------------------------

local mod_path = SMODS.current_mod.path

-- Mod Icon
SMODS.Atlas { key = "modicon", path = "mod_icon.png", px = 32, py = 32 }

--## Jokers
SMODS.Atlas { key = "jokers", path = "jokers.png", px = 71, py = 95 }
-- Seperatly asserted Jokers *smiles*
assert(SMODS.load_file('jokers/abandoned_soul.lua'))()
assert(SMODS.load_file('jokers/boosterpack_joker.lua'))()
assert(SMODS.load_file('jokers/bound.lua'))()
assert(SMODS.load_file('jokers/echoing_joker.lua'))()
assert(SMODS.load_file('jokers/emergency_button.lua'))()
assert(SMODS.load_file('jokers/jevil.lua'))()
assert(SMODS.load_file('jokers/loop_hero.lua'))()
assert(SMODS.load_file('jokers/lost_constellation.lua'))()
assert(SMODS.load_file('jokers/misery_joker.lua'))()
assert(SMODS.load_file('jokers/money_laundering.lua'))()
assert(SMODS.load_file('jokers/potted_flowers.lua'))()
assert(SMODS.load_file('jokers/shooting_star.lua'))()
assert(SMODS.load_file('jokers/swordswallower.lua'))()
assert(SMODS.load_file('jokers/tonfro_joker.lua'))()
assert(SMODS.load_file('jokers/true_mystery.lua'))()

--assert(SMODS.load_file('jokers/aaafreeidea.lua'))()

-- Debug Joker
--assert(SMODS.load_file('jokers/DEBUG.lua'))()

--## Blinds
SMODS.Atlas({ key = "critterblinds", atlas_table = "ANIMATION_ATLAS", path = "critterblinds.png", px = 34, py = 34, frames = 21 })
local blinds = {
    "frog",
    "pencil",
    "ten_pace"
}
for k1, v1 in ipairs(blinds) do
    local blind = NFS.load(mod_path .. "blinds/" .. v1 .. ".lua")()
    if not blind then
        print("[Shimmerberry]: Blind messed up, you dummy; " .. v1)
    else
        blind.key = v1
        blind.discovered = false 
        local objection = SMODS.Blind(blind)
        for k2, v2 in pairs(blind) do
            if type(v2) == 'function' then
                objection[k2] = blind[k2]
            end
        end
    end
end

--## Decks
SMODS.Atlas { key = 'shimmer_decks', path = "decks.png", px = 71, py = 95 }
NFS.load(mod_path .. 'decks/skat.lua')()

--## Sleeves
local sleeves = (SMODS.Mods['CardSleeves'] or {}).can_load
if sleeves then
	SMODS.Atlas { key = 'shimmer_sleeves', path = "sleeves.png", px = 73, py = 95 }
	NFS.load(mod_path .. 'decks/sleeves/skat.lua')()
end

--## Final Info :)
print("'ShimmerBerry' Loaded!")
----------------------------------------------
------------MOD CODE END----------------------
