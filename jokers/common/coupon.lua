SMODS.Joker {
	key = "coupon",
	name = "SEMBY_coupon",
	atlas = "SEMBY_jokers",
	pos = { x = 6, y = 4 },
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = false,
	rarity = 1,
	cost = 6,
	config = {
		extra = {
			shop_mod = 0.2
		}
	},
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
		return { vars = {
			math.floor(card.ability.extra.shop_mod * 100 + 0.5)
		} }
	end,
    add_to_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({func = function()
			G.GAME.SEMBY_shop_mod = (G.GAME.SEMBY_shop_mod or 1.0) - card.ability.extra.shop_mod
			for k, v in pairs(G.I.CARD) do
				if v.set_cost then v:set_cost() end
			end
		return true end }))
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({func = function()
			G.GAME.SEMBY_shop_mod = G.GAME.SEMBY_shop_mod + card.ability.extra.shop_mod
			for k, v in pairs(G.I.CARD) do
				if v.set_cost then v:set_cost() end
			end
		return true end }))
    end
}
