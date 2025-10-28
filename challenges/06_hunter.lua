SMODS.Challenge {
    key = 'SEMBY_hunter',
    rules = {
        custom = {
            { id = 'SEMBY_hunter' },
            { id = 'SEMBY_space' },
            { id = 'SEMBY_hunter_1' },
            { id = 'SEMBY_hunter_2' },
            { id = 'SEMBY_hunter_3' },
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
        { id = 'j_SEMBY_agent_fourty_seven', eternal = true },
    },
    consumeables = {
        { id = 'c_fool' },
    },
    deck = {
        type = 'Challenge Deck',
        cards = {
			{ s = 'S', r = 'A', e = 'm_stone' }, { s = 'H', r = 'A', e = 'm_stone' }, { s = 'C', r = 'A', e = 'm_stone' }, { s = 'D', r = 'A', e = 'm_stone' },
			{ s = 'S', r = 'A' }, { s = 'H', r = 'A' }, { s = 'C', r = 'A' }, { s = 'D', r = 'A' },
			{ s = 'S', r = 'K' }, { s = 'H', r = 'K' }, { s = 'C', r = 'K' }, { s = 'D', r = 'K' },
			{ s = 'S', r = 'Q' }, { s = 'H', r = 'Q' }, { s = 'C', r = 'Q' }, { s = 'D', r = 'Q' },
			{ s = 'S', r = 'J' }, { s = 'H', r = 'J' }, { s = 'C', r = 'J' }, { s = 'D', r = 'J' },
            { s = 'S', r = 'T' }, { s = 'H', r = 'T' }, { s = 'C', r = 'T' }, { s = 'D', r = 'T' },
            { s = 'S', r = '9' }, { s = 'H', r = '9' }, { s = 'C', r = '9' }, { s = 'D', r = '9' },
            { s = 'S', r = '8' }, { s = 'H', r = '8' }, { s = 'C', r = '8' }, { s = 'D', r = '8' },
            { s = 'S', r = '7' }, { s = 'H', r = '7' }, { s = 'C', r = '7' }, { s = 'D', r = '7' },
            { s = 'S', r = '6' }, { s = 'H', r = '6' }, { s = 'C', r = '6' }, { s = 'D', r = '6' },
            { s = 'S', r = '5' }, { s = 'H', r = '5' }, { s = 'C', r = '5' }, { s = 'D', r = '5' },
            { s = 'S', r = '4' }, { s = 'H', r = '4' }, { s = 'C', r = '4' }, { s = 'D', r = '4' },
            { s = 'S', r = '3' }, { s = 'H', r = '3' }, { s = 'C', r = '3' }, { s = 'D', r = '3' },
            { s = 'S', r = '2' }, { s = 'H', r = '2' }, { s = 'C', r = '2' }, { s = 'D', r = '2' },
            { s = 'S', r = '2', e = 'm_stone' }, { s = 'H', r = '2', e = 'm_stone' }, { s = 'C', r = '2', e = 'm_stone' }, { s = 'D', r = '2', e = 'm_stone' },
        }
    },
	apply = function(self)
		G.GAME.SEMBY_hide_win_ante = true
        G.GAME.SEMBY_eleminate_until = 10
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			func = function()
				SMODS.change_discard_limit(-2)
				save_run()
				return true
			end
		}))
	end,
	button_colour = G.C.RED
}
