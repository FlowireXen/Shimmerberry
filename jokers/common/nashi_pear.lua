SMODS.Joker {
	key = "nashi_pear",
	name = "SEMBY_nashi_pear",
	atlas = "SEMBY_jokers",
	pos = { x = 0, y = 9 },
    unlocked = true,
    discovered = false,
    eternal_compat = false,
    perishable_compat = true,
    blueprint_compat = true,
	rarity = 1,
	cost = 3,
	config = {
		extra = {
			score_base = 1000,
			state = 5,
			pos_valid = { fresh = 0, bitten = 1, eaten = 2 },
			pos_overwrite = { x = 0, y = 9 },
		}
	},
	pools = {
        Food = true,
    },
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
		return { vars = {
			number_format(math.floor(card.ability.extra.score_base * card.ability.extra.state + 0.5)),
			number_format(math.floor(card.ability.extra.score_base + 0.5))
		} }
	end,
	load = function(self, card, card_table, other_card)
		G.E_MANAGER:add_event(Event({
			func = function()
				card.children.center:set_sprite_pos(card.ability.extra.pos_overwrite)
				return true
			end
		}))
	end,
    add_to_deck = function(self, card, from_debuff)
		if not from_debuff then
			card.children.center:set_sprite_pos(card.ability.extra.pos_overwrite)
		end
    end,
	calculate = function(self, card, context)
		-- FIXME: Overly Complicated
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
					if card.ability.extra.state >= 5 then card.ability.extra.pos_overwrite.x = card.ability.extra.pos_valid.fresh
					elseif card.ability.extra.state >= 3 then card.ability.extra.pos_overwrite.x = card.ability.extra.pos_valid.bitten
					else card.ability.extra.pos_overwrite.x = card.ability.extra.pos_valid.eaten end
					card.children.center:set_sprite_pos(card.ability.extra.pos_overwrite)
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
									play_sound('SEMBY_crunch_'..math.random(1, 2)) --'cancel'
									G.E_MANAGER:add_event(Event({
										trigger = 'after',
										delay = 0.3,
										blockable = false,
										func = function()
											card:start_dissolve()
											return true
										end
									}))
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
