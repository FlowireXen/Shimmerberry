SMODS.Challenge {
    key = 'SEMBY_the_last_unicorn',
    rules = {
        custom = {
            { id = 'SEMBY_the_last_unicorn' },
            { id = 'SEMBY_space' },
            { id = 'SEMBY_the_last_unicorn_1' },
            { id = 'SEMBY_the_last_unicorn_2' },
        },
        modifiers = {
			{ id = 'ante_scaling', value = 0.5 },
            { id = 'winning_ante', value = localize('k_none') },
        }
    },
    restrictions = {
        banned_cards = {
            { id = 'j_SEMBY_unicorn' },
        },
    },
    jokers = {
        { id = 'j_SEMBY_unicorn', SEMBY_debuffed = true, SEMBY_possessive = true },
    },
    consumeables = {
        { id = 'c_death' }, --c_judgement
    },
    calculate = function(self, context)
		if context.end_of_round and context.main_eval and context.game_over == false and not G.GAME.won then
		    local Unigone = true
		    for i = 1, #G.jokers.cards do
		    	if G.jokers.cards[i].config.center_key == 'j_SEMBY_unicorn' then
		    		Unigone = false
                    -- "Horse" makes a sound;
				    G.E_MANAGER:add_event(Event({
				    	trigger = 'after',
                        delay = 0.4,
				    	func = function()
				    		G.jokers.cards[i]:juice_up(0.12)
				    		play_sound('generic1', 1.00, 0.8)
				    		attention_text({
				    			text = localize('SEMBY_horse_says_'..math.random(1, 3)),
				    			backdrop_colour = HEX('CC22AA'), scale = 1.0, hold = 0.8,
                                major = G.jokers.cards[i], align = 'bm'
				    		})
				    		return true
				    	end
				    }))
		    		--break
		    	end
		    end
		    if Unigone then
		    	SEMBY_Challenge_WIN()
		    end
        end
    end,
	button_colour = G.C.RED
}
