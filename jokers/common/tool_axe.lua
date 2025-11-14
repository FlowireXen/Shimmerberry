SMODS.Joker {
	key = "tool_axe",
	name = "SEMBY_tool_axe",
	atlas = "SEMBY_jokers",
	pos = { x = 9, y = 6 },
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
				max_durability = 100,
				durability = 80,
				repair_cost = 2,
				repair_gain = 1
			},
			used = false,
			chance = 5
		}
	},
	pools = {
		Tool = true,
        Repairable = true,
    },
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
        local suit = (G.GAME.current_round.SEMBY_tool_suit or {}).suit or 'Spades'
		local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.chance, 'SEMBY_tool_axe')
		local percentage = math.floor((numerator / denominator) * 100 + 0.5)
		return { vars = {
			localize(suit, 'suits_singular'),
			percentage,
			card:durability_amount(),
			colours = { 
				G.C.SUITS[suit],
				card:durability_color()
			}
		} }
	end,
    calculate = function(self, card, context)
		-- I'm using Individual for easier "Animation"/Announce
        if context.individual and context.cardarea == G.hand and not context.end_of_round
		and context.other_card:is_suit(G.GAME.current_round.SEMBY_tool_suit.suit)
		and (context.blueprint or card:durability_use()) then
			card.ability.extra.used = true -- Only Check+Announce Durability if used
			if pseudorandom('SEMBY_tool_axe') < G.GAME.probabilities.normal / card.ability.extra.chance then
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
				card:durability_check()
			end
		end
    end
}
