SMODS.Joker {
	key = "tempered_glass",
	SEMBY_art = "flowire",
	atlas = "SEMBY_jokers_1",
	pos = { x = 9, y = 3 },
    draw = function(self, card, layer)
        if card.config.center.discovered or card.bypass_discovery_center then
            card.children.center:draw_shader('voucher', nil, card.ARGS.send_to_shader)
        end
    end,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
	rarity = 1,
	cost = 4,
	config = {
		extra = {
			buff = 1
		}
	},
    attributes = {
		'chance', 'modify_card', 'enhancements'
	},
	enhancement_gate = 'm_glass',
	loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_glass
		local glass = G.P_CENTERS.m_glass.config.extra or 4
		return { vars = {
			card.ability.extra.buff,
			glass, glass + card.ability.extra.buff
		} }
	end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, 'm_glass') then
			context.other_card.ability.extra = (context.other_card.ability.extra or 4) + card.ability.extra.buff
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.GREEN
            }
        end
    end
}
