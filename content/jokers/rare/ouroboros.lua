SMODS.Joker {
	key = "ouroboros",
	SEMBY_art = "unkokat",
	atlas = "SEMBY_jokers_1",
	pos = { x = 9, y = 2 },
    eternal_compat = false,
    perishable_compat = true,
    blueprint_compat = true,
	rarity = 3,
	cost = 8,
	config = {
		extra = {
			hands = 1,
			percent = 0.08
		}
	},
    attributes = {
		'hands', 'xblindsize', 'eight',
		'animal',
	},
	loc_vars = function(self, info_queue, card)
		return { vars = {
			card.ability.extra.hands,
			100 * card.ability.extra.percent
		} }
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play and context.other_card:get_id() == 8 then
			return {
				func = function()
					SEMBY_Increase_Blindsize(card.ability.extra.percent, context.other_card, true)
					ease_hands_played(card.ability.extra.hands)
					return true
				end,
				--> This makes the "+1 Hand" Text appear WHILE you gain +1 Hand
				extra = {
					message = localize{type = 'variable', key = 'a_hands', vars = { card.ability.extra.hands }},
					colour = G.C.BLUE
				}
			}
		end
	end
}
