SMODS.Joker{
	key = "lost_constellation",
	name = "SEMBY_lost_constellation",
    atlas = 'SEMBY_jokers',
    pos = { x = 0, y = 2 },
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    rarity = 2,
	cost = 6,
	config = {
		extra = {
			odds = 3,
			loops = 2
		}
	},
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
		local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'SEMBY_lost_constellation')
		info_queue[#info_queue + 1] = { key = "inspired_tetrapak", set = "Other" }
		return { vars = { numerator, denominator, card.ability.extra.loops } }
	end,
    calculate = function(self, card, context)
        if context.using_consumeable and context.consumeable.ability.set == "Planet"
		and SMODS.pseudorandom_probability(card, 'SEMBY_lost_constellation', 1, card.ability.extra.odds) then
			for i = 1, card.ability.extra.loops do
				card_eval_status_text((context.blueprint_card or card), 'extra', nil, nil, nil, {
					message = localize('k_again_ex')
				})
				update_hand_text(
					{ sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3 },
					{
						handname = localize(context.consumeable.ability.consumeable.hand_type, 'poker_hands'),
						chips = G.GAME.hands[context.consumeable.ability.consumeable.hand_type].chips,
						mult = G.GAME.hands[context.consumeable.ability.consumeable.hand_type].mult,
						level = G.GAME.hands[context.consumeable.ability.consumeable.hand_type].level
					}
				)
				level_up_hand(context.consumeable, context.consumeable.ability.consumeable.hand_type)
				update_hand_text(
					{ sound = 'button', volume = 0.7, pitch = 1.1, delay = 0 },
					{ mult = 0, chips = 0, handname = '', level = '' }
				)
			end
        end
    end
}
