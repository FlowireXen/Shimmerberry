SMODS.Challenge {
    key = 'SEMBY_tool_for_every_joke',
    rules = {
        custom = {
            { id = 'SEMBY_tool_for_every_joke' },
            { id = 'SEMBY_space' },
            { id = 'no_interest' },
        },
        modifiers = {
            { id = 'hand_size', value = 16 },
            { id = 'joker_slots', value = 6 },
            { id = 'dollars', value = 0 },
            { id = 'winning_ante', value = 6 },
        }
    },
    restrictions = {
        banned_cards = {
            { id = 'v_seed_money' },
            { id = 'v_money_tree' },
            { id = 'j_to_the_moon' },
            { id = 'j_SEMBY_toolkit' },
        },
        banned_other = {
            { id = 'bl_final_heart', type = 'blind' },
            { id = 'bl_final_leaf',  type = 'blind' },
            { id = 'bl_final_acorn', type = 'blind' },
        },
    },
    jokers = {
        { id = 'j_SEMBY_tool_axe', SEMBY_possessive = true },
        { id = 'j_SEMBY_tool_hoe', SEMBY_possessive = true },
        { id = 'j_SEMBY_tool_pickaxe', SEMBY_possessive = true },
        { id = 'j_SEMBY_tool_shovel', SEMBY_possessive = true },
        { id = 'j_SEMBY_eternal_fortune' },
    },
    consumeables = {
        { id = 'c_tower' },
        { id = 'c_tower' },
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
				SEMBY_Challenge_Durability(1000)
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					func = function()
						save_run()
						return true
					end
				}))
				return true
			end
		}))
	end,
	button_colour = G.C.BLUE
}
