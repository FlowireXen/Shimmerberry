SMODS.Joker {
	key = "shop_1",
	loc_txt = {
		name = "{C:inactive}shop_1",
		text = {
			"{C:attention}+#1#{} card slots",
			"available in shop",
			"every {C:attention}#2#{} shops",
			"{C:inactive}#3#",
		}
	},
	SEMBY_art = "placeholder",
	atlas = "SEMBY_jokers_1",
	pos = { x = 9, y = 8 },
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
	rarity = 2,
	cost = 6,
	config = {
		extra = {
			slots = 2,
			every = 3,
			count = 3,
		}
	},
    attributes = {
		'scaling', 'reset',
		'shop'
	},
	loc_vars = function(self, info_queue, card)
		local ret_count
		if card.ability.extra.count > 1 then
			ret_count = localize{ type = 'variable', key = 'SEMBY_shop_in', vars = { card.ability.extra.count } }
		else
			ret_count = localize(card.ability.extra.count == 1 and 'SEMBY_shop_next' or 'SEMBY_shop_this')
		end
		return { vars = {
			card.ability.extra.slots,
			card.ability.extra.every,
			ret_count
		} }
	end,
	calculate = function(self, card, context)
		if context.starting_shop then
			if not card.ability.extra.triggered then
				card.ability.extra.count = card.ability.extra.count - 1
				card.ability.extra.triggered = true
            	G.E_MANAGER:add_event(Event({ func = function() card.ability.extra.triggered = false; return true end }))
			end
			if card.ability.extra.count <= 0 then
        		change_shop_size(card.ability.extra.slots)
				G.GAME.current_round.SEMBY_shop_size = (G.GAME.current_round.SEMBY_shop_size or 0) + card.ability.extra.slots
				return {
					message = localize{ type = 'variable', key = 'SEMBY_plus', vars = { card.ability.extra.slots } },
					colour = G.C.GREEN
				}, true
			end
			return {
				message = tostring(card.ability.extra.count),
				colour = G.C.IMPORTANT
			}, true
		end
        if context.ending_shop and card.ability.extra.count <= 0 then
			card.ability.extra.count = card.ability.extra.every
		end
	end
}
