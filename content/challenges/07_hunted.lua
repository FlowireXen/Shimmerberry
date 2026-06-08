SMODS.Challenge {
    key = 'SEMBY_hunted',
    rules = {
        custom = {
            { id = 'SEMBY_hunted' },
            { id = 'SEMBY_space' },
            { id = 'SEMBY_hunted_1' },
            { id = 'SEMBY_hunted_2' },
            { id = 'SEMBY_hunted_3' },
            { id = 'SEMBY_space' },
            { id = 'SEMBY_hunted_deal_1' },
            { id = 'SEMBY_hunted_deal_2' },
            { id = 'SEMBY_space' },
            { id = 'SEMBY_scaling_15' },
        },
        modifiers = {
            { id = 'hands', value = 3 },
            { id = 'discards', value = 6 },
            { id = 'hand_size', value = 5 },
            { id = 'winning_ante', value = 6 },
        }
    },
    restrictions = {
        banned_cards = {
            { id = 'j_SEMBY_bound' },
            --{ id = 'j_SEMBY_hemoturgy' },
            { id = 'j_SEMBY_incinerator' },
            { id = 'j_SEMBY_stern_teacher' },
            { id = 'v_SEMBY_urn_old' },
            { id = 'v_SEMBY_urn_cursed' },
            { id = 'p_standard_normal_1', ids = {
                'p_standard_normal_1', 'p_standard_normal_2',
                'p_standard_normal_3', 'p_standard_normal_4',
                'p_standard_jumbo_1', 'p_standard_jumbo_2',
                'p_standard_mega_1', 'p_standard_mega_2' }
            },
        },
    },
    jokers = {
        { id = 'j_SEMBY_agent_fourty_seven', eternal = true, SEMBY_possessive = true },
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
		--G.GAME.SEMBY_survive_until = 45
		G.GAME.starting_params.ante_scaling = (G.GAME.starting_params.ante_scaling or 1) * 1.5
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			func = function()
				SMODS.change_discard_limit(-2)
				save_run()
				return true
			end
		}))
	end,
    calculate = function(self, context)
        -- Game Over Condition
		if context.end_of_round and context.main_eval and context.game_over == false and #G.playing_cards <= 45 then
            G.GAME.win_ante = 99
            G.GAME.SEMBY_defeated = {
                atlas = G.P_CENTERS.j_SEMBY_agent_fourty_seven.atlas,
                position = G.P_CENTERS.j_SEMBY_agent_fourty_seven.pos,
                loc_key = 'SEMBY_lose_07_hunted',
                color = G.C.RED
            }
            SEMBY_Challenge_LOSE()
        end
        -- Gain "+X Hand Size"
        if context.pre_discard and context.full_hand and #context.full_hand == 3 then
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
			    func = function()
                    G.hand:change_size(2)
                    G.GAME.round_resets.temp_handsize = (G.GAME.round_resets.temp_handsize or 0) + 2
                    -- Make "Deck" Yap
			        G.E_MANAGER:add_event(Event({
			        	trigger = 'after',
			        	blocking = false,
			        	func = function()
                            G.deck:juice_up(0.2)
			        		play_sound('generic1', 1.0, 0.8)
			                attention_text({
			                	text = '+2', backdrop_colour = G.C.GREEN,
			                	scale = 1.0, hold = 1.0, major = G.deck,
			                	align = 'tm', offset = { x = 0, y = -0.5 }
			                })
			        		return true
			        	end
			        }))
					return true
				end
			}))
        end
    end,
	button_colour = G.C.RED
}
