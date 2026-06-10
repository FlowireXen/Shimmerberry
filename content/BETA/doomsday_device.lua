SMODS.Joker {
	key = "doomsday_device",
	loc_txt = {
		name = "Doomsday Device",
		text = {
			"{C:attention}Doubles{} the stored",
			"{C:chips}Memory Value{} of every",
			"{C:attention}#1#th{} scoring {C:enhanced}Memory Card{}",
			"{C:inactive}(Currently {C:attention}#2#{C:inactive}/#1#){}",
		}
	},
	SEMBY_art = "placeholder",
	atlas = "SEMBY_jokers_1",
	pos = { x = 7, y = 8 },
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = false,
	rarity = 2,
	cost = 6,
	config = {
		extra = {
			every = 20,
			count = 0
		}
	},
    attributes = {
		'enhancements', 'modify_card', 'TODO_TODO_TODO_TODO_TODO_TODO_TODO_TODO_TODO'
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
