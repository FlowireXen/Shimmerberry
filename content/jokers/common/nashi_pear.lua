local function get_texture(state)
	if state and state < 5 then
		if state >= 3 then
			return { x = 6, y = 0 }
		else
			return { x = 7, y = 0 }
		end
	end
	return { x = 5, y = 0 }
end
SMODS.Joker {
	key = "nashi_pear",
	SEMBY_art = "unkokat",
	atlas = "SEMBY_jokers_2",
	pos = get_texture(),
    eternal_compat = false,
    perishable_compat = true,
    blueprint_compat = true,
	rarity = 1,
	cost = 3,
	config = {
		extra = {
			score_base = 2000,
			state = 5
		}
	},
    attributes = {
		'score', 'scaling', 'food'
	},
	pools = {
        ["Food"] = true,
    },
	loc_vars = function(self, info_queue, card)
		return { vars = {
			number_format(math.floor(card.ability.extra.score_base * card.ability.extra.state + 0.5)),
			number_format(math.floor(card.ability.extra.score_base + 0.5))
		} }
	end,
	load = function(self, card, card_table, other_card)
		G.E_MANAGER:add_event(Event({
			func = function()
				card.children.center:set_sprite_pos(get_texture(card.ability.extra.state))
				return true
			end
		}))
	end,
    add_to_deck = function(self, card, from_debuff)
		if not from_debuff then
			card.children.center:set_sprite_pos(get_texture(card.ability.extra.state))
		end
    end,
	calculate = function(self, card, context)
		-- FIXME: Overly Complicated
		--[[--> Wait for a couple of patches before using this:
		if context.setting_blind and not (context.blueprint_card or self).getting_sliced then
			local ret_val = math.floor(card.ability.extra.score_base * card.ability.extra.state + 0.5)
            return {
				remove_default_message = true,
				score = ret_val,
			}
		end
		--]]
		if context.setting_blind and not (context.blueprint_card or self).getting_sliced then
			-- Basic Logic
			local ret_val = math.floor(card.ability.extra.score_base * card.ability.extra.state + 0.5)
			if ret_val <= 0 then ret_val = card.ability.extra.score_base end
			local dest_msg = nil
			if not context.blueprint then
				card.ability.extra.state = card.ability.extra.state - 1
				if card.ability.extra.state == 0 then
					dest_msg = localize('k_eaten_ex')
				end
			end
			-- Texture Stuff
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				func = function()
					card.children.center:set_sprite_pos(get_texture(card.ability.extra.state))
					return true
				end
			}))
			-- Setup Check: Did the Joker beat the Blind?
			SEMBY_Blind_Check(card)
			-- Return + Destroy
			return {
				message = localize{ type = 'variable', key = 'SEMBY_plus', vars = { number_format(ret_val) } },
				colour = G.C.YELLOW,
				sound = ('SEMBY_crunch_'..math.random(1, 2)),
				G.E_MANAGER:add_event(Event({
					func = function()
						G.GAME.chips = G.GAME.chips + ret_val
						return true
					end
				})),
				extra = {
					message = localize{ type = 'variable', key = 'SEMBY_minus', vars = { number_format(math.floor(card.ability.extra.score_base + 0.5)) } },
					colour = G.C.RED,
					func = function()
						if dest_msg then
							G.E_MANAGER:add_event(Event({
								func = function()
    		        				card:juice_up()
    		        				play_sound('SEMBY_crunch_'..math.random(1, 2), 1.0, 0.8)
									card:start_dissolve()
									return true
								end
							}))
						end
					end,
					extra = {
						message = dest_msg,
						colour = G.C.RED
					}
				}
			}
        end
	end
}
