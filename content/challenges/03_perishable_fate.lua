SMODS.Challenge {
    key = 'SEMBY_perishable_fate',
    rules = {
        custom = {
            { id = 'SEMBY_perishable_fate' },
            { id = 'SEMBY_space' },
            { id = 'SEMBY_degrading' },
        }
    },
    restrictions = {
        banned_cards = {
            { id = 'j_half' },
            { id = 'j_SEMBY_ripped_joker' },
        },
    },
    jokers = {
        { id = 'j_SEMBY_toolkit', SEMBY_degrading = true },
    },
	apply = function(self)
        G.GAME.SEMBY_degrading = true
	end,
	button_colour = G.C.RED
}
