SMODS.Joker {
	key = "seven_wonders",
	SEMBY_art = "unkokat",
	atlas = "SEMBY_jokers_1",
	pos = { x = 1, y = 5 },
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
	rarity = 2,
	cost = 7,
	config = {
		extra = {
			percent_mod = 0.02,
			percent_max = 0.50
		}
	},
    attributes = {
		'rank', 'seven', 'xblindsize', 'full_deck'
	},
	loc_vars = function(self, info_queue, card)
        local seven_tally = 0
        if G.playing_cards then
			for _, playing_card in ipairs(G.playing_cards) do
				if playing_card:get_id() == 7 then seven_tally = seven_tally + 1 end
			end
        end
		seven_tally = math.min(card.ability.extra.percent_max, seven_tally * card.ability.extra.percent_mod)
		return { vars = {
			100 * card.ability.extra.percent_mod,
			100 * seven_tally,
			100 * card.ability.extra.percent_max
		} }
	end,
	calculate = function(self, card, context)
		if context.setting_blind and not (context.blueprint_card or self).getting_sliced then
			local seven_tally = 0
			for _, playing_card in ipairs(G.playing_cards) do
				if playing_card:get_id() == 7 then seven_tally = seven_tally + 1 end
			end
			seven_tally = math.min(card.ability.extra.percent_max, seven_tally * card.ability.extra.percent_mod)
			SEMBY_Reduce_Blindsize(seven_tally, (context.blueprint_card or card), true)
			return nil, true
        end
	end
}
