SMODS.Joker {
	key = "anodized_steel",
	name = "SEMBY_anodized_steel",
	atlas = "SEMBY_jokers",
	pos = { x = 0, y = 4 },
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = false,
    blueprint_compat = true,
	rarity = 2,
	cost = 8,
	config = {
		extra = {
			percent = 0.08
		}
	},
	enhancement_gate = 'm_steel',
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_steel
		return { vars = {
			100 * card.ability.extra.percent
		} }
	end,
	calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, 'm_steel') then
			return {
				func = function()
					SEMBY_Reduce_Blindsize(card.ability.extra.percent, context.other_card, true)
					return true
				end
			}
        end
	end
}
