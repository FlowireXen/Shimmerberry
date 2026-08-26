SMODS.Joker {
	key = "chrono_break",
	SEMBY_art = "flowire",
	atlas = "SEMBY_jokers_1",
	pos = { x = 4, y = 3 },
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
	rarity = 3,
	cost = 7,
	config = {
		extra = {
			numerator = 1,
			denominator = 4
		}
	},
    attributes = {
		'generation', 'destroy_card',
		'music', 'magic'
	},
	pools = {
		["Music"] = true,
		["Numetal_Special"] = true,
    },
	loc_vars = function(self, info_queue, card)
		if Shimmerberry.compat.buffoonery and Buffoonery.config.show_info then
			info_queue[#info_queue+1] = {set = 'Other', key = 'nu_metal_info'}
		end
		local numerator, denominator = SMODS.get_probability_vars(card,
			card.ability.extra.numerator, card.ability.extra.denominator, 'SEMBY_chrono_break')
		return { vars = {
			numerator,
			denominator
		} }
	end,
    calculate = function(self, card, context)
		--## Revive Logic
        if context.remove_playing_cards and not context.blueprint then
	    	G.E_MANAGER:add_event(Event({
	    		func = function()
			        SEMBY_revive_list(context.removed, card, "chrono_break")
	    			return true
	    		end
	    	}))
			return nil, true
        end
		--## Shatter Logic
		if context.individual and context.cardarea == G.play then
			if not context.other_card.SEMBY_chrono_break
			and SMODS.pseudorandom_probability(card, 'SEMBY_chrono_break',
				card.ability.extra.numerator, card.ability.extra.denominator)
			then
				context.other_card.SEMBY_chrono_break = true
				local juice_card = (context.blueprint_card or card)
				local playing_card = context.other_card
				G.E_MANAGER:add_event(Event({
		    		trigger = 'after',
		    		delay = 0.1,
					blocking = false,
					func = function()
						juice_card:juice_up(0.1, 0.2)
						playing_card:SEMBY_set_dissolve({{1, 1, 1, 1}, {0.8, 0.8, 0.8, 0.8}}, 0.0, 0.1, 1.0)
						return true
					end
				}))
			end
		end
        if context.destroy_card and context.cardarea == G.play then
            if context.destroy_card.SEMBY_chrono_break then
				context.destroy_card.SEMBY_chrono_break = nil
				context.destroy_card.shattered = true
                return { remove = true }
            end
        end
    end
}
