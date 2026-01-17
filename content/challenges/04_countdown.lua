SMODS.Challenge {
    key = 'SEMBY_countdown',
    rules = {
        custom = {
            { id = 'SEMBY_countdown' },
            { id = 'SEMBY_space' },
            { id = 'SEMBY_countdown_mode' },
            { id = 'no_extra_hand_money' },
        },
        modifiers = {
            { id = 'hands', value = 30 },
            { id = 'discards', value = 30 },
        }
    },
    restrictions = {
        banned_tags = {
            { id = 'tag_garbage' },
        },
    },
	apply = function(self)
		G.GAME.SEMBY_countdown_mode = true
	end,
	button_colour = G.C.RED
}
