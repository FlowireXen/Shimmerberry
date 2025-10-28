SMODS.Challenge {
    key = 'SEMBY_speed_of_light',
    rules = {
        custom = {
            { id = 'SEMBY_speed_of_light' },
            { id = 'SEMBY_space' },
            { id = 'SEMBY_quick_scaling' },
            { id = 'SEMBY_upgrade_pokerhands' },
        },
        modifiers = {
            { id = 'discards', value = 4 },
            { id = 'hand_size', value = 10 },
            { id = 'joker_slots', value = 8 },
            { id = 'winning_ante', value = 16 },
        }
    },
    restrictions = {
        banned_other = {
            { id = 'bl_arm', type = 'blind' },
        },
    },
    jokers = {
        { id = 'j_SEMBY_shooting_star', eternal = true },
        { id = 'j_SEMBY_afterimage', eternal = true },
        { id = 'j_SEMBY_twenty_to_die_for' },
    },
    consumeables = {
        { id = 'c_planet_x' },
    },
	apply = function(self)
		G.GAME.starting_params.ante_scaling = (G.GAME.starting_params.ante_scaling or 1) * 1.5
		-- Perma Disable Unicorn
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			func = function()
				for planet, _ in pairs(G.GAME.hands) do
					level_up_hand(card, planet, true, 3)
				end
				save_run()
				return true
			end
		}))
	end,
	button_colour = G.C.RED
}
