SMODS.Joker {
	key = "stylish_joker",
	name = "SEMBY_stylish_joker",
	atlas = "SEMBY_jokers",
	pos = { x = 7, y = 5 },
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = false,
	rarity = 2,
	cost = 5,
	config = {
		extra = {
			hand_size = 1,
			slots = 2,
			gold = 1
		}
	},
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
		return { vars = {
			card.ability.extra.hand_size,
			card.ability.extra.slots,
			card.ability.extra.gold
		} }
	end,
    add_to_deck = function(self, card, from_debuff)
		G.hand:change_size(-card.ability.extra.hand_size)
		G.consumeables:change_size(card.ability.extra.slots)
    end,
    remove_from_deck = function(self, card, from_debuff)
		G.hand:change_size(card.ability.extra.hand_size)
		G.consumeables:change_size(-card.ability.extra.slots)
    end,
    calc_dollar_bonus = function(self, card)
		local stylish_gold = card.ability.extra.gold * #G.consumeables.cards
		if stylish_gold > 0 then
			-- Silly Effect:
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.2,
				blocking = false,
				func = function()
					G.consumeables:juice_up()
					return true
				end
			}))
			-- Gold
			return stylish_gold
		end
    end
}
