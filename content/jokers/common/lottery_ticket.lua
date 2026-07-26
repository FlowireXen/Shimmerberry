SMODS.Joker {
	key = "lottery_ticket",
	SEMBY_art = "unkokat",
	atlas = "SEMBY_jokers_1",
	pos = { x = 3, y = 6 },
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
	rarity = 1,
	cost = 5,
	config = {
		extra = {
			numerator = 1,
			denominator = 4,
			mult = 3,
			chips = 8
		}
	},
    attributes = {
		'chance', 'mult', 'chips', 'face'
	},
	loc_vars = function(self, info_queue, card)
		local numerator, denominator = SMODS.get_probability_vars(card,
			card.ability.extra.numerator, card.ability.extra.denominator, 'SEMBY_lottery_ticket')
		return { vars = {
			numerator,
			denominator,
			card.ability.extra.mult,
			card.ability.extra.chips
		} }
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play
		and not (context.other_card:is_face())
		then
			if SMODS.pseudorandom_probability(card, 'SEMBY_lottery_ticket',
				card.ability.extra.numerator, card.ability.extra.denominator)
			then
				return { mult = card.ability.extra.mult }
			else return { chips = card.ability.extra.chips } end
		end
	end
}
