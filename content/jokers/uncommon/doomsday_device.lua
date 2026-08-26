SMODS.Joker {
	key = "doomsday_device",
	SEMBY_art = "unkokat",
	atlas = "SEMBY_jokers_1",
	pos = { x = 5, y = 8 },
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = false,
	rarity = 2,
	cost = 6,
	config = {
		extra = {
			every = 12,
			count = 0
		}
	},
    attributes = {
		'enhancements', 'modify_card', 'chips'
	},
	enhancement_gate = 'm_SEMBY_memory',
	loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_SEMBY_memory
		return { vars = {
			card.ability.extra.every,
			card.ability.extra.count
		} }
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play and not context.blueprint
		and SMODS.has_enhancement(context.other_card, 'm_SEMBY_memory') then
			card.ability.extra.count = card.ability.extra.count + 1
			if card.ability.extra.count >= card.ability.extra.every then
				card.ability.extra.count = 0;
				local suit = context.other_card.base.suit or 'Empty'
				local ret_val = SEMBY_memory_update(suit, 0)
				SEMBY_memory_update(suit, ret_val)
				return {
					chips = ret_val,
					remove_default_message = true,
					message = localize{ type = 'variable', key = 'SEMBY_plus', vars = { ret_val } },
					colour = G.C.CHIPS,
					sound = 'xchips'
				}, true
			end
			return {
				message = localize { type = 'variable', key = 'SEMBY_out_of', vars = {
					card.ability.extra.count, card.ability.extra.every
				} }
			}, true
		end
	end
}
