SMODS.Joker {
	key = "stocked_shelves",
	name = "SEMBY_stocked_shelves",
	atlas = "SEMBY_jokers",
	pos = { x = 4, y = 5 },
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = false,
	rarity = 1,
	cost = 4,
	config = {
		extra = {
			slots = 1
		}
	},
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
		return { vars = {
			card.ability.extra.slots,
		} }
	end,
    add_to_deck = function(self, card, from_debuff)
		SMODS.change_voucher_limit(card.ability.extra.slots)
        SMODS.change_booster_limit(card.ability.extra.slots)
        G.E_MANAGER:add_event(Event({func = function()
            change_shop_size(card.ability.extra.slots)
			return true
        end}))
    end,
    remove_from_deck = function(self, card, from_debuff)
		SMODS.change_voucher_limit(-card.ability.extra.slots)
        SMODS.change_booster_limit(-card.ability.extra.slots)
        G.E_MANAGER:add_event(Event({func = function()
            change_shop_size(-card.ability.extra.slots)
			return true
        end}))
    end
}
