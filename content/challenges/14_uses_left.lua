SMODS.Challenge {
    key = 'SEMBY_uses_left',
    rules = {
        custom = {
            { id = 'SEMBY_uses_left_1' },
            { id = 'SEMBY_uses_left_2' },
            { id = 'SEMBY_uses_left_3' },
            { id = 'SEMBY_space' },
            { id = 'SEMBY_used_up_1' },
            { id = 'SEMBY_used_up_2' },
            { id = 'SEMBY_space' },
            { id = 'no_interest' },
            { id = 'SEMBY_remaining_hand_pay' },
            { id = 'SEMBY_remaining_discard_pay' },
        },
        modifiers = {
            { id = 'hands', value = 3 },
            { id = 'discards', value = 2 },
            { id = 'dollars', value = 50 },
        }
    },
    restrictions = {
        banned_cards = {
            { id = 'j_credit_card' },
            { id = 'v_seed_money' },
            { id = 'v_money_tree' },
            { id = 'j_to_the_moon' },
            { id = 'j_SEMBY_toolkit' },
        },
        banned_other = {
            { id = 'bl_ox', type = 'blind' },
        },
    },
    jokers = {
        { id = 'j_SEMBY_pay_two_win', eternal = true },
    },
    consumeables = {
        { id = 'c_temperance' },
    },
	apply = function(self)
		G.GAME.SEMBY_money_fuel_mode = true
        G.GAME.modifiers.money_per_hand = -2
        G.GAME.modifiers.money_per_discard = -1
	end,
	button_colour = G.C.RED
}
