SMODS.Joker {
	key = "unicorn",
	name = "SEMBY_unicorn",
	atlas = "SEMBY_jokers",
	pos = { x = 9, y = 2 },
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = false,
    blueprint_compat = true,
	rarity = 1,
	cost = 6,
	config = {
		extra = {
			chips = 25,
			temp_val = 0
		}
	},
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
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
