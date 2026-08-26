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
        if G.GAME.selected_back then
            G.GAME.selected_back.atlas = "SEMBY_decks"
            G.GAME.selected_back.pos = { x = 1, y = 1 }
        end
		G.GAME.starting_params.ante_scaling = math.max(1.0, G.GAME.round_resets.ante)
	end,
    calculate = function(self, context)
        if context.ante_change then
		    G.E_MANAGER:add_event(Event({
		    	func = function()
                    --print(G.GAME.round_resets.ante)
		    		G.GAME.starting_params.ante_scaling = math.max(1.0, G.GAME.round_resets.ante)
		    		return true
		    	end
		    }))
        end
    end,
	button_colour = G.C.PURPLE
}
