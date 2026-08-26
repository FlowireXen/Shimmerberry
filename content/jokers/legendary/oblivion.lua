local Reset_Ante = 1
local Global_Key = 'oblivion'
local Global_Add = 1.0
-- Joker
SMODS.Joker {
	key = "oblivion",
	SEMBY_art = "flowire",
	atlas = "SEMBY_jokers_1",
	pos = { x = 7, y = 4 },
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
	rarity = 4,
	cost = 20,
    config = {
		extra = {
			xmult = 1.0,
			xmult_mod = 1.0,
			loop = 0
		}
	},
    attributes = {
		'xmult', 'scaling', 'xblindsize',
		'ante'
	},
	loc_vars = function(self, info_queue, card)
		return { vars = {
			Reset_Ante,
			card.ability.extra.xmult_mod,
			card.ability.extra.xmult,
			Global_Add * 100
		} }
    end,
    add_to_deck = function(self, card, from_debuff)
		if not from_debuff then card.ability.extra.loop = 0 end
		G.GAME.SEMBY_oblivion = (G.GAME.SEMBY_oblivion or 0) + 1
	end,
    remove_from_deck = function(self, card, from_debuff)
		G.GAME.SEMBY_oblivion = (G.GAME.SEMBY_oblivion or 0) - 1
		if G.GAME.SEMBY_oblivion <= 0 then G.GAME.SEMBY_oblivion = nil end
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return { xmult = card.ability.extra.xmult }
		end
		if context.ante_change and not context.blueprint and G.GAME.SEMBY_oblivion_reset then
			local xmult_gain = G.GAME.SEMBY_oblivion_reset * card.ability.extra.xmult_mod
			card.ability.extra.xmult = card.ability.extra.xmult + xmult_gain
			card.ability.extra.loop = math.floor(card.ability.extra.loop + 1)
			return {
				message = localize{ type = 'variable', key = 'a_xmult', vars = { round_number(xmult_gain, 2) } },
				colour = G.C.XMULT or G.C.MULT,
				extra = {
					message = localize{ type = 'variable', key = 'SEMBY_loop', vars = { card.ability.extra.loop } },
					colour = G.C.DARK_EDITION
				}
			}
		end
	end
}

local update_round_eval = Game.update_round_eval
function Game.update_round_eval(dt)
    if G.GAME.SEMBY_oblivion_state then
		if not G.STATE_COMPLETE then
        	stop_use()
        	G.STATE_COMPLETE = true
        	G.E_MANAGER:add_event(Event({
        	    trigger = 'immediate',
        	    func = function()
        			save_run()
					G.SEMBY_oblival = UIBox{ definition = SEMBY_OblivionChoice_UI(), config = {
						align = "bm", offset = { x = 0, y = G.ROOM.T.y+19 }, major = G.hand, bond = 'Weak'
					}}
        	        G.E_MANAGER:add_event(Event({
        	            trigger = 'immediate',
        	            func = function()
        	                if G.SEMBY_oblival.alignment.offset.y ~= -7.0 then
        	                    G.SEMBY_oblival.alignment.offset.y = -7.0
        	                else if math.abs(G.SEMBY_oblival.T.y - G.SEMBY_oblival.VT.y) < 3 then
        	                    G.ROOM.jiggle = G.ROOM.jiggle + 2
        	                    play_sound('cardFan2')
        	                    delay(0.1)
        	                    return true
							end end
        	        	end
					}))
        	        return true
        	    end
        	}))
		end
	else update_round_eval(dt) end
end

function SEMBY_OblivionChoice_UI()
	-- Values
	local ante_curr = G.GAME.round_resets and G.GAME.round_resets.ante or 1
	local ante_amnt = math.abs(ante_curr - Reset_Ante)
	-- Texts
	local title_text = localize('k_choose')..'...'
	local back_texts, blind_texts = localize('SEMBY_loop_back'), localize('SEMBY_loop_blind')
	local dont_texts, dont_nodes = localize('SEMBY_loop_dont'), {}
	for i = 1, #dont_texts do dont_nodes[#dont_nodes+1] = { n = G.UIT.R, config = { align = "cm" }, nodes = {
		{ n = G.UIT.T, config = { text = dont_texts[i], scale = 0.45, colour = G.C.UI.TEXT_LIGHT }}
	}} end
	-- Sprite
	local oblivion_sprite = SMODS.create_sprite(0, 0, 1.875, 2.5, SMODS.get_atlas('SEMBY_jokers_1'), { x = 7, y = 4 })
	oblivion_sprite:define_draw_steps({{ shader = 'dissolve', shadow_height = 0.05 }, { shader = 'dissolve' }})
	oblivion_sprite.states.collide.can = true; oblivion_sprite.states.hover.can = true
	oblivion_sprite.states.drag.can = false; oblivion_sprite.states.click.can = false
	-- Return UI
  	local choice = { n = G.UIT.ROOT, config = { align = 'tm', colour = G.C.CLEAR }, nodes = {
		{ n = G.UIT.R, config = { align = "cm", padding = 0.03, colour = G.C.UI.TRANSPARENT_DARK, r = 0.1 }, nodes = {
			{ n = G.UIT.R, config = { align = "cm", padding = 0.05, colour = G.C.DYN_UI.MAIN, r = 0.1 }, nodes = {
				{ n = G.UIT.R, config = { align = "tm", colour = G.C.DYN_UI.BOSS_DARK, r = 0.1, padding = 0.2 }, nodes = {
					{ n = G.UIT.C, config = {
						align = "cm", padding = 0.2, r = 0.1, colour = darken(G.C.RED, 0.25),
						minh = G.ROOM.T.h * 0.25, minw = G.ROOM.T.w * 0.225, shadow = true,
						hover = true, button = "SEMBY_OblivionChoice", oblivion = ante_amnt
					}, nodes = {
						{ n = G.UIT.R, config = { align = "cm" }, nodes = {
							{ n = G.UIT.T, config = { text = back_texts[1], scale = 0.45, colour = G.C.UI.TEXT_LIGHT }},
							{ n = G.UIT.T, config = { text = ' '..ante_amnt..' ', scale = 0.45, colour = lighten(G.C.IMPORTANT, 0.25) }},
							{ n = G.UIT.T, config = { text = back_texts[2], scale = 0.45, colour = G.C.UI.TEXT_LIGHT }}
						}},
						{ n = G.UIT.R, config = { align = "cm", padding = -0.1 }, nodes = {
							{ n = G.UIT.T, config = {
								text = "("..localize('k_ante')..' '..ante_curr..' -> '..localize('k_ante')..' '..Reset_Ante..')',
								scale = 0.38, colour = darken(G.C.UI.TEXT_LIGHT, 0.33)
							}},
						}},
						{ n = G.UIT.R, config = { padding = 0.15 }},
						{ n = G.UIT.R, config = { align = "cm", padding = -0.1 }, nodes = {
							{ n = G.UIT.T, config = { text = blind_texts[1], scale = 0.45, colour = G.C.UI.TEXT_LIGHT }}
						}},
						{ n = G.UIT.R, config = { align = "cm" }, nodes = {
							{ n = G.UIT.T, config = { text = '+'..(Global_Add*100)..'% ', scale = 0.45, colour = lighten(G.C.IMPORTANT, 0.25) }},
							{ n = G.UIT.T, config = { text = blind_texts[2], scale = 0.45, colour = G.C.UI.TEXT_LIGHT }}
						}},
					}},
					{ n = G.UIT.C, config = { align = "cm" }, nodes = {
						{ n = G.UIT.R, config = { align = "cm" }, nodes = {
							{ n = G.UIT.O, config = { object = oblivion_sprite }}
						}},
						{ n = G.UIT.R, config = { align = "tm", padding = 0.1 }, nodes = {
							{ n = G.UIT.O, config = { object = DynaText({
								string = { title_text }, colours = { G.C.UI.TEXT_LIGHT }, shadow = true, float = true, scale = 0.55
							})}},
						}},
					}},
					{ n = G.UIT.C, config = {
						align = "cm", padding = 0.2, r = 0.1, colour = darken(G.C.BLUE, 0.25),
						minh = G.ROOM.T.h * 0.25, minw = G.ROOM.T.w * 0.225, shadow = true,
						hover = true, button = "SEMBY_OblivionChoice", oblivion = false
					}, nodes = dont_nodes },
				}}
			}}
		}}
	}}
	return choice
end

G.FUNCS.SEMBY_OblivionChoice = function(e)
    stop_use()
	if (G.GAME.SEMBY_oblivion_state or 0) ~= 1 then
		G.GAME.SEMBY_oblivion_state = 1
		if e.config.oblivion then
			G.GAME.SEMBY_oblivion_reset = e.config.oblivion
			ease_ante(-e.config.oblivion)
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				func = function()
					G.GAME.SEMBY_oblivion_reset = nil
					return true
				end
			}))
    	    SEMBY_Global_BlindMod_Add(Global_Key, Global_Add)
		else
    		play_sound('button')
		end
	end
	if G.SEMBY_oblival then
        G.SEMBY_oblival.alignment.offset.y = G.ROOM.T.y + 15
        delay(0.3)
		G.E_MANAGER:add_event(Event({
			trigger = 'immediate',
			func = function()
				if G.SEMBY_oblival then
                	G.SEMBY_oblival:remove()
                	G.SEMBY_oblival = nil
				end
        		G.STATE_COMPLETE = false
				G.GAME.SEMBY_oblivion_state = nil
				return true
			end
		}))
	end
end
