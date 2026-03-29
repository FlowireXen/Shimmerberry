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
            { id = 'hands', value = 24 },
            { id = 'discards', value = 24 },
        }
    },
    restrictions = {
        banned_other = {
            { id = 'bl_needle', type = 'blind' },
            { id = 'bl_water', type = 'blind' },
        },
    },
    calculate = function(self, context)
        -- This has to constantly work against a Save-Guard Mechanic in the Vanilla Game:
		if (context.end_of_round and context.main_eval and context.game_over == false) or context.ending_shop then
            -- Save Values (End of Blind & Shop)
            G.GAME.round_resets.hands = G.GAME.current_round.hands_left
            G.GAME.round_resets.discards = G.GAME.current_round.discards_left
            -- Re-Define "Unused Discards"
		    G.GAME.unused_discards = G.GAME.current_round.discards_left
            -- The Game normally doesn't allow a "Current Hand"-Value of "0"
            if G.GAME.current_round.hands_left <= 0 then
                G.GAME.SEMBY_doomed_countdown = true
            else G.GAME.SEMBY_doomed_countdown = false end
            return
        end
        if G.GAME.SEMBY_doomed_countdown then
            -- FORCE the Game into a Losing-State
            -- Gained Hands in Payout and Blind-Select don't count
            if context.starting_shop then
                G.GAME.round_resets.hands = 0
                G.GAME.current_round.hands_left = 0
                return
            end
            if context.first_hand_drawn then
                G.GAME.round_resets.hands = 0
                G.GAME.current_round.hands_left = 0
                --SEMBY_Challenge_LOSE()
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					func = function()
						SEMBY_Blind_Wiggle()
					    G.STATE = G.STATES.HAND_PLAYED
					    G.STATE_COMPLETE = true
					    end_round() --> Ends Blind & Run
						return true
					end
				}))
                return
            end
        end
    end,
	button_colour = G.C.RED
}
-- Previous Code (Not better!):
--[[
	G.GAME.round_resets.hands = G.GAME.starting_params.hands - (G.GAME.hands_played or 0)
	if G.GAME.unused_discards > 0 then
		G.GAME.round_resets.discards = G.GAME.round_resets.discards - (G.GAME.round_resets.discards - (G.GAME.unused_discards or 0))
		G.GAME.unused_discards = 0
	end
--]]
