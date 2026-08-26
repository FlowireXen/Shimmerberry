SMODS.Challenge {
    key = 'SEMBY_uses_left',
    rules = {
        custom = {
            { id = 'SEMBY_uses_left_1' },
            { id = 'SEMBY_uses_left_2' },
            { id = 'SEMBY_uses_left_3' },
            { id = 'SEMBY_space' },
            { id = 'SEMBY_used_up' },
            { id = 'SEMBY_space' },
            { id = 'SEMBY_pay_to_play' },
            { id = 'no_extra_hand_money' },
            { id = 'no_interest' },
        },
        modifiers = {
            { id = 'dollars', value = 100 },
        }
    },
    restrictions = {
        banned_cards = {
            { id = 'j_credit_card' },
            { id = 'v_seed_money' },
            { id = 'v_money_tree' },
            { id = 'j_to_the_moon' },
            { id = 'j_SEMBY_toolkit' },
            { id = 'j_SEMBY_lavish_joker' },
            { id = 'c_wraith' },
        },
        banned_other = {
            { id = 'bl_ox', type = 'blind' },
        },
    },
    jokers = {
        { id = 'j_SEMBY_coupon', SEMBY_perishable = true },
    },
    consumeables = {
        { id = 'c_temperance' },
    },
    calculate = function(self, context)
        -- "The Tooth"
        if context.press_play then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.2,
                func = function()
                    for i = 1, #G.play.cards do
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                G.play.cards[i]:juice_up()
                                return true
                            end,
                        }))
                        ease_dollars(-1)
                        delay(0.23)
                    end
                    return true
                end
            }))
            delay(0.4)
        end
        -- Check for a Loss
        if (context.money_altered and (G.GAME.dollars + context.amount) <= 0)
        or (context.after and G.GAME.dollars <= 0) --Extra Check for "The Tooth"
        then
            G.GAME.SEMBY_defeated = {
                atlas = G.P_CENTERS.j_SEMBY_pay_two_win.atlas,
                position = G.P_CENTERS.j_SEMBY_pay_two_win.pos,
                loc_key = 'SEMBY_lose_14_uses',
                color = G.C.MONEY
            }
            SEMBY_Challenge_LOSE(true)
        end
    end,
	button_colour = G.C.RED
}
