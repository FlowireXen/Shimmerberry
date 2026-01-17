SMODS.Joker {
	key = "improv",
	name = "SEMBY_improv",
	atlas = "SEMBY_jokers",
	pos = { x = 7, y = 3 },
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
	rarity = 3,
	cost = 8,
	config = {
		extra = {
			discard_amount = 1,
			hand_amount = 1,
			limit_money_per_hand = 1
		}
	},
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
		return { vars = {
			card.ability.extra.discard_amount,
			card.ability.extra.hand_amount,
			card.ability.extra.limit_money_per_hand
		} }
	end,
    add_to_deck = function(self, card, from_debuff)
		G.GAME.modifiers.money_per_hand = (G.GAME.modifiers.money_per_hand or 1) - card.ability.extra.limit_money_per_hand
    end,
    remove_from_deck = function(self, card, from_debuff)
		G.GAME.modifiers.money_per_hand = (G.GAME.modifiers.money_per_hand or 0) + card.ability.extra.limit_money_per_hand
    end,
	calculate = function(self, card, context)
		if context.before and context.cardarea == G.jokers then
			-- Do you have *any* Discards left?
			if G.GAME.current_round.discards_left > 0 then
				-- Okay, but what about previous Improv. Triggers?
				if (G.GAME.current_round.discards_left - (G.GAME.SEMBY_improv or 0)) > 0 then -- You may pass (this round)!
					G.GAME.SEMBY_improv = (G.GAME.SEMBY_improv or 0) + card.ability.extra.discard_amount
					ease_discard(-card.ability.extra.discard_amount)
					return {
						message = localize{type = 'variable', key = 'SEMBY_discards_minus', vars = { card.ability.extra.discard_amount }},
						colour = G.C.RED,
						func = function()
							ease_hands_played(card.ability.extra.hand_amount)
							return true
						end,
						extra = {
							message = localize{type = 'variable', key = 'a_hands', vars = { card.ability.extra.hand_amount }},
							colour = G.C.BLUE,
							G.E_MANAGER:add_event(Event({
								func = function()
									G.GAME.SEMBY_improv = G.GAME.SEMBY_improv - card.ability.extra.discard_amount
									return true
								end
							}))
						}
					}
				else -- You shall not pass (this round)!
					local juice_card = (context.blueprint_card or card)
					G.E_MANAGER:add_event(Event({
						trigger = 'after',
						delay = 0.2,
						func = function()
							juice_card:juice_up(0.1, 0.2)
							play_sound('cancel')
							return true
						end
					}))
					delay(0.2)
					return nil, true
				end
			end
		end
    end
}
