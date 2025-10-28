SMODS.Joker {
	key = "tool_pickaxe",
	name = "SEMBY_tool_pickaxe",
	atlas = "SEMBY_jokers",
	pos = { x = 9, y = 7 },
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
				max_durability = 200,
				durability = 200,
				repair_cost = 1,
				repair_gain = 1
			},
			used = false,
			dollars = 2,
			chance = 2.5
		}
	},
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
        local suit = (G.GAME.current_round.SEMBY_tool_suit or {}).suit or 'Spades'
		local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.chance, 'SEMBY_tool_pickaxe')
		local percentage = math.floor((numerator / denominator) * 100 + 0.5)
		return { vars = {
			localize(suit, 'suits_singular'),
			percentage,
			card.ability.extra.dollars,
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
			if SMODS.pseudorandom_probability(card, 'SEMBY_tool_pickaxe', 1, card.ability.extra.chance) then
				return {
					dollars = card.ability.extra.dollars
				}
			else
				return {
					message = localize{ type = 'variable', key = 'SEMBY_money', vars = { '-' } },
					colour = G.C.GREY
				}
			end
        end
		if context.after and not context.blueprint then
			if card.ability.extra.used then
				card.ability.extra.used = false
				card:durability_check()
			end
		end
    end
}
