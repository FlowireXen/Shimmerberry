SMODS.Joker {
	key = "peculiar_joker",
	SEMBY_art = "placeholder",
	atlas = "SEMBY_jokers_1",
	pos = { x = 2, y = 9 },
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
	rarity = 1,
	cost = 5,
	config = {
		extra = {
			chips = 100,
			suits = 3
		}
	},
    attributes = {
		'chips', 'suit'
	},
	loc_vars = function(self, info_queue, card)
		return { vars = {
			card.ability.extra.chips,
			card.ability.extra.suits
		} }
	end,
	calculate = function(self, card, context)
        if context.joker_main and (G.GAME.SEMBY_suit_count or 0) >= card.ability.extra.suits then
            return { chips = card.ability.extra.chips }
        end
	end
}
