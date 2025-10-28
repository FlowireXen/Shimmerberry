SMODS.Joker {
	key = "benthic_bloom",
	name = "SEMBY_benthic_bloom",
	atlas = "SEMBY_jokers",
	pos = { x = 4, y = 1 },
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = false,
    blueprint_compat = true,
	rarity = 2,
	cost = 6,
	config = {
		SEMBY_possessive = true,
		extra = {
			repetitions = 1
		}
	},
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
		local numerator, denominator = SMODS.get_probability_vars(card, 1, (G.P_CENTERS.m_glass.config.extra or 4), 'SEMBY_benthic_bloom')
        info_queue[#info_queue + 1] = G.P_CENTERS.m_glass
		return { vars = {
			numerator,
			denominator,
			colours = { HEX('BE3740') }
		} }
	end,
	calculate = function(self, card, context)
		if context.repetition then
			if next(SMODS.get_enhancements(context.other_card)) then
				context.other_card.SEMBY_repeated = (context.other_card.SEMBY_repeated or 0) + 1
				return { repetitions = card.ability.extra.repetitions }
			end
		end
		if context.destroy_card and not context.blueprint then
			if context.destroy_card.SEMBY_repeated then
				local destroy = false
				if next(SMODS.get_enhancements(context.destroy_card)) then
					for i = 1, context.destroy_card.SEMBY_repeated do
						if SMODS.pseudorandom_probability(card, 'SEMBY_benthic_bloom', 1, (G.P_CENTERS.m_glass.config.extra or 4)) then
							destroy = true
							break
						end
					end
				end
				context.destroy_card.SEMBY_repeated = nil
				if destroy then
					context.destroy_card.shattered = true
					return { remove = true }
				end
			end
		end
	end,
    in_pool = function(self, args)
		if G.playing_cards then
			for _, playing_card in ipairs(G.playing_cards) do
				if next(SMODS.get_enhancements(playing_card)) then return true end
			end
		end
		return false
	end
}
