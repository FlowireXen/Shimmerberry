SMODS.Challenge {
    key = 'SEMBY_parking_roulette',
    rules = {
        custom = {
            { id = 'SEMBY_parking_roulette' },
            { id = 'SEMBY_space' },
            { id = 'SEMBY_quick_scaling' },
        },
        modifiers = {
            { id = 'joker_slots', value = 6 },
        }
    },
    restrictions = {
        banned_other = {
            { id = 'bl_final_heart', type = 'blind' },
            { id = 'bl_final_leaf',  type = 'blind' },
            { id = 'bl_final_acorn', type = 'blind' },
        },
    },
    jokers = {
        { id = 'j_joker', SEMBY_glitched = 0.25 },
        { id = 'j_SEMBY_parking_disc', eternal = true },
        { id = 'j_SEMBY_parking_disc', eternal = true },
        { id = 'j_SEMBY_parking_disc', eternal = true },
        { id = 'j_SEMBY_parking_disc', eternal = true },
        { id = 'j_SEMBY_parking_disc', eternal = true },
    },
	apply = function(self)
		G.GAME.starting_params.ante_scaling = (G.GAME.starting_params.ante_scaling or 1) * 1.5
		-- Update...? Downgrade the "Joker".
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			func = function()
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					func = function()
						G.jokers.cards[1].ability.mult = G.jokers.cards[1].ability.mult * 0.25
						save_run()
						return true
					end
				}))
				return true
			end
		}))
	end,
	button_colour = G.C.RED
}
