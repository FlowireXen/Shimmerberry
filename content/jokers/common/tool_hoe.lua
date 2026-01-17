SMODS.Joker {
	key = "tool_hoe",
	name = "SEMBY_tool_hoe",
	atlas = "SEMBY_jokers",
	pos = { x = 10, y = 6 },
    unlocked = true,
    discovered = false,
    eternal_compat = false,
    perishable_compat = true,
    blueprint_compat = true,
	rarity = 1,
	cost = 5,
	config = {
		extra = {
			SEMBY_Durability = {
				max_durability = 250,
				durability = 250,
				repair_cost = 1,
				repair_gain = 1
			},
			used = false,
			chips = 20
		}
	},
	pools = {
		["Tool"] = true,
        ["Repairable"] = true,
    },
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
        local suit = (G.GAME.current_round.SEMBY_tool_suit or {}).suit or 'Spades'
		return { vars = {
			localize(suit, 'suits_singular'),
			card.ability.extra.chips,
			card:durability_amount(),
			colours = { 
				G.C.SUITS[suit],
				card:durability_color()
			}
		} }
	end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.hand and not context.end_of_round
		and context.other_card:is_suit(G.GAME.current_round.SEMBY_tool_suit.suit)
		and (context.blueprint or card:durability_use()) then
			card.ability.extra.used = true -- Only Check+Announce Durability if used
			return {
				chips = card.ability.extra.chips
			}
        end
		if context.after and not context.blueprint then
			if card.ability.extra.used then
				card.ability.extra.used = false
				card:durability_check()
			end
		end
    end
}
