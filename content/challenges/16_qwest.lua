SMODS.Challenge {
	key = 'SEMBY_qwest',
	rules = {
		custom = {
			{ id = 'SEMBY_qwest_sprout' },
			{ id = 'SEMBY_space' },
			{ id = 'SEMBY_qwest_tougher' },
			{ id = 'SEMBY_qwest_limited' },
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
		{ id = 'j_SEMBY_quest', eternal = true },
	},
	apply = function(self)
		G.GAME.SEMBY_questing = true
		G.GAME.SEMBY_hide_win_ante = true
	end,
	button_colour = G.C.RED
}
