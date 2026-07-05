--## SEMBY Artist-Credits
--## & SEMBY Artist-View

-- Artists:
G.SEMBY.Artist = {
	-- Technical:
	placeholder = {
		name = "ERROR",
		colour = HEX('FF00FF')
	},
	-- Main Artists:
	flowire = {
		name = "Flowire",
		colour = G.C.SEMBY,
		links = {
			main_page = {
				name = "GitHub",
				link = "https://github.com/FlowireXen/Shimmerberry",
			},
			alt_page = {
				name = "Discord",
				link = "https://discord.com/channels/1116389027176787968/1368380378708054067",
			},
		},
	},
	unkokat = {
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
		},
	},
	-- Guest Artists:
	debug = {
		name = "DEBUG",
		colour = HEX('FF00FF'),
		guest = true
	},
	ghostsalt = {
		name = "GhostSalt",
		colour = HEX('FFDDDD'),
		links = {
			guest_page = {
				name = "Mod: Phanta",
				link = "https://balatromods.miraheze.org/wiki/Phanta",
			},
		},
		guest = true
	},
	lizrushpy = {
		name = "lanedarushpy",
		colour = HEX('D9BAEE'),
		links = {
			guest_page = {
				name = "Mod: BalaCats",
				link = "https://git.gay/hazelpy/BalaCats",
			},
		},
		guest = true
	},
}
-- Artists (Colours):
G.ARGS.LOC_COLOURS.SEMBY_flowire = G.SEMBY.Artist.flowire.colour
G.ARGS.LOC_COLOURS.SEMBY_unkokat = G.SEMBY.Artist.unkokat.colour

-- PotatoPatch Inspired Credits (https://github.com/Balatro-Potato-Patch/Potato-Patch-Utils):
function SEMBY_Credits_String(artist_key)
	local artist = G.SEMBY.Artist[artist_key] or G.SEMBY.Artist['placeholder']
    return { n = G.UIT.R, config = { align = 'tm' }, nodes = {
        { n = G.UIT.R, config = { align = 'cm' }, nodes = {
			{ n = G.UIT.T, config = { text = localize('SEMBY_ART'), shadow = true, colour = G.C.UI.BACKGROUND_WHITE, scale = 0.27 } },
			{ n = G.UIT.O, config = { object = DynaText({
                string = artist.name, colours = { artist.colour }, scale = 0.27, silent = true, shadow = true, y_offset = -0.6
            })}}
		}}
    }}
end
local SEMBY_card_popup = G.UIDEF.card_h_popup
function G.UIDEF.card_h_popup(card)
    local ret_val = SEMBY_card_popup(card)
    local object = card.config.center or card.config.tag and SMODS.Tags[card.config.tag.key]
    if object and object.SEMBY_art then
    	local target = ret_val.nodes[1].nodes[1].nodes[1].nodes
        local str = SEMBY_Credits_String(object.SEMBY_art)
        if str then table.insert(target, str) end
    end
    return ret_val
end
local SEMBY_blind_popup = create_UIBox_blind_popup
function create_UIBox_blind_popup(blind, discovered, vars)
    local ret_val = SEMBY_blind_popup(blind, discovered, vars)
    if blind and blind.SEMBY_art then
        local str = SEMBY_Credits_String(blind.SEMBY_art)
        if str then table.insert(ret_val.nodes, str) end
    end
    return ret_val
end

-- Collection-View; Based on Artist-Key:
function G.FUNCS.SEMBY_Artist_Collection(e)
	if e.config and e.config.view_key then
		local chaos_pool = {}
		local guest_pool = {}
		-- Skips out on all Non-P_CENTERS Objects:
		for key, _ in pairs(G.P_CENTERS) do
			if G.P_CENTERS[key] and G.P_CENTERS[key].SEMBY_art then
				if G.P_CENTERS[key].SEMBY_art == e.config.view_key then
					table.insert(chaos_pool, G.P_CENTERS[key])
				elseif e.config.view_guests then
					for guest_key, guest_values in pairs(G.SEMBY.Artist) do
						if guest_values.guest and G.P_CENTERS[key].SEMBY_art == guest_key then
							table.insert(guest_pool, G.P_CENTERS[key])
							break
						end
					end
				end
			end
		end
		table.sort(chaos_pool, function (a, b)
			return not a.order or not b.order or a.order < b.order
		end)
		if #guest_pool ~= 0 then
			table.sort(guest_pool, function (a, b)
				return not a.order or not b.order or a.order < b.order
			end)
			for i = 1, #guest_pool do
				table.insert(chaos_pool, guest_pool[i])
			end
		end
		G.FUNCS.overlay_menu {
			definition = SMODS.card_collection_UIBox( chaos_pool, {5, 5, 5}, {no_materialize = true, h_mod = 0.95} )
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
                        {n=G.UIT.T, config={ text = localize('SEMBY_artist_warn_title'), scale = 0.6, shadow = true, colour = G.C.RED }},
                    }},
					-- Warn-Text
					{n=G.UIT.R, config={
						align = "cm", padding = 0.2, r = 0.1, colour = G.C.GREY
					}, nodes={
						{n=G.UIT.R, config={ align = "cm", padding = 0.01 }, nodes={
							{n=G.UIT.T, config={ text = localize('SEMBY_artist_warn_nsfw_1'), scale = 0.4, shadow = true, colour = G.C.UI.TEXT_LIGHT }},
						}},
						{n=G.UIT.R, config={ align = "cm", padding = 0.01 }, nodes={
							{n=G.UIT.T, config={ text = localize('SEMBY_artist_warn_nsfw_2'), scale = 0.4, shadow = true, colour = G.C.UI.TEXT_LIGHT }},
						}},
						{n=G.UIT.R, config={ align = "cm", padding = 0.01 }, nodes={
							{n=G.UIT.T, config={ text = localize('SEMBY_artist_warn_nsfw_3'), scale = 0.4, shadow = true, colour = G.C.UI.TEXT_LIGHT }},
						}},
					}},
					{n=G.UIT.R, config={ align = "cm", padding = 0.1 }},
					-- Proceed
                    {n=G.UIT.R, config={ align = "cm" }, nodes={
                        {n=G.UIT.R, config={
                            button = "SEMBY_Open_Website",
                            web_link = e.config.web_link,
                            colour = G.C.GREEN, hover = true,
                            padding = 0.1, r = 0.1, shadow = true,
							align = "cm", minw = G.ROOM.T.w * 0.25,
                        }, nodes = {{n=G.UIT.T, config={
                            text = localize('SEMBY_artist_warn_proceed'),
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
						{n=G.UIT.R, config={ align = "cm", padding = 0.2, r = 0.1, colour = G.C.BLACK }, nodes={
							{n=G.UIT.R, config={ align = "cm", padding = 0.01 }, nodes={ {n=G.UIT.T, config={ text = 'Pearlescent & Shiny Edition:', scale = 0.4, colour = G.C.IMPORTANT }}, }},
							{n=G.UIT.R, config={ align = "cm", padding = 0.01 }, nodes={ {n=G.UIT.T, config={ text = '"achievement-sparkle" by pigeonfriend', scale = 0.4, colour = G.C.UI.TEXT_LIGHT }}, }},
							{n=G.UIT.R, config={ align = "cm", padding = 0.01 }, nodes={ {n=G.UIT.T, config={ text = "CC0: https://freesound.org/s/715067", scale = 0.4, colour = G.C.BLUE, button = "SEMBY_Open_Website", web_link = "https://freesound.org/s/715067" }}, }},
							{n=G.UIT.R, config={ align = "cm", padding = 0.01 }, nodes={ {n=G.UIT.T, config={ text = "Modified from it's original state.", scale = 0.3, colour = G.C.UI.TEXT_INACTIVE }}, }},
						}}, {n=G.UIT.R, config={ align = "cm", padding = 0.1 }},
						{n=G.UIT.R, config={ align = "cm", padding = 0.2, r = 0.1, colour = G.C.BLACK }, nodes={
							{n=G.UIT.R, config={ align = "cm", padding = 0.01 }, nodes={ {n=G.UIT.T, config={ text = 'Eden Token Consumable:', scale = 0.4, colour = G.C.IMPORTANT }}, }},
							{n=G.UIT.R, config={ align = "cm", padding = 0.01 }, nodes={ {n=G.UIT.T, config={ text = '"Short Choir" by Breviceps', scale = 0.4, colour = G.C.UI.TEXT_LIGHT }}, }},
							{n=G.UIT.R, config={ align = "cm", padding = 0.01 }, nodes={ {n=G.UIT.T, config={ text = "CC0: https://freesound.org/s/444491", scale = 0.4, colour = G.C.BLUE, button = "SEMBY_Open_Website", web_link = "https://freesound.org/s/444491" }}, }},
							{n=G.UIT.R, config={ align = "cm", padding = 0.01 }, nodes={ {n=G.UIT.T, config={ text = "Modified from it's original state.", scale = 0.3, colour = G.C.UI.TEXT_INACTIVE }}, }},
						}}, {n=G.UIT.R, config={ align = "cm", padding = 0.1 }},
						{n=G.UIT.R, config={ align = "cm", padding = 0.2, r = 0.1, colour = G.C.BLACK }, nodes={
							{n=G.UIT.R, config={ align = "cm", padding = 0.01 }, nodes={ {n=G.UIT.T, config={ text = 'Goobert Joker:', scale = 0.4, colour = G.C.IMPORTANT }}, }},
							{n=G.UIT.R, config={ align = "cm", padding = 0.01 }, nodes={ {n=G.UIT.T, config={ text = "Inspired by Inscryption", scale = 0.4, colour = G.C.UI.TEXT_LIGHT }}, }},
							{n=G.UIT.R, config={ align = "cm", padding = 0.01 }, nodes={ {n=G.UIT.T, config={ text = "Made with Beepbox.com", scale = 0.4, colour = G.C.UI.TEXT_LIGHT }}, }},
						}}, {n=G.UIT.R, config={ align = "cm", padding = 0.1 }},
						{n=G.UIT.R, config={ align = "cm", padding = 0.2, r = 0.1, colour = G.C.BLACK }, nodes={
							{n=G.UIT.R, config={ align = "cm", padding = 0.01 }, nodes={ {n=G.UIT.T, config={ text = 'Gold Bomb Joker:', scale = 0.4, colour = G.C.IMPORTANT }}, }},
							{n=G.UIT.R, config={ align = "cm", padding = 0.01 }, nodes={ {n=G.UIT.T, config={ text = "Made with Beepbox.com", scale = 0.4, colour = G.C.UI.TEXT_LIGHT }}, }},
						}},
					}},
					{n=G.UIT.C, config={ align = "cm", padding = 0.1 }},
					{n=G.UIT.C, config={ align = "cm" }, nodes={
						{n=G.UIT.R, config={ align = "cm", padding = 0.2, r = 0.1, colour = G.C.BLACK }, nodes={
							{n=G.UIT.R, config={ align = "cm", padding = 0.01 }, nodes={ {n=G.UIT.T, config={ text = "Food/Crunch Sounds:", scale = 0.4, colour = G.C.IMPORTANT }}, }},
							{n=G.UIT.R, config={ align = "cm", padding = 0.01 }, nodes={ {n=G.UIT.T, config={ text = '"Apple Crunching" by Rookster', scale = 0.4, colour = G.C.UI.TEXT_LIGHT }}, }},
							{n=G.UIT.R, config={ align = "cm", padding = 0.01 }, nodes={ {n=G.UIT.T, config={ text = "CC0: https://freesound.org/s/723609", scale = 0.4, colour = G.C.BLUE, button = "SEMBY_Open_Website", web_link = "https://freesound.org/s/723609" }}, }},
							{n=G.UIT.R, config={ align = "cm", padding = 0.01 }, nodes={ {n=G.UIT.T, config={ text = "Modified from it's original state.", scale = 0.3, colour = G.C.UI.TEXT_INACTIVE }}, }},
						}}, {n=G.UIT.R, config={ align = "cm", padding = 0.1 }},
						{n=G.UIT.R, config={ align = "cm", padding = 0.2, r = 0.1, colour = G.C.BLACK }, nodes={
							{n=G.UIT.R, config={ align = "cm", padding = 0.01 }, nodes={ {n=G.UIT.T, config={ text = 'Scav. Prototype Joker:', scale = 0.4, colour = G.C.IMPORTANT }}, }},
							{n=G.UIT.R, config={ align = "cm", padding = 0.01 }, nodes={ {n=G.UIT.T, config={ text = '"Magic - Finger snap" by Vrymaa', scale = 0.4, colour = G.C.UI.TEXT_LIGHT }}, }},
							{n=G.UIT.R, config={ align = "cm", padding = 0.01 }, nodes={ {n=G.UIT.T, config={ text = "CC0: https://freesound.org/s/807391", scale = 0.4, colour = G.C.BLUE, button = "SEMBY_Open_Website", web_link = "https://freesound.org/s/807391" }}, }},
							{n=G.UIT.R, config={ align = "cm", padding = 0.01 }, nodes={ {n=G.UIT.T, config={ text = "Modified from it's original state.", scale = 0.3, colour = G.C.UI.TEXT_INACTIVE }}, }},
						}}, {n=G.UIT.R, config={ align = "cm", padding = 0.1 }},
						{n=G.UIT.R, config={ align = "cm", padding = 0.2, r = 0.1, colour = G.C.BLACK }, nodes={
							{n=G.UIT.R, config={ align = "cm", padding = 0.01 }, nodes={ {n=G.UIT.T, config={ text = 'Resonance Edition:', scale = 0.4, colour = G.C.IMPORTANT }}, }},
							{n=G.UIT.R, config={ align = "cm", padding = 0.01 }, nodes={ {n=G.UIT.T, config={ text = "Inspired by Destiny 2", scale = 0.4, colour = G.C.UI.TEXT_LIGHT }}, }},
							{n=G.UIT.R, config={ align = "cm", padding = 0.01 }, nodes={ {n=G.UIT.T, config={ text = "Mixed & Modified Game-Sound", scale = 0.4, colour = G.C.UI.TEXT_LIGHT }}, }},
						}}, {n=G.UIT.R, config={ align = "cm", padding = 0.1 }},
						{n=G.UIT.R, config={ align = "cm", padding = 0.2, r = 0.1, colour = G.C.BLACK }, nodes={
							{n=G.UIT.R, config={ align = "cm", padding = 0.01 }, nodes={ {n=G.UIT.T, config={ text = "Revive Sounds:", scale = 0.4, colour = G.C.IMPORTANT }}, }},
							{n=G.UIT.R, config={ align = "cm", padding = 0.01 }, nodes={ {n=G.UIT.T, config={ text = 'Inverted Balatro "Glass"-Sounds', scale = 0.4, colour = G.C.UI.TEXT_LIGHT }}, }},
						}},
					}},
			    }}
			}
		})
    }
end

-- Create Credits-Tab [Not Translated]
SMODS.current_mod.extra_tabs = function()
	return {{
		label = "Credits",
		tab_definition_function = function()
			return {n = G.UIT.ROOT, config = {
				align = "tm", minw = 4, minh = 4, padding = 0.2, r = 0.1, colour = G.C.GREY
			}, nodes = {
				{n=G.UIT.R, config={ align = "cm" }, nodes={
					-- Flowire
					{n=G.UIT.C, config={ align = "cm" }, nodes={
						{n=G.UIT.R, config={ align = "cm" }, nodes={
							{n=G.UIT.C, config={
								button = "SEMBY_Artist_Collection",
								view_key = "flowire",
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
							{n=G.UIT.T, config={text = "Also created Sticker", scale = 0.38, shadow = true, colour = G.C.UI.TEXT_LIGHT}},
						}}}},
						{n=G.UIT.R, config={ align = "cm" }, nodes={ {n=G.UIT.C, nodes = {
							{n=G.UIT.T, config={text = "and Blind Textures!", scale = 0.38, shadow = true, colour = G.C.UI.TEXT_LIGHT}},
						}}}},
					}},
					{n=G.UIT.C, config={ align = "cm", padding = 0.2 }},
					-- unkokat
					{n=G.UIT.C, config={ align = "cm" }, nodes={
						{n=G.UIT.R, config={ align = "cm" }, nodes={
							{n=G.UIT.C, config={
								button = "SEMBY_Artist_Collection",
								view_key = "unkokat",
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
							{n=G.UIT.T, config={text = "Also created Titlescreen-", scale = 0.38, shadow = true, colour = G.C.UI.TEXT_LIGHT}},
						}}}},
						{n=G.UIT.R, config={ align = "cm" }, nodes={ {n=G.UIT.C, nodes = {
							{n=G.UIT.T, config={text = "Berry, Mod-Logo & Icon!", scale = 0.38, shadow = true, colour = G.C.UI.TEXT_LIGHT}},
						}}}},
					}},
				}},
				{n=G.UIT.R, config={ align = "cm" }, nodes={
					-- Placeholders & Guests
					{n=G.UIT.C, config={ align = "cm" }, nodes={
						{n=G.UIT.R, config={ align = "cm", padding = 0.2 }},
						{n=G.UIT.R, config={ align = "cm" }, nodes={
							{n=G.UIT.C, config={
								button = "SEMBY_Artist_Collection",
								view_key = "placeholder", view_guests = true,
								colour = G.C.CHANCE,
								hover = true, minw = G.ROOM.T.w * 0.2,
								padding = 0.2, r = 0.1, shadow = true,
								align = "cm", -- minh = G.ROOM.T.h * 0.1,
							}, nodes = {{n=G.UIT.T, config={
								text = "Guest Artists",
								scale = 0.4, colour = G.C.UI.TEXT_LIGHT,
							}}}}
						}},
					}},
					{n=G.UIT.C, config={ align = "cm", padding = 0.4 }},
					-- Sounds
					{n=G.UIT.C, config={ align = "cm" }, nodes={
						{n=G.UIT.R, config={ align = "cm", padding = 0.2 }},
						{n=G.UIT.R, config={ align = "cm" }, nodes={
							{n=G.UIT.C, config={
								button = "SEMBY_Sound_Credits",
								colour = G.C.SECONDARY_SET.Enhanced,
								hover = true, minw = G.ROOM.T.w * 0.2,
								padding = 0.2, r = 0.1, shadow = true,
								align = "cm", -- minh = G.ROOM.T.h * 0.1,
							}, nodes = {{n=G.UIT.T, config={
								text = "Sounds",
								scale = 0.4, colour = G.C.UI.TEXT_LIGHT,
							}}}}
						}},
					}},
				}},
			}}
		end,
	}}
end
