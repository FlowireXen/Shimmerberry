SMODS.Joker {
	key = "broken_record",
	name = "SEMBY_broken_record",
	atlas = "SEMBY_jokers",
	pos = { x = 1, y = 4 },
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
	rarity = 1,
	cost = 4,
	config = {
		extra = {
			repetitions_min = 2,
			repetitions_max = 3,
			cards = nil
		}
	},
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
		return { vars = {
			card.ability.extra.repetitions_min,
			card.ability.extra.repetitions_max
		} }
	end,
	calculate = function(self, card, context)
        if context.before then --and context.main_eval
			local selected = {}
			local repeats = math.random(card.ability.extra.repetitions_min, card.ability.extra.repetitions_max)
			for i = 1, repeats do
				local ret = pseudorandom_element(context.scoring_hand, pseudoseed('SEMBY_broken_record_'..i))
				table.insert(selected, ret)
			end
			if context.blueprint then -- Blueprint has it's own set!
				context.blueprint_card.ability.SEMBY_cards = selected
			else
				card.ability.extra.cards = selected
			end
			return nil, true
        end
        if context.repetition and context.cardarea == G.play then
			local selected = nil
			if context.blueprint then -- Blueprint has it's own set!
				selected = context.blueprint_card.ability.SEMBY_cards
			else
				selected = card.ability.extra.cards
			end
			if selected then
				local repetitions = 0
				for i = 1, #selected do
					if selected[i] == context.other_card then
						repetitions = repetitions + 1
					end
				end
				if repetitions > 0 then
					return { repetitions = repetitions }
				end
			end
			return nil, true
        end
        if context.after then
			if context.blueprint then -- Blueprint has it's own set!
				context.blueprint_card.ability.SEMBY_cards = nil
			else
				card.ability.extra.cards = nil
			end
			return nil, true
        end
	end
}
