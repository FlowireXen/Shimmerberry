SMODS.Joker {
	key = "fifty_seven_leaf_clover",
	name = "SEMBY_fifty_seven_leaf_clover",
	atlas = "SEMBY_jokers",
	pos = { x = 3, y = 1 },
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = false,
    blueprint_compat = true,
	rarity = 2,
	cost = 8,
	config = {
		extra = {
			repetitions = 3
		}
	},
	enhancement_gate = 'm_wild',
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_wild
		return { vars = {
			card.ability.extra.repetitions
		} }
	end,
	calculate = function(self, card, context)
		if context.repetition then --and context.cardarea == G.play then
			if SMODS.has_enhancement(context.other_card, 'm_wild') then
				return { repetitions = card.ability.extra.repetitions }
			end
		end
	end
}
