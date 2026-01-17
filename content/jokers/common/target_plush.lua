SMODS.Joker {
	key = "target_plush",
	name = "SEMBY_target_plush",
	atlas = "SEMBY_jokers",
	pos = { x = 7, y = 2 },
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
	rarity = 1,
	cost = 6,
	config = {
		extra = {
			chips = 15,
			mult = 4
		}
	},
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
		local jokers = 0
		local joke_limit = 0
		if G.jokers then
			jokers = (#G.jokers.cards or 0)
			joke_limit = (G.jokers.config.card_limit or 0) - jokers
			if joke_limit < 0 then joke_limit = 0 end
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
