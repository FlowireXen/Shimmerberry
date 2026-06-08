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
    blueprint_compat = false,
	rarity = 1,
	cost = 4,
	config = {
		extra = {
			numerator = 1,
			denominator = 2
		}
	},
    attributes = {
		'chance', 'generation', 'enhancements'
	},
	enhancement_gate = 'm_glass',
	loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_glass
		local numerator, denominator = SMODS.get_probability_vars(card,
			card.ability.extra.numerator, card.ability.extra.denominator, 'SEMBY_tempered_glass', nil, true)
		local percentage = math.floor((numerator / denominator) * 100 + 0.5)
		return { vars = { math.min(100, percentage) } }
	end,
    calculate = function(self, card, context)
        if context.remove_playing_cards and not context.blueprint then
	    	G.E_MANAGER:add_event(Event({
	    		func = function()
			        SEMBY_revive_list(context.removed, card, "tempered_glass")
	    			return true
	    		end
	    	}))
			return nil, true
        end
    end
}
