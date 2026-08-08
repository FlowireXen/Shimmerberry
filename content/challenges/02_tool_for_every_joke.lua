SMODS.Challenge {
    key = 'SEMBY_tool_for_every_joke',
    rules = {
        custom = {
            { id = 'SEMBY_tool_for_every_joke' },
            { id = 'SEMBY_space' },
            { id = 'no_shop_jokers' },
        },
        modifiers = {
            { id = 'hand_size', value = 15 },
            { id = 'winning_ante', value = 6 },
        }
    },
    restrictions = {
        banned_cards = {
            { id = 'j_SEMBY_toolkit' },
        },
        banned_other = {
            { id = 'bl_final_leaf',  type = 'blind' },
        },
    },
    jokers = {
        { id = 'j_SEMBY_tool_axe', SEMBY_possessive = true },
        { id = 'j_SEMBY_tool_hoe', SEMBY_possessive = true },
        { id = 'j_SEMBY_tool_pickaxe', SEMBY_possessive = true },
        { id = 'j_SEMBY_tool_shovel', SEMBY_possessive = true },
        { id = 'j_SEMBY_eternal_fortune' },
    },
    vouchers = {
        { id = 'v_magic_trick' },
    },
    consumeables = {
        { id = 'c_tower' },
        { id = 'c_lovers' },
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
	            G.E_MANAGER:add_event(Event({
	            	func = function()
	            		for index, joker in pairs(G.jokers.cards) do
                            if joker:SEMBY_has_durability() then
	            				joker.ability.extra.durability = 1000
	            				joker.ability.extra.durability_max = 1000
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
	button_colour = G.C.BLUE
}
