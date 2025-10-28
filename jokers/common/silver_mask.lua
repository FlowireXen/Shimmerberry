SMODS.Joker {
	key = "silver_mask",
	name = "SEMBY_silver_mask",
	atlas = "SEMBY_jokers",
	pos = { x = 3, y = 5 },
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = false,
	rarity = 1,
	cost = 6,
	config = {
		extra = {
			gold = 20,
			goldmod = 2
		}
	},
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
		return { vars = {
			G.hand and math.max(0, card.ability.extra.gold - (G.hand.config.card_limit * card.ability.extra.goldmod)) or card.ability.extra.gold,
			card.ability.extra.goldmod
		} }
	end,
    calc_dollar_bonus = function(self, card)
		local silver = card.ability.extra.gold - (G.hand.config.card_limit * card.ability.extra.goldmod)
		if silver > 0 then return silver end
    end,
    in_pool = function(self, args)
		if G.hand then
			return (G.hand.config.card_limit < 10)
		end
    end
}
