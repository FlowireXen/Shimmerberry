SMODS.Joker {
	key = "money_laundering",
	name = "SEMBY_money_laundering",
	rarity = 2,
	cost = 9,
	atlas = "SEMBY_jokers",
	pos = { x = 4, y = 1 },
	blueprint_compat = true,
    config = { extra = { Hands = 2.0, Discards = 2.0, Discount = 98 } }, -- #NegativeDiscount
	loc_vars = function(self, _info, card)
        return { vars = { card.ability.extra.Hands, card.ability.extra.Discards, } }
    end,
    add_to_deck = function(self, card, from_debuff)
		-- Add Joker; Make Shop Expensive
        G.E_MANAGER:add_event(Event({func = function()
			G.GAME.discount_percent = G.GAME.discount_percent - card.ability.extra.Discount
			for k, v in pairs(G.I.CARD) do
				if v.set_cost then v:set_cost() end
			end
		return true end }))
    end,
    remove_from_deck = function(self, card, from_debuff)
		-- Remove Joker; Make Shop Cheap
        G.E_MANAGER:add_event(Event({func = function()
			G.GAME.discount_percent = G.GAME.discount_percent + card.ability.extra.Discount
			for k, v in pairs(G.I.CARD) do
				if v.set_cost then v:set_cost() end
			end
		return true end }))
    end,
	calculate = function(self, card, context)
		if context.setting_blind and not (context.blueprint_card or self).getting_sliced then
            G.E_MANAGER:add_event(Event({func = function()
                ease_hands_played(card.ability.extra.Hands)
                ease_discard(card.ability.extra.Discards)
				-- This is just a silly lil' joke :>
				if pseudorandom("money_laundering") < G.GAME.probabilities.normal / 100 then
					card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('SEMBY_eval_money_laundering_dirty'), colour = G.C.RED})
				else
					card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('SEMBY_eval_money_laundering_clean'), colour = G.C.GREEN})
				end
            return true end }))
		end
	end
}
