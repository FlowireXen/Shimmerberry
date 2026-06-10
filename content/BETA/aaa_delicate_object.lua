SMODS.Joker {
	key = "delicate_object",
	loc_txt = {
		name = "{C:inactive}delicate_object",
		text = {{
			"Retrigger {C:attention}all{}",
			"playing cards",
		}, {
			"{C:red,E:2}Self destructs{}",
			"when selecting",
			"{C:attention}#1# or more{}",
			"playing cards",


			-- instead of selecting 5 -> when playing or discarding more than 3 cards


		}}
	},
	SEMBY_art = "placeholder",
	atlas = "SEMBY_jokers_1",
	pos = { x = 6, y = 8 },
    eternal_compat = false,
    perishable_compat = true,
    blueprint_compat = true,
	rarity = 2,
	cost = 4,
	config = {
		extra = {
			repetitions = 1,
			selected = 5
		}
	},
    attributes = {
		'retrigger', 'hand_type'
	},
	loc_vars = function(self, info_queue, card)
		return { vars = {
			card.ability.extra.selected
		} }
	end,
	calculate = function(self, card, context)
		if context.repetition then
			return { repetitions = card.ability.extra.repetitions }
		end
		if context.evaluate_poker_hand and G.GAME.blind and G.GAME.blind.in_blind and not context.blueprint_card then
			if not card.ability.extra.delicate_nt and #context.full_hand >= card.ability.extra.selected then
				card.ability.extra.delicate_nt = true
				G.E_MANAGER:add_event(Event({
					func = function()
						card.shattered = true
                        SMODS.destroy_cards(card, nil, true)
						return true
					end
				}))
        	    return { message = localize('SEMBY_failed_ex') }
			end
		end
	end
}
