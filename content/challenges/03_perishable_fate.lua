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
        { id = 'j_SEMBY_toolkit', perishable = true, SEMBY_possessive = true },
    },
	apply = function(self)
        G.GAME.SEMBY_degrading = true
		--[[
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			func = function()
				SEMBY_Challenge_Durability(1000)
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					func = function()
						save_run()
						return true
					end
				}))
				return true
			end
		}))
		--]]
	end,
	button_colour = G.C.RED
}
