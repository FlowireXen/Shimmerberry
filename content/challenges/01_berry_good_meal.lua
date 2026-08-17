SMODS.Challenge {
    key = 'SEMBY_berry_good_meal',
    rules = {
        custom = {
            { id = 'SEMBY_berry_good_meal' },
            { id = 'SEMBY_space' },
            { id = 'SEMBY_berry_eaten_1' },
            { id = 'SEMBY_berry_eaten_2' },
        },
        modifiers = {
            { id = 'discards', value = 4 },
            { id = 'winning_ante', value = 6 },
        }
    },
    restrictions = {
        banned_other = {
            { id = 'bl_final_leaf',  type = 'blind' },
        },
    },
    jokers = {
        { id = 'j_SEMBY_berry_shimmer', SEMBY_possessive = true },
        { id = 'j_SEMBY_berry_blue', SEMBY_possessive = true },
        { id = 'j_SEMBY_berry_golden', SEMBY_possessive = true },
        { id = 'j_SEMBY_berry_straw', SEMBY_possessive = true },
    },
    deck = {
        type = 'Challenge Deck',
        cards = {
            { s = 'S', r = 'T' }, { s = 'H', r = 'T' }, { s = 'C', r = 'T' }, { s = 'D', r = 'T' },
            { s = 'S', r = '9' }, { s = 'H', r = '9' }, { s = 'C', r = '9' }, { s = 'D', r = '9' },
            { s = 'S', r = '8' }, { s = 'H', r = '8' }, { s = 'C', r = '8' }, { s = 'D', r = '8' },
            { s = 'S', r = '7' }, { s = 'H', r = '7' }, { s = 'C', r = '7' }, { s = 'D', r = '7' },
            { s = 'S', r = '6' }, { s = 'H', r = '6' }, { s = 'C', r = '6' }, { s = 'D', r = '6' },
            { s = 'S', r = '5' }, { s = 'H', r = '5' }, { s = 'C', r = '5' }, { s = 'D', r = '5' },
            { s = 'S', r = '4' }, { s = 'H', r = '4' }, { s = 'C', r = '4' }, { s = 'D', r = '4' },
            { s = 'S', r = '3' }, { s = 'H', r = '3' }, { s = 'C', r = '3' }, { s = 'D', r = '3' },
            { s = 'S', r = '2' }, { s = 'H', r = '2' }, { s = 'C', r = '2' }, { s = 'D', r = '2' },
        }
    },
	apply = function(self)
        if G.GAME.selected_back then
            G.GAME.selected_back.atlas = "SEMBY_decks"
            G.GAME.selected_back.pos = { x = 0, y = 1 }
        end
	end,
    calculate = function(self, context)
        -- ##FIXME##/Known Bug: You can lose all berries on the final Blind and still Win
		if context.end_of_round and context.main_eval and context.game_over == false then
	        G.E_MANAGER:add_event(Event({
	        	func = function()
		            for i = 1, #G.jokers.cards do
			            if G.jokers.cards[i].config.center.pools and G.jokers.cards[i].config.center.pools.Berry then
                            return true
                        end
		            end
                    G.GAME.SEMBY_defeated = {
                        atlas = G.P_CENTERS.j_SEMBY_berry_shimmer.atlas,
                        position = G.P_CENTERS.j_SEMBY_berry_shimmer.pos,
                        loc_key = 'SEMBY_lose_01_berry'
                    }
		            SEMBY_Challenge_LOSE()
	        		return true
	        	end
	        }))
        end
    end,
	button_colour = G.C.BLUE
}
