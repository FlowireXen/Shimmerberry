SMODS.Joker {
	key = "swordswallower",
	SEMBY_art = "unkokat",
	atlas = "SEMBY_jokers_1",
	pos = { x = 4, y = 7 },
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
	rarity = 3,
    cost = 8,
	config = {
		extra = {
			Xmult = 1.0
		}
	},
    attributes = {
		'xmult', 'joker'
	},
	loc_vars = function(self, info_queue, card)
		local commons = 0
        if G.jokers then
            for _, joker in pairs(G.jokers.cards) do
                if joker.config.center.rarity == 1 then
                    commons = commons + 1
                end
            end
        end
        return { vars = {
			card.ability.extra.Xmult,
			(1.0 + commons * card.ability.extra.Xmult)
		} }
    end,
	calculate = function(self, card, context)
		if context.joker_main then
			local commons = 0
			if G.jokers then
				for _, joker in pairs(G.jokers.cards) do
					if joker.config.center.rarity == 1 then
						commons = commons + 1
					end
				end
			end
        	return {
				xmult = (1.0 + commons * card.ability.extra.Xmult)
			}
        end
    end
}
