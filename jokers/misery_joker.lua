SMODS.Joker {
	key = "misery",
	name = "SEMBY_misery",
	rarity = 3,
	cost = 6,
	atlas = "SEMBY_jokers",
	pos = { x = 2, y = 1 },
	blueprint_compat = true,
    config = { extra = { Xmult = 0.5, Xchip = 2.0 } },
	loc_vars = function(self, _info, card)
        return { vars = { card.ability.extra.Xmult, card.ability.extra.Xchip, } }
    end,
	calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main then
            return {
                xmult = card.ability.extra.Xmult,
				xchips = card.ability.extra.Xchip
            }
        end
    end
}
