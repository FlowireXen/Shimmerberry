--## SEMBY Artist-Credits
--## & SEMBY Artist-View

-- Get Info-Queue:
function SEMBY_Queue_Artist(object, info_queue)
	-- Doesn't support Collabs/Multiple Artists yet!
	if object.area and object.area.config.collection then
		local artist = "art_"..(G.SEMBY.Art[object.config.center_key] or "placeholder")
		info_queue[#info_queue + 1] = { key = artist, set = "Other" }
	end
end

-- Artists:
G.SEMBY.Artist = {
	flowire = {
		key = "flowire",
		name = "Flowire",
		colour = HEX('FF8FA9'),
		links = {
			main_page = {
				name = "GitHub",
				link = "https://github.com/FlowireXen/Shimmerberry",
			},
			alt_page = {
				name = "Discord",
				link = "https://discord.com/channels/1116389027176787968/1368380378708054067",
			},
		}
	},
	unkokat = {
		key = "unkokat",
		name = "unkokat",
		colour = HEX('1FBAFF'),
		links = {
			main_page = {
				name = "Twitter/X",
				link = "https://x.com/unkokat",
			},
			alt_page = {
				name = "Ko-fi",
				link = "https://ko-fi.com/unkokat",
			},
		}
	},
	placeholder = { key = "placeholder" },
	--WIP = { key = "WIP" },
}
-- Artists (Colours):
G.ARGS.LOC_COLOURS.SEMBY_flowire = G.SEMBY.Artist.flowire.colour
G.ARGS.LOC_COLOURS.SEMBY_unkokat = G.SEMBY.Artist.unkokat.colour

-- Credits-List:
G.SEMBY.Art = {
	--## Backs/Decks (Mod-Menu)
	b_SEMBY_hopeless = G.SEMBY.Artist.flowire.key,
	b_SEMBY_scartare = G.SEMBY.Artist.flowire.key,
	b_SEMBY_strange = G.SEMBY.Artist.flowire.key,
	--## Blinds (Mod-Menu)
	bl_SEMBY_frog = G.SEMBY.Artist.flowire.key,
	bl_SEMBY_pencil = G.SEMBY.Artist.flowire.key,
	bl_SEMBY_sharp_shooter = G.SEMBY.Artist.flowire.key,
	--## Consumables (Collection-View & Mod-Menu)
	c_SEMBY_ocean = G.SEMBY.Artist.flowire.key,
	c_SEMBY_order_shrine = G.SEMBY.Artist.flowire.key,
	c_SEMBY_soul_gem = G.SEMBY.Artist.flowire.key,
	--## Editions (Collection-View & Mod-Menu)
	e_SEMBY_pearlescent = G.SEMBY.Artist.flowire.key,
	e_SEMBY_shiny = G.SEMBY.Artist.flowire.key,
	--## Jokers (Collection-View & Mod-Menu)
	j_SEMBY_abandoned_soul = G.SEMBY.Artist.placeholder.key,
	j_SEMBY_adblocker = G.SEMBY.Artist.placeholder.key,
	j_SEMBY_afterimage = G.SEMBY.Artist.placeholder.key,
	j_SEMBY_agent_fourty_seven = G.SEMBY.Artist.flowire.key,
	j_SEMBY_alpha = G.SEMBY.Artist.placeholder.key,
	j_SEMBY_anchor = "WIP",
	j_SEMBY_annoying_dog = "WIP",
	j_SEMBY_anodized_steel = G.SEMBY.Artist.placeholder.key,
	j_SEMBY_benthic_bloom = "WIP",
	j_SEMBY_berry_blue = G.SEMBY.Artist.unkokat.key,
	j_SEMBY_berry_golden = G.SEMBY.Artist.unkokat.key,
	j_SEMBY_berry_shimmer = G.SEMBY.Artist.unkokat.key,
	j_SEMBY_berry_straw = G.SEMBY.Artist.unkokat.key,
	j_SEMBY_boosterpack_joker = G.SEMBY.Artist.flowire.key,
	j_SEMBY_bound = G.SEMBY.Artist.flowire.key,
	j_SEMBY_broken_record = "WIP",
	j_SEMBY_buccaneer = "WIP",
	j_SEMBY_butterfly = G.SEMBY.Artist.placeholder.key,
	j_SEMBY_ceaseless_void = G.SEMBY.Artist.placeholder.key,
	j_SEMBY_chrono_break = G.SEMBY.Artist.flowire.key,
	j_SEMBY_cockroach = "WIP",
	j_SEMBY_common_denominator = G.SEMBY.Artist.placeholder.key,
	j_SEMBY_copy_printer = "WIP",
	j_SEMBY_coupon = G.SEMBY.Artist.placeholder.key,
	j_SEMBY_coupon_booklet = G.SEMBY.Artist.placeholder.key,
	--j_SEMBY_debugjoker = G.SEMBY.Artist.flowire.key,
	j_SEMBY_echoing_joker = G.SEMBY.Artist.flowire.key,
	j_SEMBY_emergency_button = G.SEMBY.Artist.flowire.key,
	j_SEMBY_eternal_fortune = "WIP",
	j_SEMBY_fifty_seven_leaf_clover = "WIP",
	j_SEMBY_fortune_cookie = "WIP",
	j_SEMBY_garden_gnome = G.SEMBY.Artist.placeholder.key,
	j_SEMBY_gold_bomb = G.SEMBY.Artist.placeholder.key,
	j_SEMBY_goobert = G.SEMBY.Artist.flowire.key,
	j_SEMBY_hemoturgy = "WIP",
	j_SEMBY_hypetrain = G.SEMBY.Artist.placeholder.key,
	j_SEMBY_improv = G.SEMBY.Artist.placeholder.key,
	j_SEMBY_incinerator = G.SEMBY.Artist.placeholder.key,
	j_SEMBY_jevil = G.SEMBY.Artist.flowire.key,
	j_SEMBY_jokebra = G.SEMBY.Artist.flowire.key,
	j_SEMBY_lavish_joker = "WIP",
	j_SEMBY_lost_constellation = G.SEMBY.Artist.flowire.key,
	j_SEMBY_lottery_ticket = "WIP",
	j_SEMBY_melon = "WIP",
	j_SEMBY_mineshaft = G.SEMBY.Artist.placeholder.key,
	j_SEMBY_misery = G.SEMBY.Artist.flowire.key,
	j_SEMBY_money_laundering = G.SEMBY.Artist.flowire.key,
	j_SEMBY_nashi_pear = G.SEMBY.Artist.placeholder.key,
	j_SEMBY_oblivion = G.SEMBY.Artist.flowire.key,
	j_SEMBY_obscure_ritual = G.SEMBY.Artist.placeholder.key,
	j_SEMBY_opulent_skint = G.SEMBY.Artist.placeholder.key,
	j_SEMBY_ouroboros = G.SEMBY.Artist.placeholder.key,
	j_SEMBY_parking_disc = G.SEMBY.Artist.flowire.key,
	j_SEMBY_pay_two_win = G.SEMBY.Artist.placeholder.key,
	j_SEMBY_perfect_pitch = G.SEMBY.Artist.placeholder.key,
	j_SEMBY_pet_plastic = G.SEMBY.Artist.placeholder.key,
	j_SEMBY_piggy_bank = G.SEMBY.Artist.placeholder.key,
	j_SEMBY_pinata = G.SEMBY.Artist.placeholder.key,
	j_SEMBY_plastic_key = "WIP",
	j_SEMBY_pocket_dimension = G.SEMBY.Artist.placeholder.key,
	j_SEMBY_potted_flowers = G.SEMBY.Artist.flowire.key,
	j_SEMBY_quest = G.SEMBY.Artist.flowire.key,
	j_SEMBY_reagent = G.SEMBY.Artist.placeholder.key,
	j_SEMBY_red_mask = G.SEMBY.Artist.placeholder.key,
	j_SEMBY_ripped_joker = G.SEMBY.Artist.flowire.key,
	j_SEMBY_risky_joker = G.SEMBY.Artist.placeholder.key,
	j_SEMBY_scaffolding = G.SEMBY.Artist.placeholder.key,
	j_SEMBY_seven_wonders = G.SEMBY.Artist.placeholder.key,
	j_SEMBY_shooting_star = "WIP",
	j_SEMBY_silver_mask = G.SEMBY.Artist.placeholder.key,
	j_SEMBY_singularity = "WIP",
	j_SEMBY_stirn_librarian = G.SEMBY.Artist.placeholder.key,
	j_SEMBY_stocked_shelves = G.SEMBY.Artist.placeholder.key,
	j_SEMBY_stylish_joker = G.SEMBY.Artist.placeholder.key,
	j_SEMBY_swordswallower = "WIP",
	j_SEMBY_t3mprr = G.SEMBY.Artist.flowire.key,
	j_SEMBY_target_plush = G.SEMBY.Artist.placeholder.key,
	j_SEMBY_tempered_glass = G.SEMBY.Artist.flowire.key,
	--j_SEMBY_the_debug = G.SEMBY.Artist.flowire.key,
	j_SEMBY_the_dwarf = G.SEMBY.Artist.placeholder.key,
	j_SEMBY_the_giant = G.SEMBY.Artist.placeholder.key,
	j_SEMBY_TMTRAINER = G.SEMBY.Artist.flowire.key,
	j_SEMBY_to_and_fro = G.SEMBY.Artist.placeholder.key,
	j_SEMBY_tool_axe = G.SEMBY.Artist.placeholder.key,
	j_SEMBY_tool_hoe = G.SEMBY.Artist.placeholder.key,
	j_SEMBY_tool_pickaxe = G.SEMBY.Artist.placeholder.key,
	j_SEMBY_tool_shovel = G.SEMBY.Artist.placeholder.key,
	j_SEMBY_toolkit = G.SEMBY.Artist.placeholder.key,
	j_SEMBY_twenty_to_die_for = "WIP",
	j_SEMBY_unicorn = "WIP",
	j_SEMBY_warm_embrace = G.SEMBY.Artist.placeholder.key,
	j_SEMBY_watching_forest = G.SEMBY.Artist.placeholder.key,
	--## Stickers (Collection-View & Handled Seperatly)
	SEMBY_event_horizon = G.SEMBY.Artist.flowire.key, --> Handled in "event_horizon.lua"
	--SEMBY_forced_perishable = "Balatro", --> Edited Balatro Texture, No Credits.
	SEMBY_possessive = G.SEMBY.Artist.flowire.key, --> Handled in "possessive.lua"
	SEMBY_tmtrainer_sticker = G.SEMBY.Artist.flowire.key, --> Handled in "tmtrainer_sticker.lua"
	--## Sleeves (Mod-Menu)
	sleeve_SEMBY_burning_sl = G.SEMBY.Artist.flowire.key,
	sleeve_SEMBY_hopeless_sl = G.SEMBY.Artist.flowire.key,
	sleeve_SEMBY_scartare_sl = G.SEMBY.Artist.flowire.key,
	sleeve_SEMBY_strange_sl = G.SEMBY.Artist.flowire.key,
	--## Tags (Mod-Menu)
	tag_SEMBY_intimidating = G.SEMBY.Artist.flowire.key,
	tag_SEMBY_pearlescent_skip = G.SEMBY.Artist.flowire.key,
	tag_SEMBY_shiny_skip = G.SEMBY.Artist.flowire.key,
	tag_SEMBY_vouch_down = G.SEMBY.Artist.flowire.key,
	--## Vouchers (Collection-View & Mod-Menu)
	v_SEMBY_mask_comedy = G.SEMBY.Artist.flowire.key,
	v_SEMBY_mask_tragedy = G.SEMBY.Artist.flowire.key,
	v_SEMBY_urn_cursed = G.SEMBY.Artist.placeholder.key,
	v_SEMBY_urn_old = G.SEMBY.Artist.placeholder.key,
}

-- Collection-View; Based on Artist-Key:
function G.FUNCS.SEMBY_Artist_Collection(e)
	if e.config and e.config.view_key then
		-- Skips out on all Non-P_CENTERS Objects;
		-- Putting them into Collection-View Crashes the game
		local chaos_pool = {}
		for key, value in pairs(G.SEMBY.Art) do
			if value == e.config.view_key then
				if G.P_CENTERS[key] then
					table.insert(chaos_pool, G.P_CENTERS[key])
				--else print('Info: "'..key..'"')
				end 
			end
		end
		table.sort(chaos_pool, function (a, b)
			return not a.order or not b.order or a.order < b.order
		end)
		G.FUNCS.overlay_menu {
			definition = SMODS.card_collection_UIBox(
				chaos_pool,
				{5, 5, 5},
				--modify_card = function(card, center) card.sticker = get_joker_win_sticker(center) end,
				{no_materialize = true, h_mod = 0.95}
			)
		}
	else print('WARN: No "view_key" Provided.') end
end

-- Open Artist Website:
function G.FUNCS.SEMBY_Open_Website(e)
	if e.config and e.config.web_link then
		love.system.openURL(e.config.web_link)
	else print('WARN: No "web_link" Provided.') end
end

-- NSFW-Warning:
function G.FUNCS.SEMBY_Warn_Website(e)
    if e.config and e.config.web_link then
        G.FUNCS.overlay_menu {
			definition = create_UIBox_generic_options({
				colour = G.ACTIVE_MOD_UI and ((G.ACTIVE_MOD_UI.ui_config or {}).collection_colour or (G.ACTIVE_MOD_UI.ui_config or {}).colour),
				bg_colour = G.ACTIVE_MOD_UI and ((G.ACTIVE_MOD_UI.ui_config or {}).collection_bg_colour or (G.ACTIVE_MOD_UI.ui_config or {}).bg_colour),
				back_colour = G.ACTIVE_MOD_UI and ((G.ACTIVE_MOD_UI.ui_config or {}).collection_back_colour or (G.ACTIVE_MOD_UI.ui_config or {}).back_colour),
				outline_colour = G.ACTIVE_MOD_UI and ((G.ACTIVE_MOD_UI.ui_config or {}).collection_outline_colour or (G.ACTIVE_MOD_UI.ui_config or {}).outline_colour),
				back_func = "openModUI_"..G.ACTIVE_MOD_UI.id, contents = {
					-- Title
                    {n=G.UIT.R, config={ align = "cm" }, nodes={
                        {n=G.UIT.T, config={ text = localize('SEMBY_artist_warn_0'), scale = 0.6, shadow = true, colour = G.C.UI.TEXT_LIGHT }},
                    }},
					-- Warn-Text
					{n=G.UIT.R, config={
						align = "cm", padding = 0.2, r = 0.1, colour = G.C.GREY
					}, nodes={
						{n=G.UIT.R, config={ align = "cm", padding = 0.01 }, nodes={
							{n=G.UIT.T, config={ text = localize('SEMBY_artist_warn_1'), scale = 0.4, shadow = true, colour = G.C.UI.TEXT_LIGHT }},
						}},
						{n=G.UIT.R, config={ align = "cm", padding = 0.01 }, nodes={
							{n=G.UIT.T, config={ text = localize('SEMBY_artist_warn_2'), scale = 0.4, shadow = true, colour = G.C.UI.TEXT_LIGHT }},
						}},
						{n=G.UIT.R, config={ align = "cm", padding = 0.01 }, nodes={
							{n=G.UIT.T, config={ text = localize('SEMBY_artist_warn_3'), scale = 0.4, shadow = true, colour = G.C.UI.TEXT_LIGHT }},
						}},
					}},
					{n=G.UIT.R, config={ align = "cm", padding = 0.1 }},
					-- Proceed
					--TODO: I CAN'T FIGURE OUT HOW TO MAKE THE BUTTON AS WIDE AS THE CONTENT AAAAAAAAAAAAAAAAAA
                    {n=G.UIT.R, config={ align = "cm" }, nodes={
                        {n=G.UIT.R, config={
                            button = "SEMBY_Open_Website",
                            web_link = e.config.web_link,
                            colour = G.C.GREEN, hover = true,
                            padding = 0.1, r = 0.1, shadow = true,
							align = "cm", minw = G.ROOM.T.w * 0.25,
                        }, nodes = {{n=G.UIT.T, config={
                            text = localize('SEMBY_artist_proceed'),
                            scale = 0.5, colour = G.C.UI.TEXT_LIGHT,
                        }}}}
                    }},
				}
			})
        }
    else print('WARN: No "web_link" Provided.') end
end

-- Sound-Credits:
function G.FUNCS.SEMBY_Sound_Credits()
    G.FUNCS.overlay_menu {
		definition = create_UIBox_generic_options({
			colour = G.ACTIVE_MOD_UI and ((G.ACTIVE_MOD_UI.ui_config or {}).collection_colour or (G.ACTIVE_MOD_UI.ui_config or {}).colour),
			bg_colour = G.ACTIVE_MOD_UI and ((G.ACTIVE_MOD_UI.ui_config or {}).collection_bg_colour or (G.ACTIVE_MOD_UI.ui_config or {}).bg_colour),
			back_colour = G.ACTIVE_MOD_UI and ((G.ACTIVE_MOD_UI.ui_config or {}).collection_back_colour or (G.ACTIVE_MOD_UI.ui_config or {}).back_colour),
			outline_colour = G.ACTIVE_MOD_UI and ((G.ACTIVE_MOD_UI.ui_config or {}).collection_outline_colour or (G.ACTIVE_MOD_UI.ui_config or {}).outline_colour),
			back_func = "openModUI_"..G.ACTIVE_MOD_UI.id, contents = {
                {n=G.UIT.R, config={ align = "cm" }, nodes={
                    {n=G.UIT.T, config={ text = "Sound Credits:", scale = 0.6, shadow = true, colour = G.C.UI.TEXT_LIGHT }},
                }}, {n=G.UIT.R, config={ align = "cm" }, nodes={
				{n=G.UIT.C, config={ align = "cm" }, nodes={
					{n=G.UIT.R, config={ align = "cm", padding = 0.2, r = 0.1, colour = G.C.GREY }, nodes={
						{n=G.UIT.R, config={ align = "cm", padding = 0.01 }, nodes={ {n=G.UIT.T, config={ text = "Pearlescent & Shiny Edition:", scale = 0.4, shadow = true, colour = G.C.UI.TEXT_LIGHT }}, }},
						{n=G.UIT.R, config={ align = "cm", padding = 0.01 }, nodes={ {n=G.UIT.T, config={ text = '"achievement-sparkle" by pigeonfriend', scale = 0.4, shadow = true, colour = G.C.UI.TEXT_LIGHT }}, }},
						{n=G.UIT.R, config={ align = "cm", padding = 0.01 }, nodes={ {n=G.UIT.T, config={ text = "CC0 - https://freesound.org/s/715067", scale = 0.4, shadow = true, colour = G.C.UI.TEXT_LIGHT }}, }},
						{n=G.UIT.R, config={ align = "cm", padding = 0.01 }, nodes={ {n=G.UIT.T, config={ text = "Modified from it's original state.", scale = 0.4, shadow = true, colour = G.C.UI.TEXT_LIGHT }}, }},
					}}, {n=G.UIT.R, config={ align = "cm", padding = 0.1 }},
					{n=G.UIT.R, config={ align = "cm", padding = 0.2, r = 0.1, colour = G.C.GREY }, nodes={
						{n=G.UIT.R, config={ align = "cm", padding = 0.01 }, nodes={ {n=G.UIT.T, config={ text = "Gold Bomb Explosion:", scale = 0.4, shadow = true, colour = G.C.UI.TEXT_LIGHT }}, }},
						{n=G.UIT.R, config={ align = "cm", padding = 0.01 }, nodes={ {n=G.UIT.T, config={ text = "Made with Beepbox.com", scale = 0.4, shadow = true, colour = G.C.UI.TEXT_LIGHT }}, }},
					}},
				}},
				{n=G.UIT.C, config={ align = "cm", padding = 0.1 }},
				{n=G.UIT.C, config={ align = "cm" }, nodes={
					{n=G.UIT.R, config={ align = "cm", padding = 0.2, r = 0.1, colour = G.C.GREY }, nodes={
						{n=G.UIT.R, config={ align = "cm", padding = 0.01 }, nodes={ {n=G.UIT.T, config={ text = "Food/Crunch Sounds:", scale = 0.4, shadow = true, colour = G.C.UI.TEXT_LIGHT }}, }},
						{n=G.UIT.R, config={ align = "cm", padding = 0.01 }, nodes={ {n=G.UIT.T, config={ text = '"Apple Crunching" by Rookster', scale = 0.4, shadow = true, colour = G.C.UI.TEXT_LIGHT }}, }},
						{n=G.UIT.R, config={ align = "cm", padding = 0.01 }, nodes={ {n=G.UIT.T, config={ text = "CC0 - https://freesound.org/s/723609", scale = 0.4, shadow = true, colour = G.C.UI.TEXT_LIGHT }}, }},
						{n=G.UIT.R, config={ align = "cm", padding = 0.01 }, nodes={ {n=G.UIT.T, config={ text = "Modified from it's original state.", scale = 0.4, shadow = true, colour = G.C.UI.TEXT_LIGHT }}, }},
					}}, {n=G.UIT.R, config={ align = "cm", padding = 0.1 }},
					{n=G.UIT.R, config={ align = "cm", padding = 0.2, r = 0.1, colour = G.C.GREY }, nodes={
						{n=G.UIT.R, config={ align = "cm", padding = 0.01 }, nodes={ {n=G.UIT.T, config={ text = "Revive Sounds:", scale = 0.4, shadow = true, colour = G.C.UI.TEXT_LIGHT }}, }},
						{n=G.UIT.R, config={ align = "cm", padding = 0.01 }, nodes={ {n=G.UIT.T, config={ text = 'Inverted Balatro "Glass"-Sounds', scale = 0.4, shadow = true, colour = G.C.UI.TEXT_LIGHT }}, }},
					}},
				}} }},
				{n=G.UIT.R, config={ align = "cm", padding = 0.2, r = 0.1, colour = G.C.GREY }, nodes={
					{n=G.UIT.R, config={ align = "cm", padding = 0.01 }, nodes={ {n=G.UIT.T, config={ text = "Goobert Brush Sounds:", scale = 0.4, shadow = true, colour = G.C.UI.TEXT_LIGHT }}, }},
					{n=G.UIT.R, config={ align = "cm", padding = 0.01 }, nodes={ {n=G.UIT.T, config={ text = "Inspired by Inscryption", scale = 0.4, shadow = true, colour = G.C.UI.TEXT_LIGHT }}, }},
					{n=G.UIT.R, config={ align = "cm", padding = 0.01 }, nodes={ {n=G.UIT.T, config={ text = "Made with Beepbox.com", scale = 0.4, shadow = true, colour = G.C.UI.TEXT_LIGHT }}, }},
				}},
			}
		})
    }
end

-- Create Artist-Tab
SMODS.current_mod.extra_tabs = function()
	-- Hardcoded Switches:
	local show_placeholder = true
	local show_wip = true
	-- Create Overview
	return {{
		label = localize("SEMBY_artist_tab"),
		tab_definition_function = function()
			return {n = G.UIT.ROOT, config = {
				align = "cl", minh = G.ROOM.T.h * 0.2, padding = 0.2, r = 0.1, colour = G.C.GREY
			}, nodes = {
				-- Artists
				{n=G.UIT.R, config={ align = "cm" }, nodes={
					-- Flowire
					{n=G.UIT.C, config={ align = "cm" }, nodes={
						{n=G.UIT.R, config={ align = "cm" }, nodes={
							{n=G.UIT.C, config={
								button = "SEMBY_Artist_Collection",
								view_key = G.SEMBY.Artist.flowire.key,
								colour = G.SEMBY.Artist.flowire.colour,
								hover = true, minw = G.ROOM.T.w * 0.2,
								padding = 0.3, r = 0.1, shadow = true,
								align = "cm", -- minh = G.ROOM.T.h * 0.1,
							}, nodes = {{n=G.UIT.T, config={
								text = G.SEMBY.Artist.flowire.name,
								scale = 0.5, colour = G.C.UI.TEXT_LIGHT,
							}}}}
						}},
						{n=G.UIT.R, config={ align = "cm" }, nodes={
							{n=G.UIT.C, config={ align = "cm", padding = 0.1 }, nodes={
								{n=G.UIT.C, config={
									button = "SEMBY_Open_Website",
									web_link = G.SEMBY.Artist.flowire.links.main_page.link,
									colour = G.SEMBY.Artist.flowire.colour,
									hover = true, minw = G.ROOM.T.w * 0.095,
									padding = 0.1, r = 0.1, shadow = true,
									align = "cm", -- minh = G.ROOM.T.h * 0.1,
								}, nodes = {{n=G.UIT.T, config={
									text = G.SEMBY.Artist.flowire.links.main_page.name,
									scale = 0.4, colour = G.C.UI.TEXT_LIGHT,
								}}}}
							}},
							{n=G.UIT.C, config={ align = "cm", padding = 0.1 }, nodes={
								{n=G.UIT.C, config={
									button = "SEMBY_Open_Website",
									web_link = G.SEMBY.Artist.flowire.links.alt_page.link,
									colour = G.SEMBY.Artist.flowire.colour,
									hover = true, minw = G.ROOM.T.w * 0.095,
									padding = 0.1, r = 0.1, shadow = true,
									align = "cm", -- minh = G.ROOM.T.h * 0.1,
								}, nodes = {{n=G.UIT.T, config={
									text = G.SEMBY.Artist.flowire.links.alt_page.name,
									scale = 0.4, colour = G.C.UI.TEXT_LIGHT,
								}}}}
							}},
						}},
						{n=G.UIT.R, config={ align = "cm", padding = 0.1 }},
						{n=G.UIT.R, config={ align = "cm" }, nodes={ {n=G.UIT.C, nodes = {
							{n=G.UIT.T, config={text = localize('SEMBY_artist_other_1'), scale = 0.38, shadow = true, colour = G.C.UI.TEXT_LIGHT}},
						}}}},
						{n=G.UIT.R, config={ align = "cm" }, nodes={ {n=G.UIT.C, nodes = {
							{n=G.UIT.T, config={text = localize('SEMBY_artist_other_2'), scale = 0.38, shadow = true, colour = G.C.UI.TEXT_LIGHT}},
						}}}},
					}},
					{n=G.UIT.C, config={ align = "cm", padding = 0.2 }},
					-- unkokat
					{n=G.UIT.C, config={ align = "cm" }, nodes={
						{n=G.UIT.R, config={ align = "cm" }, nodes={
							{n=G.UIT.C, config={
								button = "SEMBY_Artist_Collection",
								view_key = G.SEMBY.Artist.unkokat.key,
								colour = G.SEMBY.Artist.unkokat.colour,
								hover = true, minw = G.ROOM.T.w * 0.2,
								padding = 0.3, r = 0.1, shadow = true,
								align = "cm", -- minh = G.ROOM.T.h * 0.1,
							}, nodes = {{n=G.UIT.T, config={
								text = G.SEMBY.Artist.unkokat.name,
								scale = 0.5, colour = G.C.UI.TEXT_LIGHT,
							}}}}
						}},
						{n=G.UIT.R, config={ align = "cm" }, nodes={
							{n=G.UIT.C, config={ align = "cm", padding = 0.1 }, nodes={
								{n=G.UIT.C, config={
									button = "SEMBY_Warn_Website",
									web_link = G.SEMBY.Artist.unkokat.links.main_page.link,
									colour = G.SEMBY.Artist.unkokat.colour,
									hover = true, minw = G.ROOM.T.w * 0.095,
									padding = 0.1, r = 0.1, shadow = true,
									align = "cm", -- minh = G.ROOM.T.h * 0.1,
								}, nodes = {{n=G.UIT.T, config={
									text = G.SEMBY.Artist.unkokat.links.main_page.name,
									scale = 0.4, colour = G.C.UI.TEXT_LIGHT,
								}}}}
							}},
							{n=G.UIT.C, config={ align = "cm", padding = 0.1 }, nodes={
								{n=G.UIT.C, config={
									button = "SEMBY_Open_Website",
									web_link = G.SEMBY.Artist.unkokat.links.alt_page.link,
									colour = G.SEMBY.Artist.unkokat.colour,
									hover = true, minw = G.ROOM.T.w * 0.095,
									padding = 0.1, r = 0.1, shadow = true,
									align = "cm", -- minh = G.ROOM.T.h * 0.1,
								}, nodes = {{n=G.UIT.T, config={
									text = G.SEMBY.Artist.unkokat.links.alt_page.name,
									scale = 0.4, colour = G.C.UI.TEXT_LIGHT,
								}}}}
							}},
						}},
						{n=G.UIT.R, config={ align = "cm", padding = 0.1 }},
						{n=G.UIT.R, config={ align = "cm" }, nodes={ {n=G.UIT.C, nodes = {
							{n=G.UIT.T, config={text = localize('SEMBY_artist_title_1'), scale = 0.38, shadow = true, colour = G.C.UI.TEXT_LIGHT}},
						}}}},
						{n=G.UIT.R, config={ align = "cm" }, nodes={ {n=G.UIT.C, nodes = {
							{n=G.UIT.T, config={text = localize('SEMBY_artist_title_2'), scale = 0.38, shadow = true, colour = G.C.UI.TEXT_LIGHT}},
						}}}},
					}},
				}},
				-- Placeholder
				{n=G.UIT.R, config={ align = "cm" }, nodes={
					-- Placeholder
					show_placeholder and {n=G.UIT.C, config={ align = "cm" }, nodes={
						{n=G.UIT.R, config={ align = "cm", padding = 0.2 }},
						{n=G.UIT.R, config={ align = "cm" }, nodes={
							{n=G.UIT.C, config={
								button = "SEMBY_Artist_Collection",
								view_key = G.SEMBY.Artist.placeholder.key,
								colour = G.C.IMPORTANT,
								hover = true, minw = G.ROOM.T.w * 0.2,
								padding = 0.2, r = 0.1, shadow = true,
								align = "cm", -- minh = G.ROOM.T.h * 0.1,
							}, nodes = {{n=G.UIT.T, config={
								text = localize("SEMBY_artist_placeholder"),
								scale = 0.4, colour = G.C.UI.TEXT_LIGHT,
							}}}}
						}},
					}} or nil,
					-- Split if Both are Active
					show_wip and show_placeholder and {n=G.UIT.C, config={ align = "cm", padding = 0.4 }} or nil,
					-- WIP
					show_wip and {n=G.UIT.C, config={ align = "cm" }, nodes={
						{n=G.UIT.R, config={ align = "cm", padding = 0.2 }},
						{n=G.UIT.R, config={ align = "cm" }, nodes={
							{n=G.UIT.C, config={
								button = "SEMBY_Artist_Collection", view_key = "WIP", colour = G.C.BLACK,
								hover = true, minw = G.ROOM.T.w * 0.2, padding = 0.2, r = 0.1, shadow = true, align = "cm",
							}, nodes = {{n=G.UIT.T, config={ text = "WIP", scale = 0.4, colour = G.C.UI.TEXT_LIGHT, }} }}
						}},
					}} or nil,
				}},
				-- Sounds
				{n=G.UIT.R, config={ align = "cm" }, nodes={
					{n=G.UIT.R, config={ align = "cm", padding = 0.2 }},
					{n=G.UIT.R, config={ align = "cm" }, nodes={
						{n=G.UIT.C, config={
							button = "SEMBY_Sound_Credits",
							colour = G.C.SECONDARY_SET.Enhanced,
							hover = true, minw = G.ROOM.T.w * 0.2,
							padding = 0.2, r = 0.1, shadow = true,
							align = "cm", -- minh = G.ROOM.T.h * 0.1,
						}, nodes = {{n=G.UIT.T, config={
							text = localize("SEMBY_artist_sound"),
							scale = 0.4, colour = G.C.UI.TEXT_LIGHT,
						}}}}
					}},
				}},
			}}
		end,
	}}
end
