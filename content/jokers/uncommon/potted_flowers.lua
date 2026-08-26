SMODS.Joker {
	key = "potted_flowers",
	SEMBY_art = "flowire",
	atlas = "SEMBY_jokers_1",
	pos = { x = 2, y = 7 },
    eternal_compat = true,
    perishable_compat = true,
	blueprint_compat = true,
	rarity = 2,
	cost = 6,
	config = {
		extra = {
			xchips = 4,
			suits = 4
		}
	},
    attributes = {
		'xchips', 'suit',
		'nature'
	},
	loc_vars = function(self, info_queue, card)
		return { vars = {
			card.ability.extra.xchips,
			card.ability.extra.suits,
		} }
    end,
	calculate = function(self, card, context)
        if context.joker_main and (G.GAME.SEMBY_suit_count or 0) >= card.ability.extra.suits then
			return { xchips = card.ability.extra.xchips }
		end
    end
}
