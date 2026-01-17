SMODS.Joker {
	key = "money_laundering",
	name = "SEMBY_money_laundering",
	atlas = "SEMBY_jokers",
	pos = { x = 11, y = 5 },
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
	rarity = 2,
	cost = 9,
	config = {
		extra = {
			hands = 2.0,
			discards = 2.0,
			shop_mod = 1.0,
			reroll = 3
		}
	},
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
        return { vars = {
			card.ability.extra.hands,
			card.ability.extra.discards,
			math.floor(card.ability.extra.shop_mod * 100)
		} }
    end,
    add_to_deck = function(self, card, from_debuff)
		G.GAME.SEMBY_shop_mod = (G.GAME.SEMBY_shop_mod or 1.0) + card.ability.extra.shop_mod
		for k, v in pairs(G.I.CARD) do
			if v.set_cost then v:set_cost() end
		end
		G.GAME.round_resets.reroll_cost = G.GAME.round_resets.reroll_cost + card.ability.extra.reroll
		G.GAME.current_round.reroll_cost = G.GAME.current_round.reroll_cost + card.ability.extra.reroll
    end,
    remove_from_deck = function(self, card, from_debuff)
		G.GAME.SEMBY_shop_mod = G.GAME.SEMBY_shop_mod - card.ability.extra.shop_mod
		for k, v in pairs(G.I.CARD) do
			if v.set_cost then v:set_cost() end
		end
		G.GAME.round_resets.reroll_cost = G.GAME.round_resets.reroll_cost - card.ability.extra.reroll
		G.GAME.current_round.reroll_cost = math.max(0, G.GAME.current_round.reroll_cost - card.ability.extra.reroll)
    end,
	calculate = function(self, card, context)
		if context.setting_blind and not (context.blueprint_card or self).getting_sliced then
			ease_hands_played(card.ability.extra.hands, false)
			ease_discard(card.ability.extra.discards, false, true)
			-- Just a silly lil' joke :>
			if SMODS.pseudorandom_probability(card, 'SEMBY_money_laundering', 1, 100) then
				return {
					message = localize('SEMBY_money_dirty'),
					colour = G.C.RED
				}
			else
				return {
					message = localize('SEMBY_money_clean'),
					colour = G.C.GREEN
				}
			end
		end
	end
}
