SMODS.Challenge {
    key = 'SEMBY_grandmaster_menagerie',
    rules = {
        custom = {
            { id = 'SEMBY_grandmaster_menagerie' },
            { id = 'SEMBY_space' },
            { id = 'SEMBY_gold_stake' },
            { id = 'SEMBY_menagerie_mode' },
        },
    },
	apply = function(self)
		SMODS.setup_stake(SMODS.Stakes["stake_gold"].order)
		G.GAME.stake = SMODS.Stakes["stake_gold"].order
		G.GAME.SEMBY_menagerie_mode = true
	end,
	button_colour = G.C.PURPLE
}
