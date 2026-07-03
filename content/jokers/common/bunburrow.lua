SMODS.Joker {
	key = "bunburrow", -- Reference: Paquerette Down the Bunburrows
	SEMBY_art = "placeholder",
	atlas = "SEMBY_jokers_1",
	pos = { x = 8, y = 8 },
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
	rarity = 1,
	cost = 4,
	config = {
		extra = {
			money = 12,
			every = 4,
			count = 4,
		}
	},
    attributes = {
		'reroll', 'economy',
		'shop', 'animal'
	},
	loc_vars = function(self, info_queue, card)
		return { vars = {
			card.ability.extra.money,
			card.ability.extra.every,
			card.ability.extra.count
		} }
	end,
	calculate = function(self, card, context)
		if context.reroll_shop then
			if not card.ability.extra.triggered then
				card.ability.extra.count = card.ability.extra.count - 1
				card.ability.extra.triggered = true
            	G.E_MANAGER:add_event(Event({ func = function() card.ability.extra.triggered = false; return true end }))
			end
			if card.ability.extra.count <= 0 then
                G.E_MANAGER:add_event(Event({ func = function() card.ability.extra.count = card.ability.extra.every; return true end }))
				return { dollars = card.ability.extra.money }
			end
		end
	end
}
