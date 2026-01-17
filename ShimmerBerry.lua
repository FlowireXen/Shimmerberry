print("Loading: 'Shimmerberry'")
----------------------------------------------
------------MOD CODE -------------------------
Shimmerberry = SMODS.current_mod
Shimmerberry.Debug = false

--## Mod Integrity
SMODS.Atlas({ key = "modicon", path = "modicon.png", px = 64, py = 64 })
SMODS.Atlas({ key = "shimmerberry", path = "shimmerberry.png", px = 80, py = 80 })

--## Compatibility
Shimmerberry.compat = {
	-- Sleeves: Moar Content!!!
	sleeves = (SMODS.Mods['CardSleeves'] or {}).can_load,
	-- Others: Generic Compatibility
	buffoonery = (SMODS.Mods['Buffoonery'] or {}).can_load,
	cardpronouns = (SMODS.Mods['cardpronouns'] or {}).can_load,
}

--## Mod Desc. Style
Shimmerberry.description_loc_vars = function()
    return { background_colour = G.C.WHITE, text_colour = HEX('480032') }
end

--## Mod-Data; Files, Textures, Mod-Compat., ...
SEMBY_Data = {
	--> Base
	{ true, "functions" },
	{ true, "content/objects" },
	--> Content
	{ true, "assets" }, --> Artists
	{ true, "content/blinds", "blinds", { px = 34, py = 34, atlas_table = "ANIMATION_ATLAS", frames = 21 } },
	{ true, "content/challenges" },
	{ true, "content/decks", "decks", { px = 71, py = 95 } },
	{ true, "content/editions" },
	{ true, "content/jokers", "jokers", { px = 71, py = 95 } }, --> Berries
	{ true, "content/jokers/common" },
	{ true, "content/jokers/uncommon" },
	{ true, "content/jokers/rare" },
	{ true, "content/jokers/legendary" },
	--{ false, "planets", "planets", { px = 71, py = 95 } },
	{ Shimmerberry.compat.sleeves, "content/decks/sleeves", "sleeves", { px = 73, py = 95 } },
	{ true, "content/consumables", "consumables", { px = 71, py = 95 } },
	{ true, "content/stickers", "stickers", { px = 71, py = 95 } },
	{ true, "content/tags", "tags", { px = 34, py = 34 } },
	{ true, "content/tags/debt" },
	{ true, "content/vouchers", "vouchers", { px = 71, py = 95 } },
	--> Debug
	{ Shimmerberry.Debug, "content/debug" },
}

--## Custom File-Loader
function SEMBY_load_dir(directory)
	local files = NFS.getDirectoryItems(Shimmerberry.path.."/"..directory)
	for _, filename in ipairs(files) do
		local file_path = directory .. "/" .. filename
		if file_path:match(".lua$") then
			assert(SMODS.load_file(file_path))()
		end
	end
end

--## Load Content
-- Integrity
G.SEMBY = {}
-- Colours
loc_colour()
G.C.SEMBY_DEBUFF = G.C.PERISHABLE
G.C.SEMBY_DEGRADING = HEX('B659C7')
G.C.SEMBY_PERCENT = HEX('743AE9')--HEX('BA3AE9')
G.C.SEMBY_POSSESSIVE = HEX('743AE9')
SMODS.Gradient{ key = 'RESONANCE', colours = { HEX('1B3099'), HEX('801B99') }, cycle = 3.5, }
G.C.SEMBY_TMTRAINER = HEX('119933')
G.ARGS.LOC_COLOURS.SEMBY_debuff = G.C.SEMBY_DEBUFF
G.ARGS.LOC_COLOURS.SEMBY_degrading = G.C.SEMBY_DEGRADING
G.ARGS.LOC_COLOURS.SEMBY_percent = G.C.SEMBY_PERCENT
G.ARGS.LOC_COLOURS.SEMBY_possessive = G.C.SEMBY_POSSESSIVE
G.ARGS.LOC_COLOURS.SEMBY_resonance = SMODS.Gradients.SEMBY_RESONANCE
G.ARGS.LOC_COLOURS.SEMBY_TMTRAINER = G.C.SEMBY_TMTRAINER
-- Sounds
SMODS.Sound:register_global()
-- Textures & Code
for i = 1, #SEMBY_Data do
	if SEMBY_Data[i][1] then
		if SEMBY_Data[i][3] then
			local atlas_data = SEMBY_Data[i][4]
			atlas_data.key = 'SEMBY_'..SEMBY_Data[i][3]
			atlas_data.path = SEMBY_Data[i][3]..'.png'
			SMODS.Atlas(atlas_data)
		end
		SEMBY_load_dir(SEMBY_Data[i][2])
	end
end

------------MOD CODE END----------------------
----------------------------------------------
print("Finished: 'Shimmerberry'")
