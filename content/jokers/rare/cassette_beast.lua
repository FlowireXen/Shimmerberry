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
			local repeats = math.max(0, G.GAME.SEMBY_suit_count - 1)
			if repeats ~= 0 then return { repetitions = repeats }, true end
        end
	end
}
