local CLM, NUM, DEN = 1, 1, 10
SMODS.Sticker {
    key = "bound",
    SEMBY_art = "flowire",
    badge_colour = darken(G.C.PERISHABLE, 0.25),
    atlas = "SEMBY_stickers",
    pos = { x = 1, y = 1 },
    config = {
        card_limit = CLM,
        numerator = NUM,
        denominator = DEN
    },
    loc_vars = function(self, info_queue, card)
		local bound = card.ability and card.ability.SEMBY_bound or {}
        local numerator, denominator = SMODS.get_probability_vars(card, bound.numerator or NUM, bound.denominator or DEN, 'SEMBY_bound')
        return { vars = {
            bound.card_limit or CLM,
            numerator,
            denominator
        } }
    end,
    should_apply = function(self, card, center, area, bypass_roll)
        return (bypass_roll or false)
    end,
	calculate = function(self, card, context)
		if context.end_of_round and context.main_eval and context.game_over == false and card.ability then
			local bound = card.ability.SEMBY_bound or {}
			if SMODS.pseudorandom_probability(card, 'SEMBY_bound', bound.numerator or NUM, bound.denominator or DEN) then
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					func = function()
						play_sound('tarot1')
						if SMODS.is_eternal(card, card) then
							SMODS.debuff_card(card, true, "SEMBY_bound")
						else
							card:start_dissolve({
								darken(G.C.PERISHABLE, 0.25),
								lighten(G.C.PERISHABLE, 0.25),
								G.C.PERISHABLE
							})
						end
						return true
					end
				}))
            	return {
					message = localize('SEMBY_bound_ex'),
					colour = darken(G.C.PERISHABLE, 0.25),
					message_card = card
				}
			end
        end
	end
}
