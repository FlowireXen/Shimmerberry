SMODS.Challenge {
    key = 'SEMBY_parking_roulette',
    rules = {
        custom = {
            { id = 'SEMBY_parking_roulette' },
            { id = 'SEMBY_space' },
            { id = 'SEMBY_parking_random' },
            { id = 'no_shop_jokers' },
        },
    },
    restrictions = {
        banned_other = {
            { id = 'bl_final_leaf',  type = 'blind' },
            { id = 'bl_final_acorn', type = 'blind' },
        },
    },
    jokers = {
        { id = 'j_SEMBY_parking_disc', eternal = true },
        { id = 'j_SEMBY_parking_disc', eternal = true },
        { id = 'j_SEMBY_parking_disc', eternal = true },
        { id = 'j_SEMBY_parking_disc', eternal = true },
        { id = 'j_SEMBY_parking_disc', eternal = true },
    },
	apply = function(self)
        G.GAME.SEMBY_random_parking = true
	end,
    calculate = function(self, context)
		if context.first_hand_drawn then
            -- Get Highest
			local DiscCheck = {}
			local DiscHighest = 1
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i].config.center_key == 'j_SEMBY_parking_disc' then
					DiscCheck[G.jokers.cards[i].ability.extra.index.main] = (DiscCheck[G.jokers.cards[i].ability.extra.index.main] or 0) + 1
					if DiscCheck[G.jokers.cards[i].ability.extra.index.main] > DiscHighest then
						--TODO: Also check if State 12 is active
						DiscHighest = DiscCheck[G.jokers.cards[i].ability.extra.index.main]
					end
				end
    		end
			-- Check for "Free Parking"
			if DiscHighest >= 3 then
            	delay(0.4)
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
            	    blocking = false,
					func = function()
            	        G.deck:juice_up(0.1)
						play_sound('generic1', 1.0, 0.8)
						attention_text({
							text = localize('SEMBY_parking_disc_free'),
							backdrop_colour = G.C.BLUE, scale = 0.8, hold = 1.0,
							major = G.deck, align = 'tm', offset = { x = 0, y = -0.5 }
						})
						return true
					end
				}))
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					func = function()
						-- Pull Blind-Size down
						G.GAME.blind.chips = math.floor(G.GAME.chips)
						G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
						SEMBY_Blind_Wiggle()
						return true
					end
				}))
				SEMBY_Blind_Check()
			end
		end
	end,
	button_colour = G.C.RED
}
