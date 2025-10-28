SMODS.Joker {
	key = "t3mprr",
	name = "SEMBY_t3mprr",
	atlas = "SEMBY_jokers",
	pos = { x = 0, y = 6 },
	soul_pos = { x = 0, y = 7 },
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
	rarity = 2,
	cost = 5,
	config = {
		extra = {
			clock_up = 2.0,
			push_down = 0.06
		}
	},
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
		return { vars = {
			card.ability.extra.clock_up * 100,
			card.ability.extra.push_down * 100
		} }
	end,
	set_ability = function(self, card, initial, delay_sprites)
		--if card.config.center.discovered then
			card:set_dissolve({G.C.RED, G.C.PURPLE}, 0.0, 0.2, 0)
		--end
	end,
	load = function(self, card, card_table, other_card)
		card:set_dissolve({G.C.RED, G.C.PURPLE}, 0.0, 0.2, 0)
	end,
	add_to_deck = function(self, card, from_debuff)
		if not from_debuff then card:set_dissolve({G.C.RED, G.C.PURPLE}, 0.0, 0.2, 0) end
	end,
	calculate = function(self, card, context)
		if context.setting_blind and not (self.getting_sliced or context.blueprint) then
			return {
				message = localize('SEMBY_T3MPRR_'..math.random(1, 4)),
				colour = HEX('000000'),
				func = function()
					SEMBY_Increase_Blindsize(card.ability.extra.clock_up, card, true)
					return true
				end
			}
        end
		if context.individual and (context.cardarea == G.play or context.cardarea == "unscored") then
			return {
				func = function()
					SEMBY_Reduce_Blindsize(card.ability.extra.push_down, context.other_card, true)
					return true
				end
			}
		end
	end
}
