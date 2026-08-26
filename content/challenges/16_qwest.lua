SMODS.Challenge {
	key = 'SEMBY_qwest',
	rules = {
		custom = {
			{ id = 'SEMBY_qwest_sprout' },
			{ id = 'SEMBY_space' },
			{ id = 'SEMBY_qwest_tougher' },
			{ id = 'SEMBY_qwest_limited' },
		},
		modifiers = {
			{ id = 'joker_slots', value = 6 },
			{ id = 'winning_ante', value = localize('k_none') },
		}
	},
	jokers = {
		{ id = 'j_SEMBY_quest', eternal = true },
	},
	apply = function(self)
		G.GAME.SEMBY_questing = true
	end,
	button_colour = G.C.RED
}
