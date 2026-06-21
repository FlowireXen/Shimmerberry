SMODS.Joker {
	key = "ghostsalt_contract",
	SEMBY_art = "ghostsalt",
	atlas = "SEMBY_jokers_1",
	pos = { x = 6, y = 7 },
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
	rarity = 3,
	cost = 7,
	config = {
		extra = {
			neg_numerator = 1, neg_denominator = 13,
			pos_numerator = 2, pos_denominator = 13,
		}
	},
    attributes = {
		'edition', 'sticker', 'chance', 'perma_bonus',
		'shop'
	},
	loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
        info_queue[#info_queue + 1] = { key = 'SEMBY_possessive', set = 'Other' }
		info_queue[#info_queue + 1] = { key = 'inspired_phanta', set = 'Other' }
		local neg_num, neg_den = SMODS.get_probability_vars(card,
			card.ability.extra.neg_numerator, card.ability.extra.neg_denominator, 'SEMBY_ghostsalt_contract', nil, true)
		local pos_num, pos_den = SMODS.get_probability_vars(card,
			card.ability.extra.pos_numerator, card.ability.extra.pos_denominator, 'SEMBY_ghostsalt_contract', nil, true)
		return { vars = {
			neg_num, neg_den,
			pos_num, pos_den,
		} }
	end,
	calculate = function(self, card, context)
		if context.modify_shop_card then
			local neg_trigger = not (context.card.SEMBY_ghostsalt_neg or context.card.edition) and
								SMODS.pseudorandom_probability(card, 'SEMBY_ghostsalt_contract',
									card.ability.extra.neg_numerator, card.ability.extra.neg_denominator, nil, true)
			local pos_trigger = not (context.card.SEMBY_ghostsalt_pos or context.card.ability.SEMBY_possessive) and
								SMODS.pseudorandom_probability(card, 'SEMBY_ghostsalt_contract',
									card.ability.extra.pos_numerator, card.ability.extra.pos_denominator, nil, true)
			if neg_trigger or pos_trigger then
				-- Blueprint Compat.
				context.card.SEMBY_ghostsalt_neg = context.card.SEMBY_ghostsalt_neg or neg_trigger
				context.card.SEMBY_ghostsalt_pos = context.card.SEMBY_ghostsalt_pos or pos_trigger
				local juice_card = (context.blueprint_card or card)
				-- Flip
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.2,
					func = function()
						context.card:flip()
						juice_card:juice_up(0.1, 0.2)
						play_sound('card1', math.random()*0.2 + 0.85, 0.5)
						return true
					end
				}))
				-- Apply Triggers
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.2,
					func = function()
						if neg_trigger then context.card:set_edition('e_negative', true, true) end
						if pos_trigger then context.card:add_sticker('SEMBY_possessive', true) end
						context.card.SEMBY_ghostsalt_neg = nil
						context.card.SEMBY_ghostsalt_pos = nil
						return true
					end
				}))
				-- Unflip
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.4,
					func = function()
						context.card:flip()
						juice_card:juice_up(0.1, 0.2)
						play_sound('card1', math.random()*0.2 + 1.05, 0.5)
						return true
					end
				}))
				-- Message
				if neg_trigger and pos_trigger then
					return { message = localize('SEMBY_ghostract_3'), colour = G.C.ETERNAL }
				elseif pos_trigger then
					return { message = localize('SEMBY_ghostract_2'), colour = G.C.SEMBY_DEGRADING }
				else
					return { message = localize('SEMBY_ghostract_1'), colour = G.C.DARK_EDITION }
				end
			end
		end
	end
}
