SMODS.Challenge {
    key = 'SEMBY_printty_good',
    rules = {
        custom = {
            { id = 'SEMBY_printty_good' },
            { id = 'SEMBY_space' },
            { id = 'no_reward' },
            { id = 'no_extra_hand_money' },
            { id = 'no_interest' },
        },
        modifiers = {
            { id = 'discards', value = 4 },
            { id = 'dollars', value = 0 },
            { id = 'winning_ante', value = 6 },
        }
    },
    restrictions = {
        banned_cards = {
            { id = 'v_seed_money' },
            { id = 'v_money_tree' },
            { id = 'j_to_the_moon' },
        },
        banned_other = {
            { id = 'bl_final_heart', type = 'blind' },
            { id = 'bl_final_leaf',  type = 'blind' },
            { id = 'bl_final_acorn', type = 'blind' },
        },
    },
    jokers = {
        { id = 'j_SEMBY_copy_printer', eternal = true, edition = "negative" },
        { id = 'j_flash' },
        { id = 'j_SEMBY_copy_printer' },
        { id = 'j_joker' },
    },
    vouchers = {
        { id = 'v_blank' },
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
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			func = function()
				add_tag(Tag('tag_investment'))
				add_tag(Tag('tag_investment'))
				return true
			end
		}))
	end,
	button_colour = G.C.BLUE
}
