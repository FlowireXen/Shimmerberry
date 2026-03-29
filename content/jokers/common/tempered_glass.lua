SMODS.Joker {
	key = "tempered_glass",
	name = "SEMBY_tempered_glass",
	atlas = "SEMBY_jokers",
	pos = { x = 5, y = 4 },
    draw = function(self, card, layer)
        if card.config.center.discovered or card.bypass_discovery_center then
            card.children.center:draw_shader('voucher', nil, card.ARGS.send_to_shader)
        end
    end,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = false,
	rarity = 1,
	cost = 4,
	config = {
		extra = {
			odds = 0.5
		}
	},
	enhancement_gate = 'm_glass',
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_glass
		return { vars = {
			card.ability.extra.odds * 100
		} }
	end,
    calculate = function(self, card, context)
        if context.remove_playing_cards and not context.blueprint then
			-- Create Copies
            for _, removed_card in ipairs(context.removed) do
                if SMODS.has_enhancement(removed_card, 'm_glass')
				and pseudorandom("SEMBY_tempered_glass") <= card.ability.extra.odds
				then removed_card:SEMBY_revive_copy(card) end
            end
			return nil, true -- For retrigger purposes
        end
    end
}
