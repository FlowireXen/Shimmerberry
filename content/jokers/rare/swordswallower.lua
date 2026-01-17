SMODS.Joker {
	key = "swordswallower",
	name = "SEMBY_swordswallower",
	atlas = "SEMBY_jokers",
	pos = { x = 2, y = 2 },
    unlocked = true,
    discovered = false,
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
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
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
