SMODS.Joker {
	key = "unicorn",
	SEMBY_art = "unkokat",
	atlas = "SEMBY_jokers_1",
	pos = { x = 2, y = 5 },
    eternal_compat = true,
    perishable_compat = false,
    blueprint_compat = true,
	rarity = 1,
	cost = 6,
	config = {
		extra = {
			chips = 12,
			temp_val = 0
		}
	},
    attributes = {
		'chips', 'enhancements', 'editions', 'seals', 'full_deck',
		'magic', 'animal'
	},
	loc_vars = function(self, info_queue, card)
		local abilities = {}
		for i, playing_card in ipairs(G.playing_cards or {}) do
			if playing_card.edition then abilities[playing_card.edition.key] = true end
			if playing_card.seal then abilities[playing_card.seal] = true end
			for i, v in pairs(SMODS.get_enhancements(playing_card) or {}) do
				abilities[i] = v
			end
		end
		local amount = 0
		for i, v in pairs(abilities) do
			amount = amount + 1
		end
		return { vars = {
			card.ability.extra.chips,
			card.ability.extra.chips * amount
		} }
	end,
	calculate = function(self, card, context)
		if context.before and not context.blueprint then
			local abilities = {}
			for i, playing_card in ipairs(G.playing_cards or {}) do
				if playing_card.edition then abilities[playing_card.edition.key] = true end
				if playing_card.seal then abilities[playing_card.seal] = true end
				for i, v in pairs(SMODS.get_enhancements(playing_card) or {}) do
					abilities[i] = v
				end
			end
			card.ability.extra.temp_val = 0
			for i, v in pairs(abilities) do
				card.ability.extra.temp_val = card.ability.extra.temp_val + 1
			end
			return nil, false
		end
		if context.joker_main then
        	return {
        		chips = card.ability.extra.chips * card.ability.extra.temp_val,
				colour = G.C.BLACK
        	}
        end
	end
}
