SMODS.Challenge {
    key = 'SEMBY_qwest',
    rules = {
        custom = {
            { id = 'SEMBY_qwest_1' },
            { id = 'SEMBY_qwest_2' },
            { id = 'SEMBY_space' },
            { id = 'SEMBY_no_win_ante' },
            { id = 'SEMBY_no_showdown' },
        },
        modifiers = {
            { id = 'joker_slots', value = 6 },
            { id = 'winning_ante', value = 99 },
        }
    },
    jokers = {
        { id = 'j_SEMBY_quest', eternal = true, SEMBY_glitched = 2.0 },
    },
	apply = function(self)
		G.GAME.SEMBY_hide_win_ante = true
		-- Change Quest:
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			func = function()
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					func = function()
						for index, goals in pairs(G.jokers.cards[1].ability.extra.goals) do
							for key, goal in pairs(goals) do
								if key == "shot" then
									G.jokers.cards[1].ability.extra.goals[index][key] = math.floor(G.jokers.cards[1].ability.extra.goals[index][key] * 1.2 + 0.5)
								else -- Can safely be Doubled
									G.jokers.cards[1].ability.extra.goals[index][key] = G.jokers.cards[1].ability.extra.goals[index][key] * 2.0
								end
							end
						end
						-- Update Glitch-Value (purely Visual)
						if G.jokers.cards[1].ability.extra.state.type == "shot" then
							G.jokers.cards[1].ability.SEMBY_tmtrainer_value = 1.2
						end
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
