SMODS.Joker {
	key = "twenty_to_die_for",
	SEMBY_art = "unkokat",
	atlas = "SEMBY_jokers_1",
	pos = { x = 0, y = 5 },
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = false,
	rarity = 3,
	cost = 6,
	config = {
		extra = {
			luck = 4.0
		}
	},
    attributes = {
		'mod_chance',
		'magic'
	},
	pools = {
        ["Goobleck"] = true,
    },
	loc_vars = function(self, info_queue, card)
		return { vars = {
			card.ability.extra.luck
		} }
	end,
    calculate = function(self, card, context)
        if context.mod_probability and not context.blueprint then
            return {
                numerator = context.numerator * card.ability.extra.luck
            }
        end
    end
}
