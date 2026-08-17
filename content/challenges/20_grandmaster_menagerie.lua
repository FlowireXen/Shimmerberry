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
        -- Deck Texture
        G.GAME.selected_back.atlas = "SEMBY_decks"
        G.GAME.selected_back.pos = { x = 1, y = 1 }
        -- Challenge
		SMODS.setup_stake(SMODS.Stakes["stake_gold"].order)
		G.GAME.stake = SMODS.Stakes["stake_gold"].order
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
