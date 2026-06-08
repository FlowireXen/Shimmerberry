SMODS.Joker {
	key = "money_laundering",
	SEMBY_art = "unkokat", --"flowire",
	atlas = "SEMBY_jokers_1",
	pos = { x = 7, y = 1 },
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
	rarity = 2,
	cost = 9,
	config = {
		extra = {
			hands = 2.0,
			discards = 2.0,
			shop_mod = 1.0
		}
	},
    attributes = {
		'hands', 'discard', 'economy',
		'shop'
	},
	loc_vars = function(self, info_queue, card)
        return { vars = {
			card.ability.extra.hands,
			card.ability.extra.discards,
			card.ability.extra.shop_mod * 100
		} }
    end,
    add_to_deck = function(self, card, from_debuff)
		G.E_MANAGER:add_event(Event({
			func = function()
				SEMBY_Global_ShopMod_Add('money_laundering'..card.sort_id, card.ability.extra.shop_mod)
				return true
			end
		}))
    end,
    remove_from_deck = function(self, card, from_debuff)
		G.E_MANAGER:add_event(Event({
			func = function()
				SEMBY_Global_ShopMod_Remove('money_laundering'..card.sort_id)
				return true
			end
		}))
    end,
	calculate = function(self, card, context)
		if context.setting_blind and not (context.blueprint_card or self).getting_sliced then
			ease_hands_played(card.ability.extra.hands, false)
			ease_discard(card.ability.extra.discards, false, true)
			-- Just a silly lil' joke :>
			if SMODS.pseudorandom_probability(card, 'SEMBY_money_laundering', 2, 100) then
				return {
					message = localize('SEMBY_money_dirty'),
					colour = G.C.RED
				}
			else
				return {
					message = localize('SEMBY_money_clean'),
					colour = G.C.GREEN
				}
			end
		end
	end
}
