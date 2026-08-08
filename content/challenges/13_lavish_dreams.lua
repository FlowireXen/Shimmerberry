SMODS.Challenge {
    key = 'SEMBY_lavish_dreams',
    rules = {
        custom = {
            { id = 'SEMBY_lavish_dreams_1' },
            { id = 'SEMBY_lavish_dreams_2' },
            { id = 'SEMBY_space' },
            { id = 'no_reward' },
            { id = 'no_extra_hand_money' },
            { id = 'no_interest' },
        },
        modifiers = {
            { id = 'hands', value = 2 },
            { id = 'discards', value = 2 },
            { id = 'dollars', value = 2 },
			{ id = 'ante_scaling', value = 4 },
        }
    },
    restrictions = {
        banned_cards = {
            { id = 'v_seed_money' },
            { id = 'v_money_tree' },
            { id = 'j_to_the_moon' },
            { id = 'c_hermit' },
            { id = 'c_temperance' },
            { id = 'c_immolate' },
        },
        banned_tags = {
            { id = 'tag_investment' },
            { id = 'tag_handy' },
            { id = 'tag_garbage' },
            { id = 'tag_coupon' },
            { id = 'tag_skip' },
            { id = 'tag_economy' },
            { id = 'tag_SEMBY_bnt_vouch_down' },
        },
    },
    jokers = {
        { id = 'j_SEMBY_lavish_joker', pinned = true, eternal = true, SEMBY_lavish = true },
        { id = 'j_SEMBY_lavish_joker' },
        { id = 'j_SEMBY_pay_two_win', SEMBY_glitched = 0.5 },
    },
    deck = {
        type = 'Challenge Deck',
        cards = {
			{ s = 'S', r = 'A' }, { s = 'H', r = 'A' }, { s = 'C', r = 'A' }, { s = 'D', r = 'A' },
			{ s = 'S', r = 'K' }, { s = 'H', r = 'K' }, { s = 'C', r = 'K' }, { s = 'D', r = 'K' },
			{ s = 'S', r = 'K' }, { s = 'H', r = 'K' }, { s = 'C', r = 'K' }, { s = 'D', r = 'K' },
			{ s = 'S', r = 'K' }, { s = 'H', r = 'K' }, { s = 'C', r = 'K' }, { s = 'D', r = 'K' },
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
		G.GAME.SEMBY_lavish_mode = true
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			func = function()
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					func = function()
						for i = 1, #G.jokers.cards do
							if G.jokers.cards[i].config.center_key == 'j_SEMBY_pay_two_win' then
								G.jokers.cards[i].ability.extra.spend = math.floor(G.jokers.cards[i].ability.extra.spend * 0.5)
								G.jokers.cards[i].ability.extra.mult = G.jokers.cards[i].ability.extra.mult * 0.5
							end
						end
						save_run()
						return true
					end
				}))
				return true
			end
		}))
	end,
	button_colour = G.C.RED
}
