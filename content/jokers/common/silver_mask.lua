local HANDSIZE = 10
local function SEMBY_Get_Money(handsize, money)
	return math.floor(money * math.max(0, handsize - (G.hand and G.hand.config.card_limit or 0)) + 0.5)
end
SMODS.Joker {
	key = "silver_mask",
	SEMBY_art = "unkokat",
	atlas = "SEMBY_jokers_1",
	pos = { x = 2, y = 3 },
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = false,
	rarity = 1,
	cost = 6,
	config = {
		extra = {
			handsize = HANDSIZE,
			money = 2
		}
	},
    attributes = {
		'hand_size', 'economy'
	},
	loc_vars = function(self, info_queue, card)
		return { vars = {
			card.ability.extra.money, card.ability.extra.handsize,
			SEMBY_Get_Money(card.ability.extra.handsize, card.ability.extra.money)
		} }
	end,
    calc_dollar_bonus = function(self, card)
		local silver = SEMBY_Get_Money(card.ability.extra.handsize, card.ability.extra.money)
		if silver > 0 then return silver end
    end,
    in_pool = function(self, args)
		if G.hand then return (G.hand.config.card_limit < HANDSIZE) end
    end
}
