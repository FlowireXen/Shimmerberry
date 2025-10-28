SMODS.Challenge {
    key = 'SEMBY_done_deal',
    rules = {
        custom = {
            { id = 'SEMBY_done_deal' },
            { id = 'SEMBY_space' },
            { id = 'no_reward' },
            { id = 'SEMBY_extra_bonus' },
            { id = 'no_interest' },
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
            { id = 'v_seed_money' },
            { id = 'v_money_tree' },
            { id = 'j_to_the_moon' },
        },
        banned_other = {
            { id = 'bl_ox', type = 'blind' },
            { id = 'bl_arm', type = 'blind' },
            { id = 'bl_tooth', type = 'blind' },
            { id = 'bl_final_bell', type = 'blind' },
        },
    },
    jokers = {
        { id = 'j_SEMBY_alpha', eternal = true },
        { id = 'j_dna', eternal = true, edition = "negative" },
        { id = 'j_SEMBY_goobert' },
    },
    vouchers = {
        { id = 'v_blank' },
    },
    consumeables = {
        { id = 'c_pluto' },
    },
    deck = {
        type = 'Challenge Deck',
        cards = { { s = 'H', r = 'K', e = 'm_stone' } }
    },
	apply = function(self)
		G.GAME.modifiers.money_per_hand = (G.GAME.modifiers.money_per_hand or 1) + 1
	end,
	button_colour = G.C.RED
}
