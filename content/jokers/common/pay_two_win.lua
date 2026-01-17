SMODS.Joker {
	key = "pay_two_win",
	name = "SEMBY_pay_two_win",
	atlas = "SEMBY_jokers",
	pos = { x = 6, y = 2 },
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
	rarity = 1,
	cost = 4,
	config = {
		extra = {
			-- Consider Challenge:
			-- > Lavish Dreams
			spend = 2,
			mult = 30
		}
	},
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
		return { vars = {
			card.ability.extra.spend,
			card.ability.extra.mult
		} }
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			if (G.GAME.dollars - (card.ability.extra.spend + (G.GAME.SEMBY_p2w or 0))) >= G.GAME.bankrupt_at then
				G.GAME.SEMBY_p2w = (G.GAME.SEMBY_p2w or 0) + card.ability.extra.spend
				return {
					dollars = -card.ability.extra.spend,
					extra = {
						mult = card.ability.extra.mult
					}
				}
			else
				return {
					message = localize{type = 'variable', key = 'SEMBY_money', vars = { '-' }},
					colour = G.C.GREY,
					sound = 'cancel'
				}
			end
        end
		if context.after and G.GAME.SEMBY_p2w then
			G.GAME.SEMBY_p2w = nil
		end
	end
}
