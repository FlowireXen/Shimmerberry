SMODS.Joker {
	key = "incinerator",
	name = "SEMBY_incinerator",
	atlas = "SEMBY_jokers",
	pos = { x = 1, y = 5 },
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = false,
	rarity = 1,
	cost = 5,
	config = {
		extra = {
			limit = 1
		}
	},
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
		return { vars = {
			card.ability.extra.limit
		} }
	end,
    add_to_deck = function(self, card, from_debuff)
		SMODS.change_discard_limit(card.ability.extra.limit)
    end,
    remove_from_deck = function(self, card, from_debuff)
		SMODS.change_discard_limit(-card.ability.extra.limit)
    end
}
