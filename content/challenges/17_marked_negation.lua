SMODS.Challenge {
	key = 'SEMBY_marked_negation',
	rules = {
		custom = {
			{ id = 'SEMBY_marked_negation' },
		},
		--modifiers = {
        --    { id = 'discards', value = 4 },
		--	{ id = 'ante_scaling', value = 2 },
		--}
	},
	restrictions = {
		banned_cards = {
			{ id = 'p_standard_normal_1', ids = {
				'p_standard_normal_1', 'p_standard_normal_2',
				'p_standard_normal_3', 'p_standard_normal_4',
				'p_standard_jumbo_1', 'p_standard_jumbo_2',
				'p_standard_mega_1', 'p_standard_mega_2'
            } },
			{ id = 'v_magic_trick' },
			{ id = 'v_illusion' },
		},
		banned_tags = {
            { id = 'tag_standard' },
		},
		banned_other = {
			{ id = 'bl_SEMBY_ghost', type = 'blind' },
			{ id = 'bl_wall', type = 'blind' },
			{ id = 'bl_final_vessel', type = 'blind' },
		},
	},
	jokers = {
		{ id = 'j_SEMBY_jevil', eternal = true, SEMBY_lavish = true },
	},
	deck = {
		type = 'Challenge Deck',
		edition = 'SEMBY_resonance'
	},
	button_colour = G.C.RED
}
