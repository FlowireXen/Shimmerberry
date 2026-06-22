SMODS.Joker {
	key = "barmy_joker",
	SEMBY_art = "placeholder",
	atlas = "SEMBY_jokers_1",
	pos = { x = 3, y = 9 },
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
	rarity = 1,
	cost = 5,
	config = {
		extra = {
			mult = 12,
			suits = 3
		}
	},
    attributes = {
		'mult', 'suit'
	},
	loc_vars = function(self, info_queue, card)
		return { vars = {
			card.ability.extra.mult,
			card.ability.extra.suits
		} }
	end,
	calculate = function(self, card, context)
        if context.joker_main and (G.GAME.SEMBY_suit_count or 0) >= card.ability.extra.suits then
            return { mult = card.ability.extra.mult }
        end
	end
}
