--Ownership "Flower Pot"
SMODS.Joker:take_ownership( 'flower_pot', {
    config = {
        extra = {
            xmult = 4, --> X3 -> X4 Mult
			suits = 4  --> Align with Shimmerberry
        }
    },
    loc_vars = function(self, info_queue, card)
        return { key = 'j_SEMBY_flower_pot', vars = {
            card.ability.extra.xmult,
            card.ability.extra.suits
        } }
    end,
	calculate = function(self, card, context)
        if context.joker_main and (G.GAME.SEMBY_suit_count or 0) >= card.ability.extra.suits then
			return { xmult = card.ability.extra.xmult }
		end
	end
}, false)
