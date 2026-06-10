SMODS.Joker {
	key = "paper_swan",
	loc_txt = {
		name = "Paper Swan",
		text = {
			"{X:chips,C:white}X#1#{} Chips every",
			"{C:attention}#2#{} scoring cards",
			"{C:inactive}(Currently {C:attention}#3#{C:inactive}/#2#)",
		}
	},
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
		-- I give up: Here's logic where "Blueprint"-Effects also up the count. :(
		if context.individual and context.cardarea == G.play then
			card.ability.extra.count = card.ability.extra.count + 1
			if card.ability.extra.count >= card.ability.extra.every then
				card.ability.extra.count = 0;
				return { xchips = card.ability.extra.xchips }, true
			end
			return {
				message = localize { type = 'variable', key = 'SEMBY_out_of', vars = {
					card.ability.extra.count, card.ability.extra.every
				} }
			}, true
		end
	end
}
