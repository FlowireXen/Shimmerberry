SMODS.Challenge {
    key = 'SEMBY_the_menagerie',
    rules = {
        custom = {
            { id = 'SEMBY_the_menagerie' },
            { id = 'SEMBY_space' },
            { id = 'SEMBY_menagerie_mode' },
        },
    },
	apply = function(self)
		G.GAME.SEMBY_menagerie_mode = true
	end,
	button_colour = G.C.PURPLE
}
