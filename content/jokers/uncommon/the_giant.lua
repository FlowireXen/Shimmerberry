SMODS.Joker {
	key = "the_giant",
	SEMBY_art = "unkokat",
	atlas = "SEMBY_jokers_1",
	pos = { x = 2, y = 2 },
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
	rarity = 2,
	cost = 6,
    attributes = {
		'discard', 'hand_size'
	},
	calculate = function(self, card, context)
		if context.setting_blind and not (context.blueprint_card or self).getting_sliced then
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
