----------------------------------------------
------------MOD CODE -------------------------
Shimmerberry = SMODS.current_mod
Shimmerberry.Debug = false
G.SEMBY = {}

--## Mod Desc. Style
Shimmerberry.description_loc_vars = function()
	return { background_colour = G.C.WHITE, text_colour = HEX('480032') }
end

--## Compatibility
Shimmerberry.compat = {
	sleeves = (SMODS.Mods['CardSleeves'] or {}).can_load,
	buffoonery = (SMODS.Mods['Buffoonery'] or {}).can_load,
	cardpronouns = (SMODS.Mods['cardpronouns'] or {}).can_load,
	display = (SMODS.Mods['JokerDisplay'] or {}).can_load,
}

--## Secrets
if Shimmerberry.config then
	if Shimmerberry.config.secrets then
		G.SEMBY.Secret = math.random() < 0.1 or false
	else Shimmerberry.config.secrets = true end
end

--## Load Content
SMODS.Atlas({ key = "modicon", path = "modicon.png", px = 64, py = 64 })
SMODS.Atlas({ key = "shimmerberry", path = G.SEMBY.Secret and "shimmersecret.png" or "shimmerberry.png", px = 80, py = 80 })

SMODS.Sound:register_global()

-- Colours
loc_colour(); local loc_ref = G.ARGS.LOC_COLOURS
--> Static
G.C.SEMBY = HEX('FF8FA9')--; loc_ref.SEMBY = G.C.SEMBY
G.C.SEMBY_DEBUFF = G.C.PERISHABLE; loc_ref.SEMBY_debuff = G.C.SEMBY_DEBUFF
G.C.SEMBY_DEGRADING = HEX('B659C7'); loc_ref.SEMBY_degrading = G.C.SEMBY_DEGRADING
G.C.SEMBY_MEMORY = HEX('8D989A')--; loc_ref.SEMBY_memory = G.C.SEMBY_MEMORY
G.C.SEMBY_PERCENT = HEX('743AE9'); loc_ref.SEMBY_percent = G.C.SEMBY_PERCENT
G.C.SEMBY_POSSESSIVE = HEX('BE3740'); loc_ref.SEMBY_possessive = G.C.SEMBY_POSSESSIVE
G.C.SEMBY_TMTRAINER = HEX('119933'); loc_ref.SEMBY_TMTRAINER = G.C.SEMBY_TMTRAINER
G.C.SEMBY_VINTAGE = HEX('C4AC6A')--; loc_ref.SEMBY_vintage = G.C.SEMBY_VINTAGE
--> Animated
SMODS.Gradient{ key = 'RESONANCE', cycle = 4.0, colours = {
	HEX('1B3099'), HEX('801B99')
}}; loc_ref.SEMBY_resonance = SMODS.Gradients.SEMBY_RESONANCE
SMODS.Gradient{ key = 'EDEN', cycle = 6.0, colours = {
	G.C.RED, G.C.RED, G.C.PURPLE, G.C.BLUE, G.C.BLUE, G.C.PURPLE
}}; loc_ref.SEMBY_eden = SMODS.Gradients.SEMBY_EDEN

-- Textures & Code
local SEMBY_Data = {
	--> Base & Artists
	{ load = true, path = "functions" },
	--> Others
	{ load = true, path = "content/objects" },
	{ load = true, path = "content/others" },
	--> Decks & Sleeves
	{ load = true, name = "decks", path = "content/decks" },
	{ load = Shimmerberry.compat.sleeves, name = "sleeves", config = { px = 73, py = 95 } },
	--> Blinds
	{ load = true, name = "blinds", config = { px = 34, py = 34, atlas_table = "ANIMATION_ATLAS", frames = 21 }, path = "content/blinds" },
	-- Skip-Tags
	{ load = true, name = "tags", config = { px = 34, py = 34 }, path = "content/tags" },
	--> Editions, Enhancements & Stickers
	{ load = true, path = "content/editions" }, --> Handles Shaders
	{ load = true, name = "enhancements", path = "content/enhancements" },
	{ load = true, name = "stickers", path = "content/stickers" },
	-- Consumables
	{ load = true, name = "consumables_anim", config = { px = 71, py = 95, atlas_table = "ANIMATION_ATLAS", frames = 6 } },
	{ load = true, name = "consumables" },
	{ load = true, path = "content/consumables" },
	-- Vouchers
	{ load = true, name = "vouchers", path = "content/vouchers" },
	--> Jokers
	{ load = true, name = "jokers_1" },
	{ load = true, name = "jokers_2" },
	{ load = true, path = "content/jokers" },
	{ load = true, path = "content/jokers/common" },
	{ load = true, path = "content/jokers/uncommon" },
	{ load = true, path = "content/jokers/rare" },
	{ load = true, path = "content/jokers/legendary" },
	--> Challenges
	{ load = true, path = "content/challenges" },
	--> Vanilla Changes
	{ load = true, path = "content/vanilla_changes" },
	--> Other Mods
	{ load = true, path = "content/crossmod" },
	--> Debug & Development
	{ load = Shimmerberry.Debug, name = "debug", path = "content/debug" },
}

for i = 1, #SEMBY_Data do
	if SEMBY_Data[i].load then
		if SEMBY_Data[i].name then
			local atlas_data = SEMBY_Data[i].config or { px = 71, py = 95 }
			atlas_data.key = 'SEMBY_'..SEMBY_Data[i].name
			atlas_data.path = SEMBY_Data[i].name..'.png'
			SMODS.Atlas(atlas_data)
		end
		if SEMBY_Data[i].path then
			local files = NFS.getDirectoryItems(Shimmerberry.path.."/"..SEMBY_Data[i].path)
			for _, filename in ipairs(files) do
				local file_path = SEMBY_Data[i].path .. "/" .. filename
				if file_path:match(".lua$") then
					assert(SMODS.load_file(file_path))()
				end
			end
		end
	end
end

------------MOD CODE END----------------------
----------------------------------------------
print("["..Shimmerberry.id.."] "..Shimmerberry.name.." v"..Shimmerberry.version.." loaded!")
