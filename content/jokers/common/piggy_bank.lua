SMODS.Joker {
	key = "piggy_bank",
	name = "SEMBY_piggy_bank",
	atlas = "SEMBY_jokers",
	pos = { x = 7, y = 1 },
    unlocked = true,
    discovered = false,
    eternal_compat = false,
    perishable_compat = false,
    blueprint_compat = true,
	rarity = 1,
	cost = 5,
	config = {
		extra = {
			xmult_mod = 0.2,
			value_mod = 4,
			value = {
				spend = 2,
				gain = 1,
				bonus = 2
			}
		}
	},
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
		return { vars = {
			card.ability.extra.xmult_mod,
			card.ability.extra.value_mod,
			1.0 + (math.floor(card.sell_cost / card.ability.extra.value_mod) * card.ability.extra.xmult_mod),
			card.ability.extra.value.spend,
			card.ability.extra.value.gain,
			card.ability.extra.value.bonus
		} }
	end,
    add_to_deck = function(self, card, from_debuff)
		if not from_debuff then
			card.ability.extra_value = (card.ability.extra_value or 0) + card.ability.extra.value.bonus
			card:set_cost()
		end
    end,
	calculate = function(self, card, context)
        if (context.setting_blind or context.skip_blind) and not context.blueprint then
			if G.GAME.dollars >= card.ability.extra.value.spend then
				card.ability.extra_value = (card.ability.extra_value or 0) + card.ability.extra.value.gain
				card:set_cost()
				ease_dollars(-card.ability.extra.value.spend)
				return {
					message = localize{ type = 'variable', key = 'SEMBY_money', vars = { card.ability.extra.value.gain } },
					colour = G.C.MONEY
				}
			end
        end
		if context.joker_main then
        	return { xmult = 1.0 + (math.floor(card.sell_cost / card.ability.extra.value_mod) * card.ability.extra.xmult_mod) }
        end
	end
}
