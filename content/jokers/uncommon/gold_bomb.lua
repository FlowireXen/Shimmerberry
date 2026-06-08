SMODS.Joker {
	key = "gold_bomb",
	SEMBY_art = "flowire",
	atlas = "SEMBY_jokers_1",
	pos = { x = 0, y = 1 },
    eternal_compat = true,
    perishable_compat = false,
    blueprint_compat = false,
	rarity = 2,
	cost = 5,
    attributes = {
		'destroy_card', 'hands'
	},
    calculate = function(self, card, context)
		if G.GAME.current_round.hands_left == 0 and not context.blueprint then
			if context.joker_main then
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					func = function()
						card:SEMBY_set_dissolve({G.C.L_BLACK, G.C.BLACK}, 0.0, 0.4, 0)
						card:juice_up(1.5, math.random() > 0.5 and 1.25 or -1.25)
						return true
					end
				}))
				return {
					message = localize('SEMBY_explode_'..math.random(1, 3)),
					colour = G.C.RED,
					sound = 'SEMBY_explode'
				}
			end
			if context.destroy_card and (context.cardarea == G.play or context.cardarea == 'unscored') then
				return { remove = true }
			end
			if context.after then
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					func = function()
						card:SEMBY_set_dissolve({G.C.L_BLACK, G.C.BLACK}, 0.4, 0.0, 1.0)
						card:juice_up(0.1)
						return true
					end
				}))
			end
		end
    end
}
