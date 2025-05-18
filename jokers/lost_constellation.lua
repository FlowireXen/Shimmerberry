SMODS.Joker{
	key = "lost_constellation",
	name = "SEMBY_lost_constellation",
    atlas = 'SEMBY_jokers',
    pos = { x = 0, y = 0 },
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
	config = { extra = { odds = 3, loops = 3 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds, card.ability.extra.loops } }
	end,
    calculate = function(self, card, context)
        if context.using_consumeable then
			local consumeable = context.consumeable
			if consumeable.ability.set == "Planet" then
				if pseudorandom("lost_constellation") < G.GAME.probabilities.normal / card.ability.extra.odds then
					if context.blueprint then
						card = context.blueprint_card
					end
					for i = 1, card.ability.extra.loops - 1 do
						-- Animate Joker
						card_eval_status_text(card, 'extra', nil, nil, nil, { message = localize('k_again_ex') })
						-- Update Left Side Info
						update_hand_text(
							{ sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3 },
							{
								handname = localize(consumeable.ability.consumeable.hand_type, 'poker_hands'),
								chips = G.GAME.hands[consumeable.ability.consumeable.hand_type].chips,
								mult = G.GAME.hands[consumeable.ability.consumeable.hand_type].mult,
								level = G.GAME.hands[consumeable.ability.consumeable.hand_type].level
							}
						)
						-- Level Up Said Hand
						level_up_hand(consumeable, consumeable.ability.consumeable.hand_type)
						-- Reset Left Side Info
						update_hand_text(
							{ sound = 'button', volume = 0.7, pitch = 1.1, delay = 0 },
							{ mult = 0, chips = 0, handname = '', level = '' }
						)
					end
				end
			end
        end
    end
}
