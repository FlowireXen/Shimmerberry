SMODS.Challenge {
    key = 'SEMBY_printty_good',
    rules = {
        custom = {
            { id = 'SEMBY_printty_good_1' },
            { id = 'SEMBY_printty_good_2' },
            { id = 'SEMBY_space' },
            { id = 'SEMBY_printty_good_3' },
            { id = 'SEMBY_printty_good_4' },
        },
        modifiers = {
            { id = 'joker_slots', value = 10 },
			{ id = 'ante_scaling', value = 2 },
            { id = 'winning_ante', value = localize('k_none') },
        }
    },
    restrictions = {
        banned_cards = {
            { id = 'c_SEMBY_order_shrine' },
        },
    },
    jokers = {
        { id = 'j_flash' },
        { id = 'j_SEMBY_copy_printer', eternal = true, SEMBY_rental = true },
        { id = 'j_joker' },
    },
    vouchers = {
        { id = 'v_overstock_norm' },
        { id = 'v_overstock_plus' },
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
		if context.end_of_round and context.main_eval and context.game_over == false and not G.GAME.won then
            -- Local Vars.
            local DupeCheck = {}
            local DupeSuccess = false
            local DupeHighest = 0
            -- Get Highest & Check for Win
		    for i = 1, #G.jokers.cards do
                DupeCheck[G.jokers.cards[i].config.center_key] = (DupeCheck[G.jokers.cards[i].config.center_key] or 0) + 1
                if DupeCheck[G.jokers.cards[i].config.center_key] > DupeHighest then
                    DupeHighest = DupeCheck[G.jokers.cards[i].config.center_key]
                end
                if DupeCheck[G.jokers.cards[i].config.center_key] >= 9 then
                    DupeSuccess = true
                    break
                end
            end
            -- Announce Highest (Message doesn't take up time)
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
                blocking = false,
				func = function()
                    G.deck:juice_up(0.1)
					play_sound('generic1', 1.0, 0.8)
					attention_text({
						text = localize{ type = 'variable', key = 'SEMBY_out_of', vars = { DupeHighest, '9' } },
						backdrop_colour = G.C.BLUE, scale = 0.8, hold = 1.0,
						major = G.deck, align = 'tm', offset = { x = 0, y = -0.5 }
					})
					return true
				end
			}))
            -- Apply Win
            if DupeSuccess then
		    	SEMBY_Challenge_WIN()
            end
        end
    end,
	button_colour = G.C.BLUE
}
