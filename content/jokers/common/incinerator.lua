SMODS.Joker {
	key = "incinerator",
	SEMBY_art = "unkokat",
	atlas = "SEMBY_jokers_1",
	pos = { x = 7, y = 3 },
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
    attributes = {
		'discard', 'passive'
	},
	loc_vars = function(self, info_queue, card)
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
