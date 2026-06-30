SMODS.Joker {
	key = "foxie_plush",
	SEMBY_art = "placeholder",
	atlas = "SEMBY_jokers_1",
	pos = { x = 5, y = 4 },
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
	rarity = 1,
	cost = 6,
	config = {
		extra = {
			chips = 12,
			mult = 5
		}
	},
    attributes = {
		'joker', 'joker_slot', 'mult', 'chips',
		'animal'
	},
	loc_vars = function(self, info_queue, card)
		local jokers = 0
		local joke_limit = 0
		if G.jokers then
			jokers = #G.jokers.cards
			joke_limit = math.max(0, G.jokers.config.card_limit - jokers)
		end
		return { vars = {
			card.ability.extra.chips,
			card.ability.extra.mult,
			jokers * card.ability.extra.chips,
			joke_limit * card.ability.extra.mult
		} }
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			local jokers = 0
			local joke_limit = 0
			if G.jokers then
				jokers = (#G.jokers.cards or 0)
				joke_limit = (G.jokers.config.card_limit or 0) - jokers
				if joke_limit < 0 then joke_limit = 0 end
			end
			local chips = jokers * card.ability.extra.chips
			local mult = joke_limit * card.ability.extra.mult
			return {
				chips = chips,
				mult = mult
			}
        end
	end
}
