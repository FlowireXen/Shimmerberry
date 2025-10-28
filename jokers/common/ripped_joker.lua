SMODS.Joker {
	key = "ripped_joker",
	name = "SEMBY_ripped_joker",
	atlas = "SEMBY_jokers",
	pos = { x = 3, y = 2 },
    pixel_size = { h = 95 * 0.7 },
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
	rarity = 1,
	cost = 5,
	config = {
		extra = {
			chips = 200,
			size = 3
		}
	},
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
		return { vars = {
			card.ability.extra.chips,
			card.ability.extra.size
		} }
	end,
    calculate = function(self, card, context)
        if context.joker_main and #context.full_hand <= card.ability.extra.size then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}
