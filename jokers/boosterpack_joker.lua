SMODS.Joker {
	key = "boosterpack_joker",
	name = "SEMBY_boosterpack_joker",
	rarity = 1,
	cost = 7,
	atlas = "SEMBY_jokers",
	pos = { x = 5, y = 1 },
	blueprint_compat = false,
    config = { extra = { boosterpacks = 2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.boosterpacks } }
    end,
    add_to_deck = function(self, card, from_debuff)
        SMODS.change_booster_limit(card.ability.extra.boosterpacks)
    end,
    remove_from_deck = function(self, card, from_debuff)
        SMODS.change_booster_limit(-card.ability.extra.boosterpacks)
    end,
	calculate = function(self, card, context)
		if context.starting_shop and not context.blueprint then
			card_eval_status_text(card, 'extra', nil, nil, nil, {message = '+'..card.ability.extra.boosterpacks, colour = G.C.ATTENTION})
			return
		end
	end
}
