SMODS.Joker {
	key = "coupon",
	SEMBY_art = "unkokat",
	atlas = "SEMBY_jokers_1",
	pos = { x = 7, y = 6 },
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
    attributes = {
		'passive', 'economy',
		'shop'
	},
	loc_vars = function(self, info_queue, card)
		return { vars = {
			card.ability.extra.shop_mod * 100
		} }
	end,
    add_to_deck = function(self, card, from_debuff)
		G.E_MANAGER:add_event(Event({
			func = function()
				SEMBY_Global_ShopMod_Add('coupon'..card.sort_id, -card.ability.extra.shop_mod)
				return true
			end
		}))
    end,
    remove_from_deck = function(self, card, from_debuff)
		G.E_MANAGER:add_event(Event({
			func = function()
				SEMBY_Global_ShopMod_Remove('coupon'..card.sort_id)
				return true
			end
		}))
    end
}
