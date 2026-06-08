SMODS.Joker {
	key = "risky_joker",
	SEMBY_art = "unkokat",
	atlas = "SEMBY_jokers_1",
	pos = { x = 4, y = 6 },
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
	rarity = 1,
	cost = 6,
	config = {
		extra = {
			chips = 6,
			mult = 1,
			gold = 1,
			payout = 0
		}
	},
    attributes = {
		'mult', 'chips', 'economy'
	},
	loc_vars = function(self, info_queue, card)
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
