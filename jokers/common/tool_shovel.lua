SMODS.Joker {
	key = "tool_shovel",
	name = "SEMBY_tool_shovel",
	atlas = "SEMBY_jokers",
	pos = { x = 10, y = 7 },
    unlocked = true,
    discovered = false,
    eternal_compat = false,
    perishable_compat = true,
    blueprint_compat = true,
	rarity = 1,
	cost = 6,
	config = {
		extra = {
			SEMBY_Durability = {
				max_durability = 200,
				durability = 200,
				repair_cost = 1,
				repair_gain = 1
			},
			used = false,
			xmult = 1.2
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
			card.ability.extra.xmult,
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
				xmult = card.ability.extra.xmult
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
