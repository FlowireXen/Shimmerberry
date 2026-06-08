SMODS.Joker {
	key = "fifty_seven_leaf_clover",
	SEMBY_art = "unkokat",
	atlas = "SEMBY_jokers_1",
	pos = { x = 8, y = 0 },
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
    attributes = {
		'enhancements', 'retrigger',
		'nature',
	},
	enhancement_gate = 'm_wild',
	loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_wild
		return { vars = {
			card.ability.extra.repetitions
		} }
	end,
    add_to_deck = function(self, card, from_debuff)
		if not from_debuff then G.GAME.SEMBY_eden_bonus = (G.GAME.SEMBY_eden_bonus or 0) +1 end
    end,
    remove_from_deck = function(self, card, from_debuff)
		if not from_debuff then G.GAME.SEMBY_eden_bonus = (G.GAME.SEMBY_eden_bonus or 0) -1 end
    end,
	calculate = function(self, card, context)
		if context.repetition then --and context.cardarea == G.play then
			if SMODS.has_enhancement(context.other_card, 'm_wild') then
				return { repetitions = card.ability.extra.repetitions }
			end
		end
	end
}
