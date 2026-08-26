SMODS.Joker {
	key = "ripped_joker",
	SEMBY_art = "flowire",
	atlas = "SEMBY_jokers_1",
	pos = { x = 5, y = 3 },
    pixel_size = { h = 95 * 0.7 },
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
	rarity = 1,
	cost = 5,
	config = {
		extra = {
			chips = 90,
			size = 3
		}
	},
    attributes = {
		'chips'
	},
	loc_vars = function(self, info_queue, card)
		return { vars = {
			card.ability.extra.chips,
			card.ability.extra.size
		} }
	end,
    calculate = function(self, card, context)
        if context.joker_main and #context.full_hand == card.ability.extra.size then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}
