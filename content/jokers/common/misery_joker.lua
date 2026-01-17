SMODS.Joker {
	key = "misery",
	name = "SEMBY_misery",
	atlas = "SEMBY_jokers",
	pos = { x = 5, y = 3 },
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
	rarity = 1,
	cost = 5,
    config = { 
		extra = {
			Xmult = 0.5,
			Xchip = 4.0
		}
	},
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
        return { vars = {
			card.ability.extra.Xmult,
			card.ability.extra.Xchip
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
					xmult = card.ability.extra.Xmult,
					xchips = card.ability.extra.Xchip
				}
			else
				return {
					xmult = card.ability.extra.Xmult
				}
			end
        end
    end
}
