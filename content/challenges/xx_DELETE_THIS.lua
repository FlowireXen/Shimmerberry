SMODS.Challenge {
    key = 'SEMBY_DELETE_THIS',
    rules = {
        custom = {
            { id = 'SEMBY_space' }, { id = 'SEMBY_DELETE_THIS_1' }, { id = 'SEMBY_DELETE_THIS_2' },
            { id = 'SEMBY_space' }, { id = 'SEMBY_DELETE_THIS_1' }, { id = 'SEMBY_DELETE_THIS_2' },
            { id = 'SEMBY_space' }, { id = 'SEMBY_DELETE_THIS_1' }, { id = 'SEMBY_DELETE_THIS_2' },
            { id = 'SEMBY_space' }, { id = 'SEMBY_DELETE_THIS_1' }, { id = 'SEMBY_DELETE_THIS_2' },
            { id = 'SEMBY_space' }, { id = 'SEMBY_DELETE_THIS_1' }, { id = 'SEMBY_DELETE_THIS_2' },
            { id = 'SEMBY_space' }, { id = 'SEMBY_DELETE_THIS_1' }, { id = 'SEMBY_DELETE_THIS_2' },
			{ id = 'SEMBY_space' }, -- EOL
        },
        modifiers = {
            { id = 'hands', value = 99 },
            { id = 'discards', value = 99 },
            { id = 'hand_size', value = 99 },
            { id = 'joker_slots', value = 99 },
            { id = 'consumable_slots', value = 99 },
            { id = 'dollars', value = 99 },
            { id = 'winning_ante', value = 99 },
        }
    },
    restrictions = {
        banned_cards = {
            { id = 'j_SEMBY_TMTRAINER' }, { id = 'j_SEMBY_TMTRAINER' }, { id = 'j_SEMBY_TMTRAINER' }, { id = 'j_SEMBY_TMTRAINER' },
			{ id = 'j_SEMBY_TMTRAINER' }, { id = 'j_SEMBY_TMTRAINER' }, { id = 'j_SEMBY_TMTRAINER' }, { id = 'j_SEMBY_TMTRAINER' },
			{ id = 'j_SEMBY_TMTRAINER' }, { id = 'j_SEMBY_TMTRAINER' }, { id = 'j_SEMBY_TMTRAINER' }, { id = 'j_SEMBY_TMTRAINER' },
			{ id = 'j_SEMBY_TMTRAINER' }, { id = 'j_SEMBY_TMTRAINER' }, { id = 'j_SEMBY_TMTRAINER' }, --{ id = 'j_SEMBY_TMTRAINER' },
        },
        banned_tags = {
            { id = 'tag_garbage' },
        },
        banned_other = {
            { id = 'bl_final_leaf',  type = 'blind' },
        },
    },
    jokers = {
        { id = 'j_SEMBY_TMTRAINER', eternal = true, SEMBY_glitched = 2.0 },
    },
    consumeables = {
        { id = 'c_SEMBY_order_shrine' },
    },
    deck = {
        type = 'Challenge Deck',
        cards = {
			-- !!! HIGHLY UNSTABLE !!! -- !!! HIGHLY UNSTABLE !!! -- !!! HIGHLY UNSTABLE !!! --
            { s = 'S', r = '0' }, { s = 'H', r = '0' }, { s = 'C', r = '0' }, { s = 'D', r = '0' },
            { s = 'S', r = '0' }, { s = 'H', r = '0' }, { s = 'C', r = '0' }, { s = 'D', r = '0' },
            { s = 'S', r = '0' }, { s = 'H', r = '0' }, { s = 'C', r = '0' }, { s = 'D', r = '0' },
            { s = 'S', r = '0' }, { s = 'H', r = '0' }, { s = 'C', r = '0' }, { s = 'D', r = '0' },
            { s = 'S', r = '0' }, { s = 'H', r = '0' }, { s = 'C', r = '0' }, { s = 'D', r = '0' },
            { s = 'S', r = '0' }, { s = 'H', r = '0' }, { s = 'C', r = '0' }, { s = 'D', r = '0' },
            { s = 'S', r = '0' }, { s = 'H', r = '0' }, { s = 'C', r = '0' }, { s = 'D', r = '0' },
            { s = 'S', r = '0' }, { s = 'H', r = '0' }, { s = 'C', r = '0' }, { s = 'D', r = '0' },
            { s = 'S', r = '0' }, { s = 'H', r = '0' }, { s = 'C', r = '0' }, { s = 'D', r = '0' },
            { s = 'S', r = '0' }, { s = 'H', r = '0' }, { s = 'C', r = '0' }, { s = 'D', r = '0' },
            { s = 'S', r = '0' }, { s = 'H', r = '0' }, { s = 'C', r = '0' }, { s = 'D', r = '0' },
            { s = 'S', r = '0' }, { s = 'H', r = '0' }, { s = 'C', r = '0' }, { s = 'D', r = '0' },
            { s = 'S', r = '0' }, { s = 'H', r = '0' }, { s = 'C', r = '0' }, { s = 'D', r = '0' },
            { s = 'S', r = '0' }, { s = 'H', r = '0' }, { s = 'C', r = '0' }, { s = 'D', r = '0' },
            { s = 'S', r = '0' }, { s = 'H', r = '0' }, { s = 'C', r = '0' }, { s = 'D', r = '0' },
            { s = 'S', r = '0' }, { s = 'H', r = '0' }, { s = 'C', r = '0' }, { s = 'D', r = '0' },
            { s = 'S', r = '0' }, { s = 'H', r = '0' }, { s = 'C', r = '0' }, { s = 'D', r = '0' },
            { s = 'S', r = '0' }, { s = 'H', r = '0' }, { s = 'C', r = '0' }, { s = 'D', r = '0' },
            { s = 'S', r = '0' }, { s = 'H', r = '0' }, { s = 'C', r = '0' }, { s = 'D', r = '0' },
            { s = 'S', r = '0' }, { s = 'H', r = '0' }, { s = 'C', r = '0' }, { s = 'D', r = '0' },
            { s = 'S', r = '0' }, { s = 'H', r = '0' }, { s = 'C', r = '0' }, { s = 'D', r = '0' },
            { s = 'S', r = '0' }, { s = 'H', r = '0' }, { s = 'C', r = '0' }, { s = 'D', r = '0' },
            { s = 'S', r = '0' }, { s = 'H', r = '0' }, { s = 'C', r = '0' }, { s = 'D', r = '0' },
            { s = 'S', r = '0' }, { s = 'H', r = '0' }, { s = 'C', r = '0' }, { s = 'D', r = '0' },
            { s = 'S', r = '0' }, { s = 'H', r = '0' }, { s = 'C', r = '0' }, { s = 'D', r = '0' },
			-- !!! HIGHLY UNSTABLE !!! -- !!! HIGHLY UNSTABLE !!! -- !!! HIGHLY UNSTABLE !!! --
		}
    },
	apply = function(self)
		-- Activate per-turn stuff:
		G.GAME.SEMBY_countdown_mode = true
		G.GAME.SEMBY_chaos_mode = true
        -- Others:
		G.GAME.SEMBY_hide_win_ante = true
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			func = function()
				-- Hidden Rules:
				G.GAME.modifiers.money_per_hand = 0
				-- Overrule Rules:
				G.GAME.dollars = 11
				G.GAME.win_ante = 11
				-- Modify all normal Areas:
				G.jokers:add_text_overwrite(0, 'SEMBY_NaN')
				G.consumeables:add_text_overwrite(0, 'SEMBY_NaN')
				G.hand:add_text_overwrite(0, 'SEMBY_NaN')
				G.deck:add_text_overwrite(0, 'SEMBY_NaN')
				-- Change TMTRAINER:
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					func = function()
						G.jokers.cards[1].ability.extra.rng_min = 0.00
						G.jokers.cards[1].ability.extra.rng_max = 2.00
						G.jokers.cards[1].ability.extra.corrupt = true
						G.jokers.cards[1].children.center:set_sprite_pos({ x = 1, y = 11 })
						save_run()
						return true
					end
				}))
				return true
			end
		}))
	end,
	button_colour = HEX("FF00FF00")
}
