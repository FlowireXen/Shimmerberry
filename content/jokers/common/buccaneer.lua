SMODS.Joker {
	key = "buccaneer",
	name = "SEMBY_buccaneer",
	atlas = "SEMBY_jokers",
	pos = { x = 6, y = 10 },
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
	rarity = 1,
	cost = 4,
	config = {
		extra = {
			chips = 2
		}
	},
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
        local sell_cost = 0
        for _, joker in ipairs(G.jokers and G.jokers.cards or {}) do
            if joker ~= card then
                sell_cost = sell_cost + joker.sell_cost
            end
        end
		return { vars = {
			card.ability.extra.chips * sell_cost
		} }
	end,
	calculate = function(self, card, context)
        if context.joker_main then
            local sell_cost = 0
            for _, joker in ipairs(G.jokers.cards) do
                if joker ~= card then
                    sell_cost = sell_cost + joker.sell_cost
                end
            end
            return {
                chips = card.ability.extra.chips * sell_cost
            }
        end
	end
}
