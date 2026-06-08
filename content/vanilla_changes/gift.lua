--Ownership: Buffs "Gift Card"; +$1 -> +$2, Blueprint Compat.
SMODS.Joker:take_ownership( 'gift', {
    blueprint_compat = true,
    config = {
        extra = 2
    },
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval then
            for _, area in ipairs({ G.jokers, G.consumeables }) do
                for _, other_card in ipairs(area.cards) do
                    if other_card.set_cost then
                        other_card.ability.extra_value = (other_card.ability.extra_value or 0) + card.ability.extra
                        other_card:set_cost()
                    end
                end
            end
            return {
                message = localize('k_val_up'),
                colour = G.C.MONEY
            }
        end
    end
}, false)
