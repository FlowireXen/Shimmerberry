print("Loading: 'Shimmerberry'")
----------------------------------------------
------------MOD CODE -------------------------
local Shimmerberry = SMODS.current_mod
Shimmerberry.Debug = false

--## Mod Integrity
SMODS.Atlas({ key = "modicon", path = "modicon.png", px = 48, py = 48 })
SMODS.Atlas({ key = "shimmerberry", path = "shimmerberry.png", px = 333, py = 216 })

--## Mod Desc. Style
Shimmerberry.description_loc_vars = function()
    return { background_colour = G.C.WHITE, text_colour = HEX('480032') }
end

--## Mod-Data; Files, Textures, Mod-Compat., ...
SEMBY_Data = {
	--> Base
	{ true, "functions" },
	--> Content
	{ true, "assets" }, --> Artists
	{ true, "blinds", "blinds", { px = 34, py = 34, atlas_table = "ANIMATION_ATLAS", frames = 21 } },
	{ true, "challenges" },
	{ true, "decks", "decks", { px = 71, py = 95 } },
	{ true, "editions" },
	{ true, "jokers", "jokers", { px = 71, py = 95 } }, --> Berries
	{ true, "jokers/common" },
	{ true, "jokers/uncommon" },
	{ true, "jokers/rare" },
	{ true, "jokers/legendary" },
	--{ false, "planets", "planets", { px = 71, py = 95 } },
	{ (SMODS.Mods['CardSleeves'] or {}).can_load, "decks/sleeves", "sleeves", { px = 73, py = 95 } },
	{ true, "spectrals", "spectrals", { px = 71, py = 95 } },
	{ true, "stickers", "stickers", { px = 71, py = 95 } },
	{ true, "tags", "tags", { px = 34, py = 34 } },
	{ true, "tarots", "tarots", { px = 71, py = 95 } },
	{ true, "vouchers", "vouchers", { px = 71, py = 95 } },
	--> Debug
	{ Shimmerberry.Debug, "debug" },
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
G.SEMBY = {}
loc_colour()
G.ARGS.LOC_COLOURS.SEMBY_percent = HEX('743AE9')
G.ARGS.LOC_COLOURS.SEMBY_TMTRAINER = HEX('119933')
SMODS.Sound:register_global()
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
