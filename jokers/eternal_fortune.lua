SMODS.Joker {
	key = "eternal_fortune",
	name = "SEMBY_eternal_fortune",
	atlas = "SEMBY_jokers",
	pos = { x = 6, y = 1 },
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = false,
	rarity = 1,
	cost = 4,
	config = {
		extra = {
			hands = 1.0,
			luck = 1.0
		}
	},
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
		return { vars = {
			card.ability.extra.hands,
			card.ability.extra.luck
		} }
	end,
    add_to_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({func = function()
			G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.hands
			ease_hands_played(card.ability.extra.hands)
			card:juice_up(0.1, 0.1) -- Tiny "Wind"-Shake
		return true end }))
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({func = function()
			G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.hands
			if not G.GAME.blind.in_blind then
				ease_hands_played(-card.ability.extra.hands)
			end
		return true end }))
    end,
    calculate = function(self, card, context)
        if context.mod_probability and not context.blueprint then
            return {
                numerator = context.numerator + card.ability.extra.luck
            }
        end
    end
}
