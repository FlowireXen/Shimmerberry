SMODS.Joker {
	key = "misery",
	SEMBY_art = "flowire",
	atlas = "SEMBY_jokers_1",
	pos = { x = 9, y = 4 },
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
	rarity = 1,
	cost = 5,
    config = { 
		extra = {
			xmult = 0.5,
			xchips = 4.0
		}
	},
    attributes = {
		'hands', 'xmult', 'xchips'
	},
	loc_vars = function(self, info_queue, card)
        return { vars = {
			card.ability.extra.xmult,
			card.ability.extra.xchips
		} }
    end,
	calculate = function(self, card, context)
        if context.first_hand_drawn and not context.blueprint then
            local eval = function() return G.GAME.current_round.hands_played == 0 and not G.RESET_JIGGLES end
            juice_card_until(card, eval, true)
        end
		if context.joker_main then
			if G.GAME.current_round.hands_played == 0 then
				return {
					xmult = card.ability.extra.xmult,
					xchips = card.ability.extra.xchips
				}
			else
				return {
					xmult = card.ability.extra.xmult
				}
			end
        end
    end
}
