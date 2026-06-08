SMODS.Joker {
	key = "warm_embrace",
	SEMBY_art = "unkokat",
	atlas = "SEMBY_jokers_1",
	pos = { x = 3, y = 2 },
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
	rarity = 1,
	cost = 5,
	config = {
		extra = {
			rounding = 10
		}
	},
    attributes = {
		'mult', 'chips'
	},
	loc_vars = function(self, info_queue, card)
		return { vars = {
			card.ability.extra.rounding
		} }
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			if hand_chips and mult then
				-- Adds 1 to always get the NEXT multiple
				hand_chips = mod_chips(math.ceil((hand_chips + 1) / card.ability.extra.rounding) * card.ability.extra.rounding)
				mult = mod_mult(math.ceil((mult + 1) / card.ability.extra.rounding) * card.ability.extra.rounding)
				update_hand_text({ delay = 0 }, { mult = mult, chips = hand_chips })
				-- Different returns with Specific Colors;
				local embraced = pseudorandom("embraced")
				if embraced < 0.25 then return { message = localize('SEMBY_embraced_1'), colour = G.C.ORANGE }
				elseif embraced < 0.5 then return { message = localize('SEMBY_embraced_2'), colour = G.C.YELLOW }
				elseif embraced < 0.75 then return { message = localize('SEMBY_embraced_3'), colour = G.C.GOLD }
				else return { message = localize('SEMBY_embraced_4'), colour = G.C.RED } end
			end
		end
	end
}
