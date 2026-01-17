SMODS.Challenge {
    key = 'SEMBY_last_one_left',
    rules = {
        custom = {
            { id = 'SEMBY_last_one_left_1' },
            { id = 'SEMBY_last_one_left_2' },
            { id = 'SEMBY_last_one_left_3' },
            { id = 'SEMBY_space' },
            { id = 'no_reward' },
            { id = 'SEMBY_extra_bonus' },
            { id = 'no_interest' },
            { id = 'SEMBY_quick_scaling' },
        },
        modifiers = {
            { id = 'hands', value = 5 },
            { id = 'discards', value = 2 },
            { id = 'joker_slots', value = 6 },
            { id = 'dollars', value = 0 },
            { id = 'winning_ante', value = 12 },
        }
    },
    restrictions = {
        banned_cards = {
            { id = 'j_baron' },
            { id = 'v_seed_money' },
            { id = 'v_money_tree' },
            { id = 'j_to_the_moon' },
        },
        banned_other = {
            { id = 'bl_club', type = 'blind' },
            { id = 'bl_goad', type = 'blind' },
            { id = 'bl_window', type = 'blind' },
            { id = 'bl_head', type = 'blind' },
            { id = 'bl_plant', type = 'blind' },
            --{ id = 'bl_mark', type = 'blind' },
        },
    },
    jokers = {
        { id = 'j_baron', pinned = true, eternal = true, debuffed = true },
        { id = 'j_SEMBY_fifty_seven_leaf_clover', eternal = true, edition = "SEMBY_resonance" },
        { id = 'j_SEMBY_tool_shovel', SEMBY_possessive = true },
    },
    vouchers = {
        { id = 'v_blank' },
        { id = 'v_directors_cut' },
    },
    deck = {
        type = 'Challenge Deck',
        cards = {
			{ s = 'S', r = 'A' }, { s = 'H', r = 'A' }, { s = 'C', r = 'A' }, { s = 'D', r = 'A' },
			{ s = 'S', r = 'K', e = 'm_wild' }, { s = 'H', r = 'K', e = 'm_wild' }, { s = 'C', r = 'K', e = 'm_wild' }, { s = 'D', r = 'K', e = 'm_wild' },
			{ s = 'S', r = 'K', e = 'm_wild' }, { s = 'H', r = 'K', e = 'm_wild' }, { s = 'C', r = 'K', e = 'm_wild' }, { s = 'D', r = 'K', e = 'm_wild' },
			{ s = 'S', r = 'K', e = 'm_wild' }, { s = 'H', r = 'K', e = 'm_wild' }, { s = 'C', r = 'K', e = 'm_wild' }, { s = 'D', r = 'K', e = 'm_wild' },
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
		-- Extra Hands Money
		G.GAME.modifiers.money_per_hand = (G.GAME.modifiers.money_per_hand or 1) + 1
		-- Faster Scaling
		G.GAME.starting_params.ante_scaling = (G.GAME.starting_params.ante_scaling or 1) * 1.5
		-- Edit Jokers
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			func = function()
				-- Change Durability
				SEMBY_Challenge_Durability(100) --> Easy Start... Good Luck.
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					func = function()
						-- Instant Resonance
						local resonance_debt = Tag('tag_SEMBY_resonance_debt')
						resonance_debt.ability.resonance_percent = G.SEMBY.Resonance
						add_tag(resonance_debt)
						play_sound('highlight1', 1.2 + math.random() * 0.1, 0.5)
						-- Perma Disable Baron
						SMODS.debuff_card(G.jokers.cards[1], true, 'SEMBY_last_one_left')
						-- Save Run
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
