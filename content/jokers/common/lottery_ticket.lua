SMODS.Joker {
	key = "lottery_ticket",
	name = "SEMBY_lottery_ticket",
	atlas = "SEMBY_jokers",
	pos = { x = 4, y = 4 },
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
	rarity = 1,
	cost = 5,
	config = {
		extra = {
			chance = {
				max = 3,
				base = 4
			},
			mult = 2.5,
			chips = 12
		}
	},
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
		local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.chance.base, 'SEMBY_lottery_ticket')
		return { vars = {
			math.min(card.ability.extra.chance.max, numerator),
			denominator,
			card.ability.extra.mult,
			card.ability.extra.chips
		} }
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play
		and context.other_card:get_id() <= 10
		and context.other_card:get_id() >= 2
		then
			-- Scuffed way of always having a Chance for Chips:
			local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.chance.base, 'SEMBY_lottery_ticket')
			if math.random(1, math.floor(denominator)) <= math.min(card.ability.extra.chance.max, math.floor(numerator)) then
				return { mult = card.ability.extra.mult }
			else return { chips = card.ability.extra.chips } end
		end
	end
}
