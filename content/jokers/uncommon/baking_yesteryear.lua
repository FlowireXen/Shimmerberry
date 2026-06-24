SMODS.Joker {
	key = "baking_yesteryear",
	SEMBY_art = "placeholder",
	atlas = "SEMBY_jokers_1",
	pos = { x = 4, y = 9 },
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
	rarity = 2,
	cost = 5,
	config = {
		extra = {
			numerator = 1,
			denominator = 8
		}
	},
    attributes = {
		'chance', 'scaling'
	},
	enhancement_gate = 'm_SEMBY_vintage',
	loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_SEMBY_vintage
		local numerator, denominator = SMODS.get_probability_vars(card,
			card.ability.extra.numerator, card.ability.extra.denominator, 'SEMBY_vintage_joker')
		return { vars = {
			numerator,
			denominator
		} }
	end,
	calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, 'm_SEMBY_vintage')
		and SMODS.pseudorandom_probability(card, 'SEMBY_vintage_joker', card.ability.extra.numerator, card.ability.extra.denominator)
		then return { level_up = 1 } end
	end
}
