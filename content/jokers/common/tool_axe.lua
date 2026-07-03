SMODS.Joker {
	key = "tool_axe",
	SEMBY_art = "unkokat",
	atlas = "SEMBY_jokers_1",
	pos = { x = 1, y = 1 },
    eternal_compat = false,
    perishable_compat = true,
    blueprint_compat = true,
	rarity = 1,
	cost = 6,
	config = {
		extra = {
			-- Durability
			durability = 80,
			durability_max = 100,
			-- Joker
			used = false,
			numerator = 1,
			denominator = 5
		}
	},
    attributes = {
		'destroy_card', 'chance', 'suit',
		'durability'
	},
	pools = {
        ["Durability"] = true,
    },
	loc_vars = function(self, info_queue, card)
        local suit = (G.GAME.current_round.SEMBY_tool_suit or {}).suit or 'Spades'
		local numerator, denominator = SMODS.get_probability_vars(card,
			card.ability.extra.numerator, card.ability.extra.denominator, 'SEMBY_tool_axe')
		local percentage = math.floor((numerator / denominator) * 100 + 0.5)
		return { vars = {
			localize(suit, 'suits_singular'),
			math.min(100, percentage),
			card:SEMBY_durability_amount(),
			colours = {
				G.C.SUITS[suit],
				card:SEMBY_durability_color()
			}
		} }
	end,
    calculate = function(self, card, context)
		-- I'm using Individual for easier "Animation"/Announce
        if context.individual and context.cardarea == G.hand and not context.end_of_round
		and context.other_card:is_suit(G.GAME.current_round.SEMBY_tool_suit.suit)
		and (context.blueprint or card:SEMBY_durability_use()) then
			card.ability.extra.used = true -- Only Check+Announce Durability if used
			if SMODS.pseudorandom_probability(card, 'SEMBY_tool_axe',
				card.ability.extra.numerator, card.ability.extra.denominator)
			then
				context.other_card.ability.SEMBY_axed = true
				return {
					message = localize('SEMBY_hit_ex'),
					colour = G.C.GREEN
				}
			else
				return {
					message = localize('SEMBY_miss_ex'),
					colour = G.C.RED
				}
			end
        end
        if context.destroy_card and context.cardarea == G.hand
		and context.destroy_card.ability.SEMBY_axed then
			context.destroy_card.ability.SEMBY_axed = nil
			return { remove = true }
        end
		if context.after and not context.blueprint then
			if card.ability.extra.used then
				card.ability.extra.used = false
				card:SEMBY_durability_check()
			end
		end
    end
}
