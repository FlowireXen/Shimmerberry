SMODS.Joker {
	key = "balloon",
	SEMBY_art = "unkokat",
	atlas = "SEMBY_jokers_1",
	pos = { x = 4, y = 8 },
    eternal_compat = false,
    perishable_compat = true,
    blueprint_compat = true,
	rarity = 1,
	cost = 4,
	config = {
		extra = {
			xmult = 2,
			selected = 4
		}
	},
    attributes = {
		'xmult'
	},
	loc_vars = function(self, info_queue, card)
		return { vars = {
			card.ability.extra.xmult,
			card.ability.extra.selected
		} }
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return { xmult = card.ability.extra.xmult }
		end
		if context.evaluate_poker_hand and G.GAME.blind and G.GAME.blind.in_blind and not context.blueprint_card then
			if not card.ability.extra.flew_away and #context.full_hand >= card.ability.extra.selected then
				card.ability.extra.flew_away = true
				stop_use()
				G.E_MANAGER:add_event(Event({
				    trigger = 'after',
                    delay = 0.2,
					func = function()
						play_sound('SEMBY_explode', 2.0)
                        SMODS.destroy_cards(card, nil, true)
						G.hand:unhighlight_all()
						return true
					end
				}))
        	    return { message = localize('SEMBY_lost_ex') }
			end
		end
	end
}
