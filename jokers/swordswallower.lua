SMODS.Joker {
	key = "swordswallower",
	name = "SEMBY_swordswallower",
	rarity = 3,
    cost = 8,
	atlas = "SEMBY_jokers",
	pos = { x = 0, y = 1 },
	blueprint_compat = true,
	config = { extra = { Xmult = 1 } },
	loc_vars = function(self, _info, card)
        return { vars = { card.ability.extra.Xmult } }
    end,
	loc_vars = function(self, _info, card)
        local num_common = 0
        if G.jokers then
            for k, v in pairs(G.jokers.cards) do
                if v.config.center.rarity == 1 then
                    num_common = num_common + 1
                end
            end
        end
        local total = card.ability.extra.Xmult and 1 + (card.ability.extra.Xmult * num_common) or 1
        return { vars = { total } }
    end,
	calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main then
            local num_common = 0
            for k, v in pairs(G.jokers.cards) do
                if v.config.center.rarity == 1 then
                    num_common = num_common + 1
                end
            end
            return {
                message = localize { type = 'variable', key = 'a_xmult', vars = { 1 + (card.ability.extra.Xmult * num_common) } },
                Xmult_mod = 1 + (card.ability.extra.Xmult * num_common)
            }
        end
    end
}
