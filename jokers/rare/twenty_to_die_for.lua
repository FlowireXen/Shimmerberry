SMODS.Joker {
	key = "twenty_to_die_for",
	name = "SEMBY_twenty_to_die_for",
	atlas = "SEMBY_jokers",
	pos = { x = 2, y = 4 },
    unlocked = true,
    discovered = false,
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
	pools = {
        ["Goobleck"] = true,
    },
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
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
