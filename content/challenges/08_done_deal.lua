SMODS.Challenge {
    key = 'SEMBY_done_deal',
    rules = {
        custom = {
            { id = 'SEMBY_done_deal' },
            { id = 'SEMBY_space' },
            { id = 'SEMBY_no_hands' },
            { id = 'SEMBY_upgrade_pokerhands' },
        },
        modifiers = {
            { id = 'hands', value = 1 },
            { id = 'discards', value = 0 },
            { id = 'dollars', value = 0 },
        }
    },
    restrictions = {
        banned_cards = {
            { id = 'v_grabber' },
            { id = 'v_nacho_tong' },
            --{ id = 'j_SEMBY_alpha' },
            { id = 'v_hieroglyph' },
            { id = 'v_petroglyph' },
        },
    },
    vouchers = {
        { id = 'v_blank' },
        { id = 'v_antimatter' },
    },
    consumeables = {
        { id = 'c_deja_vu' },
    },
    deck = {
        type = 'Challenge Deck',
        cards = { { s = 'H', r = 'K', e = 'm_stone', d = 'negative' } }
    },
	apply = function(self)
		-- Level up all Hands
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			func = function()
				for planet, _ in pairs(G.GAME.hands) do
					level_up_hand(card, planet, true, 3)
				end
				save_run()
				return true
			end
		}))
	end,
    calculate = function(self, context)
        if context.press_play then
            local amount = G.GAME.current_round.hands_left - 1
            if amount > 0 then ease_hands_played(-amount) end
        end
	end,
	button_colour = G.C.RED
}
