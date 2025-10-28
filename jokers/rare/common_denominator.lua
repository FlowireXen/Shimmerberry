SMODS.Joker {
	key = "common_denominator",
	name = "SEMBY_common_denominator",
	atlas = "SEMBY_jokers",
	pos = { x = 6, y = 3 },
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
	rarity = 3,
	cost = 10,
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
        if card.area and card.area == G.jokers then
			local commons = 0
			local compatible = 0
			local incompatible = 0
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i].config.center.rarity == 1 then
					commons = commons + 1
					if G.jokers.cards[i].config.center.blueprint_compat then
						compatible = compatible + 1
					else
						incompatible = incompatible + 1
					end
				end
			end
			return { vars = {
				commons,
				compatible,
				incompatible
			} }
        else
			return { vars = { 0, 0, 0 } }
		end
	end,
	calculate = function(self, card, context)
		if not G.jokers then
			return nil
		end
		local common_effects = {}
		for i = 1, #G.jokers.cards do
			if G.jokers.cards[i].config.center.rarity == 1 then
				common_effects[#common_effects + 1] = SMODS.blueprint_effect(card, G.jokers.cards[i], context)
			end
		end
		if common_effects and #common_effects > 0 then
			local merged_hell = {}
			for i = 1, #common_effects do
				merged_hell = SMODS.merge_effects( { merged_hell }, { common_effects[i] or {} } )
			end
			return merged_hell
		else
			return nil
		end
	end
}
