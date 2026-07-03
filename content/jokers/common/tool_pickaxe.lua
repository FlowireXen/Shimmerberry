SMODS.Joker {
	key = "tool_pickaxe",
	SEMBY_art = "unkokat",
	atlas = "SEMBY_jokers_1",
	pos = { x = 3, y = 1 },
    eternal_compat = false,
    perishable_compat = true,
    blueprint_compat = true,
	rarity = 1,
	cost = 5,
	config = {
		extra = {
			-- Durability
			durability = 200,
			durability_max = 200,
			-- Joker
			used = false,
			dollars = 2,
			numerator = 2,
			denominator = 5
		}
	},
    attributes = {
		'economy', 'chance', 'suit',
		'durability'
	},
	pools = {
        ["Durability"] = true,
    },
	loc_vars = function(self, info_queue, card)
        local suit = (G.GAME.current_round.SEMBY_tool_suit or {}).suit or 'Spades'
		local numerator, denominator = SMODS.get_probability_vars(card,
			card.ability.extra.numerator, card.ability.extra.denominator, 'SEMBY_tool_pickaxe')
		local percentage = math.floor((numerator / denominator) * 100 + 0.5)
		return { vars = {
			localize(suit, 'suits_singular'),
			math.min(100, percentage),
			card.ability.extra.dollars,
			card:SEMBY_durability_amount(),
			colours = { 
				G.C.SUITS[suit],
				card:SEMBY_durability_color()
			}
		} }
	end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.hand and not context.end_of_round
		and context.other_card:is_suit(G.GAME.current_round.SEMBY_tool_suit.suit)
		and (context.blueprint or card:SEMBY_durability_use()) then
			card.ability.extra.used = true -- Only Check+Announce Durability if used
			if SMODS.pseudorandom_probability(card, 'SEMBY_tool_pickaxe',
				card.ability.extra.numerator, card.ability.extra.denominator)
			then
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
				card:SEMBY_durability_check()
			end
		end
    end
}
