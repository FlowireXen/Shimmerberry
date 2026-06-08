SMODS.Joker{
	key = "lost_constellation",
	SEMBY_art = "flowire",
    atlas = 'SEMBY_jokers_1',
    pos = { x = 7, y = 5 },
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    rarity = 2,
	cost = 6,
	config = {
		extra = {
			numerator = 1,
			denominator = 3,
			loops = 2
		}
	},
    attributes = {
		'passive', 'planet', 'space'
	},
	loc_vars = function(self, info_queue, card)
		local numerator, denominator = SMODS.get_probability_vars(card,
			card.ability.extra.numerator, card.ability.extra.denominator, 'SEMBY_lost_constellation')
		info_queue[#info_queue + 1] = { key = "inspired_tetrapak", set = "Other" }
		return { vars = { numerator, denominator, card.ability.extra.loops } }
	end,
    calculate = function(self, card, context)
        if context.using_consumeable
		and context.consumeable.ability.set == "Planet"
		and context.consumeable.ability.consumeable
		and context.consumeable.ability.consumeable.hand_type
		and SMODS.pseudorandom_probability(card, 'SEMBY_lost_constellation',
			card.ability.extra.numerator, card.ability.extra.denominator)
		then
			for i = 1, card.ability.extra.loops do
				card_eval_status_text((context.blueprint_card or card), 'extra', nil, nil, nil, {
					message = localize('k_again_ex')
				})
                SMODS.upgrade_poker_hands({
                    hands = context.consumeable.ability.consumeable.hand_type,
                    level_up = 1,
					from = context.consumeable
                })
			end
        end
    end
}
