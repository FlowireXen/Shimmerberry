SMODS.Joker {
	key = "the_giant",
	name = "SEMBY_the_giant",
	atlas = "SEMBY_jokers",
	pos = { x = 11, y = 7 },
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
	rarity = 2,
	cost = 6,
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
	end,
	calculate = function(self, card, context)
		if context.setting_blind and not (context.blueprint_card or self).getting_sliced then
			-- I wanted to make this Work with The Dwarf and Other Discard-Giving Effects...
			-- But in the end, I think I'll keep it a lil different.
			-- (I could use The Dwarf's Implementation, but EH.)
			local discards = math.max(0, G.GAME.current_round.discards_left)
			if discards ~= 0 then
				G.GAME.round_resets.temp_handsize = (G.GAME.round_resets.temp_handsize or 0) + discards
				G.hand:change_size(discards)
				ease_discard(-discards)
			end
			return {
				message = '+'..discards..' '..localize('SEMBY_bigg'),
				colour = discards > 0 and G.C.GREEN or G.C.RED,
			}
        end
	end
}
