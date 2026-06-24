SMODS.Joker {
	key = "paper_swan",
	SEMBY_art = "placeholder",
	atlas = "SEMBY_jokers_1",
	pos = { x = 3, y = 8 },
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
	rarity = 1,
	cost = 5,
	config = {
		extra = {
			xchips = 2.0,
			every = 5,
			count = 0
		}
	},
    attributes = {
		'hands', 'xchips',
		'ocean', 'animal',
	},
	loc_vars = function(self, info_queue, card)
		return { vars = {
			card.ability.extra.xchips,
			card.ability.extra.every,
			card.ability.extra.count
		} }
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			if context.blueprint_card then
				context.blueprint_card.ability.SEMBY_paper_swan = context.blueprint_card.ability.SEMBY_paper_swan + 1
				if context.blueprint_card.ability.SEMBY_paper_swan >= card.ability.extra.every then
					context.blueprint_card.ability.SEMBY_paper_swan = 0
					return { xchips = card.ability.extra.xchips }
				end
				return {
					message = localize { type = 'variable', key = 'SEMBY_out_of', vars = {
						context.blueprint_card.ability.SEMBY_paper_swan, card.ability.extra.every
					} }
				}
			else
				card.ability.extra.count = card.ability.extra.count + 1
				if card.ability.extra.count >= card.ability.extra.every then
					card.ability.extra.count = 0
					return { xchips = card.ability.extra.xchips }
				end
				return {
					message = localize { type = 'variable', key = 'SEMBY_out_of', vars = {
						card.ability.extra.count, card.ability.extra.every
					} }
				}
			end
		end
		if context.blueprint_card then
			if context.before then context.blueprint_card.ability.SEMBY_paper_swan = card.ability.extra.count end
			if context.after then context.blueprint_card.ability.SEMBY_paper_swan = nil end
		end
	end
}
