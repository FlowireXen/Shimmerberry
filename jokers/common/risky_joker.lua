SMODS.Joker {
	key = "risky_joker",
	name = "SEMBY_risky_joker",
	atlas = "SEMBY_jokers",
	pos = { x = 6, y = 5 },
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
	rarity = 1,
	cost = 6,
	config = {
		extra = {
			chips = 4,
			mult = 1,
			gold = 1,
			payout = 0
		}
	},
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
		return { vars = {
			card.ability.extra.chips,
			card.ability.extra.mult,
			card.ability.extra.gold,
			math.floor(card.ability.extra.payout)
		} }
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			card.ability.extra.payout = (card.ability.extra.payout or 0) + card.ability.extra.gold
			return {
				chips = -card.ability.extra.chips,
				mult = -card.ability.extra.mult,
				message = localize{ type = 'variable', key = 'SEMBY_up_payout', vars = { card.ability.extra.gold } },
				colour = G.C.MONEY
			}
        end
	end,
    calc_dollar_bonus = function(self, card)
		local payout = math.floor(card.ability.extra.payout)
		card.ability.extra.payout = 0
		return payout
    end
}
