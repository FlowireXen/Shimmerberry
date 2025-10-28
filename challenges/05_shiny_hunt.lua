SMODS.Challenge {
    key = 'SEMBY_shiny_hunt',
    rules = {
        custom = {
            { id = 'SEMBY_shiny_hunt' },
            { id = 'SEMBY_space' },
            { id = 'SEMBY_extra_bonus' },
        },
        modifiers = {
            --{ id = 'joker_slots', value = 5 },
            { id = 'consumable_slots', value = 5 },
            { id = 'dollars', value = 25 },
            { id = 'winning_ante', value = 12 },
        }
    },
    jokers = {
        { id = 'j_ceremonial', pinned = true, eternal = true, edition = "negative" },
        { id = 'j_egg', edition = "SEMBY_shiny", SEMBY_glitched = 4.0 },
        { id = 'j_egg', edition = "SEMBY_shiny", SEMBY_glitched = 4.0 },
        { id = 'j_egg', edition = "SEMBY_shiny", SEMBY_glitched = 4.0 },
        { id = 'j_egg', edition = "SEMBY_shiny", SEMBY_glitched = 4.0 },
        { id = 'j_egg', edition = "SEMBY_shiny", SEMBY_glitched = 4.0 },
    },
    vouchers = {
        { id = 'v_blank' },
        { id = 'v_seed_money' },
        { id = 'v_money_tree' },
    },
    consumeables = {
        { id = 'c_talisman' },
        { id = 'c_talisman' },
        { id = 'c_talisman' },
        { id = 'c_talisman' },
        { id = 'c_talisman' },
    },
    deck = {
        type = 'Challenge Deck',
		edition = 'SEMBY_shiny'
    },
	apply = function(self)
        G.GAME.SEMBY_OHH_SHINY = true
		G.GAME.modifiers.money_per_hand = (G.GAME.modifiers.money_per_hand or 1) + 1
		-- Change Eggs:
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			func = function()
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					func = function()
						for i = 2, #G.jokers.cards do
							G.jokers.cards[i].ability.extra = G.jokers.cards[i].ability.extra * 4.0
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
