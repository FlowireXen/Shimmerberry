SMODS.Enhancement {
    key = 'vintage',
	SEMBY_art = "flowire",
	atlas = "SEMBY_enhancements",
	pos = { x = 0, y = 0 },
    badge_colour = G.C.SEMBY_VINTAGE,
	config = {
		extra = {
			repetitions = 1
		}
	},
    calculate = function(self, card, context)
		if context.repetition and G.GAME.SEMBY_vintage_level
		and G.GAME.hands[context.scoring_name].level < G.GAME.SEMBY_vintage_level
		then return { repetitions = card.ability.extra.repetitions } end
    end
}
