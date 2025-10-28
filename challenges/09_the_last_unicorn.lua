SMODS.Challenge {
    key = 'SEMBY_the_last_unicorn',
    rules = {
        custom = {
            { id = 'SEMBY_the_last_unicorn' },
            { id = 'SEMBY_space' },
            { id = 'SEMBY_the_last_unicorn_1' },
            { id = 'SEMBY_the_last_unicorn_2' },
            { id = 'SEMBY_space' },
            { id = 'SEMBY_no_win_ante' },
            { id = 'SEMBY_no_showdown' },
            { id = 'SEMBY_slow_scaling' },
        },
        modifiers = {
            { id = 'winning_ante', value = 99 },
        }
    },
    jokers = {
        { id = 'j_SEMBY_unicorn', debuffed = true, SEMBY_possessive = true },
    },
    consumeables = {
        { id = 'c_judgement' },
    },
	apply = function(self)
		G.GAME.SEMBY_hide_win_ante = true
		G.GAME.SEMBY_unicorn_mode = true
		G.GAME.starting_params.ante_scaling = (G.GAME.starting_params.ante_scaling or 1) * 0.5
		-- Perma Disable Unicorn
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			func = function()
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					func = function()
						SMODS.debuff_card(G.jokers.cards[1], true, 'SEMBY_the_last_unicorn')
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
