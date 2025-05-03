SMODS.Joker {
	key = "debugjoker",
	loc_txt = {
		name = "DEBUGJOKER",
		text = {
            "{X:chips,C:white} X0.0 {} Chips, {X:mult,C:white} X0.0 {} Mult",
			"{C:blue}+1{} hand every hand",
			"{C:red}+1{} discard every discard",
		}
	},
	rarity = 1, cost = 0,
	atlas = "SEMBY_jokers",
	pos = { x = 6, y = 0 },
	blueprint_compat = true,
	calculate = function(self, card, context)
        if context.cardarea == G.jokers then
			if context.joker_main then
				ease_hands_played(1)
				return { xmult = 0.0, xchips = 0.0 }
			elseif context.discard and context.other_card == context.full_hand[#context.full_hand] then
				-- just "context.discard" triggers on every discarded card!
				ease_discard(1)
			end
        end
    end
}
