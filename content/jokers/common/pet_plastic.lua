SMODS.Joker {
	key = "pet_plastic",
	SEMBY_art = "unkokat",
	atlas = "SEMBY_jokers_1",
	pos = { x = 6, y = 3 },
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
	rarity = 1,
	cost = 5,
	config = {
		extra = {
			mult_gain = 2,
			mult = 0
		}
	},
    attributes = {
		'discard', 'mult', 'scaling', 'reset'
	},
	loc_vars = function(self, info_queue, card)
		return { vars = {
			card.ability.extra.mult_gain,
			card.ability.extra.mult
		} }
	end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
		if not context.blueprint then
			if context.discard then
				-- Unlike "hemoturgy.lua", this Joker shouldn't take up any time while discarding,
				-- that means that I'm using this Method instead of returning normally:
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					blocking = false,
					func = function()
						card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
						card:juice_up(0.1)
						play_sound('generic1', 1.2, 0.5)
						attention_text({
							text = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
							backdrop_colour = G.C.MULT,
							scale = 0.8,
							hold = 0.5,
							major = card,
							align = 'bm',
							offset = { x = 0, y = 0 }
						})
						return true
					end
				}))
				return nil, true
			end
			if context.end_of_round and context.main_eval and context.game_over == false and card.ability.extra.mult ~= 0 then
				card.ability.extra.mult = 0
				return {
					message = localize('k_reset'),
					colour = G.C.RED
				}
			end
		end
    end
}
