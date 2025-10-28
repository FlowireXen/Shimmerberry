SMODS.Joker {
	key = "anchor",
	name = "SEMBY_anchor",
    atlas = 'SEMBY_jokers',
    pos = { x = 8, y = 3 },
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = false,
    blueprint_compat = true,
	rarity = 1,
	cost = 4,
	config = {
		extra = {
			xchips = 2.0
		}
	},
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
		return { vars = {
			card.ability.extra.xchips
		} }
	end,
	load = function(self, card, card_table, other_card) card.states.click.can = false 	end,
    add_to_deck = function(self, card, from_debuff) 	card.states.click.can = false 	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return { xchips = card.ability.extra.xchips }
		end
	end
}
