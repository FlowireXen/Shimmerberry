SMODS.Joker {
	key = "tool_hoe",
	SEMBY_art = "unkokat",
	atlas = "SEMBY_jokers_1",
	pos = { x = 2, y = 1 },
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
			chips = 25
		}
	},
    attributes = {
		'chips', 'suit',
		'durability'
	},
	pools = {
        ["Durability"] = true,
    },
	loc_vars = function(self, info_queue, card)
        local suit = (G.GAME.current_round.SEMBY_tool_suit or {}).suit or 'Spades'
		return { vars = {
			localize(suit, 'suits_singular'),
			card.ability.extra.chips,
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
			return {
				chips = card.ability.extra.chips
			}
        end
		if context.after and not context.blueprint then
			if card.ability.extra.used then
				card.ability.extra.used = false
				card:SEMBY_durability_check()
			end
		end
    end
}
