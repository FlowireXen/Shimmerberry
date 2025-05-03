SMODS.Joker {
	key = "money_laundering",
	loc_txt = {
		name = "Money Laundering",
		text = {
			"When {C:attention}Blind{} is selected, gain",
			"{C:blue}+#1#{} Hands and {C:red}+#2#{} Discards",
			"Shops are {C:attention}Expensive{}"
		}
	},
	rarity = 2,
	cost = 9,
	atlas = "SEMBY_jokers",
	pos = { x = 4, y = 1 },
	blueprint_compat = true,
    config = { extra = { Hands = 2.0, Discards = 2.0, Discount = 98 } },
	loc_vars = function(self, _info, card)
        return { vars = { card.ability.extra.Hands, card.ability.extra.Discards, } }
    end,
    add_to_deck = function(self, card, from_debuff)
        if G.jokers then
			G.GAME.discount_percent = G.GAME.discount_percent - card.ability.extra.Discount  -- Joker Added; Make Shop Expensive
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        if G.jokers then
			G.GAME.discount_percent = G.GAME.discount_percent + card.ability.extra.Discount  -- Joker Remove; Make Shop Cheap
        end
    end,
	calculate = function(self, card, context)
		if context.setting_blind and not (context.blueprint_card or self).getting_sliced then
            G.E_MANAGER:add_event(Event({func = function()
                ease_hands_played(card.ability.extra.Hands)
                ease_discard(card.ability.extra.Discards)
				card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+2", colour = G.C.GOLD})
            return true end }))
		end
	end
}
