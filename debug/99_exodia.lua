SMODS.Challenge {
    key = 'SEMBY_exodia',
    rules = {
        custom = {
            { id = 'SEMBY_gold_stake' },
        },
        modifiers = {
            { id = 'hands', value = 1 },
            { id = 'discards', value = 1 },
            { id = 'joker_slots', value = 8 },
            { id = 'winning_ante', value = 32 },
        }
    },
    jokers = {
        { id = 'j_SEMBY_debugjoker', pinned = true, eternal = true },
        { id = 'j_SEMBY_t3mprr' },
        { id = 'j_dusk' },
    },
    consumeables = {
        { id = 'c_SEMBY_order_shrine' },
    },
    vouchers = {
        { id = 'v_blank' },
        { id = 'v_overstock_norm' },
        { id = 'v_overstock_plus' },
        { id = 'v_overstock_plus' },
    },
	apply = function(self)
		SMODS.setup_stake(SMODS.Stakes["stake_gold"].order)
		G.GAME.stake = SMODS.Stakes["stake_gold"].order
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			func = function()
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					func = function()
						SMODS.debuff_card(G.jokers.cards[1], 'prevent_debuff', 'SEMBY_debugjoker')
						save_run()
						return true
					end
				}))
				return true
			end
		}))
	end,
	button_colour = HEX('FF00FF')
}
