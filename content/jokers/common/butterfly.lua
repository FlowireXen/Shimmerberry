SMODS.Joker {
	key = "butterfly",
	name = "SEMBY_butterfly",
	atlas = "SEMBY_jokers",
	pos = { x = 10, y = 1 },
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
	rarity = 1,
	cost = 6,
	config = {
		extra = {
			chips = 0,
			chip_gain = 10,
			chip_loss = 5,
			type = 'Pair'
		}
	},
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
		return { vars = {
			card.ability.extra.chips >= 0 and '+'..card.ability.extra.chips or card.ability.extra.chips,
			card.ability.extra.chip_gain,
			card.ability.extra.chip_loss,
			localize(card.ability.extra.type, 'poker_hands')
		} }
	end,
	calculate = function(self, card, context)
        if context.before and not context.blueprint then --and context.main_eval
			if next(context.poker_hands[card.ability.extra.type]) then
				card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_gain
				return {
					message = localize('k_upgrade_ex'),
					colour = G.C.CHIPS
				}
			else
				card.ability.extra.chips = card.ability.extra.chips - card.ability.extra.chip_loss
				return {
					message = localize('SEMBY_downgrade_ex'),
					colour = G.C.RED
				}
			end
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
	end
}
