-- Optimized with a Lovely-Patch:
-- ../lovely/mod_challenges.toml
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
		banned_cards = {
			{ id = 'j_delayed_grat' }, -- Thank Fir for this Ban! :3
		},
		banned_other = {
			{ id = 'bl_needle', type = 'blind' },
			{ id = 'bl_water', type = 'blind' },
		},
	},
	apply = function(self)
		G.GAME.SEMBY_Countdown = true
	end,
	calculate = function(self, context)
		if (context.end_of_round and context.main_eval and context.game_over == false) or context.ending_shop then
			-- Set/Save some technical values:
			G.GAME.round_resets.hands = G.GAME.current_round.hands_left
			G.GAME.round_resets.discards = G.GAME.current_round.discards_left
			-- Re-Define "Unused Discards"
			G.GAME.unused_discards = G.GAME.current_round.discards_left
		end
		if context.first_hand_drawn then
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				func = function()
					if G.GAME.current_round.hands_left == 0 then
						SEMBY_Blind_Wiggle()
						G.STATE = G.STATES.HAND_PLAYED
						G.STATE_COMPLETE = true
						end_round() --> Ends Blind & Run
					end
					return true
				end
			}))
			return
		end
	end,
	button_colour = G.C.RED
}
