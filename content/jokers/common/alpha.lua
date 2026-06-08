SMODS.Joker {
	key = "alpha",
	SEMBY_art = "unkokat",
	atlas = "SEMBY_jokers_1",
	pos = { x = 5, y = 5 },
    pixel_size = { w = 71, h = 71 },
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
	rarity = 1,
	cost = 6,
	config = {
		extra = {
			hands = 1
		}
	},
    attributes = {
		'hands', 'enhancements',
		'magic'
	},
	enhancement_gate = 'm_stone',
	loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
		return { vars = {
			card.ability.extra.hands
		} }
	end,
	calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, 'm_stone') then
            local is_first_stone = false
            for i = 1, #context.scoring_hand do
                if SMODS.has_enhancement(context.scoring_hand[i], 'm_stone') then
                    is_first_stone = context.scoring_hand[i] == context.other_card
                    break
                end
            end
            if is_first_stone then
				return {
					message = localize{type = 'variable', key = 'a_hands', vars = { card.ability.extra.hands }},
					colour = G.C.BLUE,
					func = function()
						-- Sadly, this delay's the actual "+1 Hand" a bit...
						ease_hands_played(card.ability.extra.hands)
						return true
					end
				}
            end
        end
	end
}
