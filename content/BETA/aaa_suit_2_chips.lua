SMODS.Joker {
	key = "suit_2_chips",
	loc_txt = {
		name = "{C:inactive}suit_2_chips",
		text = {
			"{C:chips}+#1#{} Chips if poker",
			"hand contains",
			"{C:attention}#2#{} different suits",
		}
	},
	SEMBY_art = "placeholder",
	atlas = "SEMBY_jokers_1",
	pos = { x = 0, y = 9 },
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
	rarity = 1,
	cost = 5,
	config = {
		extra = {
			chips = 50,
			suits = 2
		}
	},
    attributes = {
		'chips', 'suit'
	},
	loc_vars = function(self, info_queue, card)
		return { vars = {
			card.ability.extra.chips,
			card.ability.extra.suits
		} }
	end,
	calculate = function(self, card, context)
        if context.joker_main and (G.GAME.SEMBY_suit_count or 0) >= card.ability.extra.suits then
            return { chips = card.ability.extra.chips }
        end
	end
}
