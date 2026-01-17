SMODS.Joker {
	key = "gold_bomb",
	name = "SEMBY_gold_bomb",
	atlas = "SEMBY_jokers",
	pos = { x = 8, y = 6 },
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = false,
    blueprint_compat = false,
	rarity = 2,
	cost = 5,
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
	end,
    calculate = function(self, card, context)
		if G.GAME.current_round.hands_left == 0 and not context.blueprint then
			if context.joker_main then
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					func = function()
						card:set_dissolve({G.C.L_BLACK, G.C.BLACK}, 0.0, 0.4, 0)
						card:juice_up(1.5, 1.25)
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
						card:set_dissolve({G.C.L_BLACK, G.C.BLACK}, 0.4, 0.0, 1.0)
						card:juice_up(0.1, 0.1)
						return true
					end
				}))
			end
		end
    end
}
