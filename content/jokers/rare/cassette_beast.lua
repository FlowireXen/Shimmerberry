SMODS.Joker {
	key = "cassette_beast",
	SEMBY_art = "unkokat",
	atlas = "SEMBY_jokers_1",
	pos = { x = 9, y = 8 },
	soul_pos = { x = 9, y = 9 },
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
	rarity = 3,
	cost = 8,
    attributes = {
		'retrigger', 'suit',
		'music', 'animal'
	},
	pools = {
		["Music"] = true,
		["Numetal_Special"] = true,
    },
	calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play and G.GAME.SEMBY_suit_count then
			return {
				repetitions = G.GAME.SEMBY_suit_count
			}, true
        end
	end
}
