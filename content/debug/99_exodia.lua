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
        { id = 'j_SEMBY_debugjoker', pinned = true, eternal = true, SEMBY_lavish = true },
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
        -- Deck Texture
        G.GAME.selected_back.atlas = "SEMBY_decks"
        G.GAME.selected_back.pos = { x = 3, y = 1 }
        -- Challenge
		SMODS.setup_stake(SMODS.Stakes["stake_gold"].order)
		G.GAME.stake = SMODS.Stakes["stake_gold"].order
	end,
	button_colour = HEX('FF00FF')
}
