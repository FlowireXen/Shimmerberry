SMODS.Joker{
	key = "lost_constellation",
	loc_txt = {
		name = "Lost Constellation",
        text = {
            "{C:green}#1# in #2#{} {C:planet}Planet{} cards",
            "upgrade hand {C:attention}#3# times{}",
			"{C:inactive,s:0.75}Inspired by Tetrapak!{}"
        }
	},
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
			if pseudorandom("lost_constellation") < G.GAME.probabilities.normal / card.ability.extra.odds then
				if consumeable.ability.set == "Planet" then
					if context.blueprint then
						card = context.blueprint_card
					end
					for i = 1, card.ability.extra.loops - 1 do
						card_eval_status_text(card, 'extra', nil, nil, nil, { message = localize('k_again_ex') })
						update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3 },
							{
								handname = localize(consumeable.ability.consumeable.hand_type, 'poker_hands'),
								chips = G.GAME
									.hands[consumeable.ability.consumeable.hand_type].chips,
								mult = G.GAME.hands
									[consumeable.ability.consumeable.hand_type].mult,
								level = G.GAME.hands
									[consumeable.ability.consumeable.hand_type].level
							})
						level_up_hand(consumeable, consumeable.ability.consumeable.hand_type)
						update_hand_text({ sound = 'button', volume = 0.7, pitch = 1.1, delay = 0 },
							{ mult = 0, chips = 0, handname = '', level = '' })
					end
				end
			end
        end
    end
}
