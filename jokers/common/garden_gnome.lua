SMODS.Joker {
	key = "garden_gnome",
	name = "SEMBY_garden_gnome",
	atlas = "SEMBY_jokers",
	pos = { x = 3, y = 4 },
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
	rarity = 1,
	cost = 5,
	config = {
		extra = {
			mult = 30,
			handsize = 2
		}
	},
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
		return { vars = {
			card.ability.extra.mult,
			card.ability.extra.handsize
		} }
	end,
	add_to_deck = function(self, card, from_debuff)
		G.hand:change_size(-card.ability.extra.handsize)
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.hand:change_size(card.ability.extra.handsize)
	end,
	calculate = function(self, card, context)
		if context.joker_main then
        	return {
        		mult = card.ability.extra.mult
        	}
        end
	end
}
