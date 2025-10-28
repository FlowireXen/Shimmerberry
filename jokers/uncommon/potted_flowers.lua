SMODS.Joker {
	key = "potted_flowers",
	name = "SEMBY_potted_flowers",
	atlas = "SEMBY_jokers",
	pos = { x = 11, y = 3 },
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
	blueprint_compat = true,
	rarity = 2,
	cost = 6,
	config = {
		extra = {
			Xchip_gain = 0.2,
			Xchip = 1.0
		}
	},
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
		return { vars = {
			card.ability.extra.Xchip_gain,
			card.ability.extra.Xchip
		} }
    end,
	calculate = function(self, card, context)
        if context.joker_main then
			if not context.blueprint then
				local suits = { ['Any'] = 0, ['Clubs'] = 0, ['Diamonds'] = 0, ['Hearts'] = 0, ['Spades'] = 0 }
				for i = 1, #context.scoring_hand do
					if SMODS.has_any_suit(context.scoring_hand[i]) then suits["Any"] = suits["Any"] + 1
					elseif context.scoring_hand[i]:is_suit('Clubs', true) and suits["Clubs"] == 0 then suits["Clubs"] = 1
					elseif context.scoring_hand[i]:is_suit('Diamonds', true) and suits["Diamonds"] == 0 then suits["Diamonds"] = 1
					elseif context.scoring_hand[i]:is_suit('Hearts', true) and suits["Hearts"] == 0 then suits["Hearts"] = 1
					elseif context.scoring_hand[i]:is_suit('Spades', true) and suits["Spades"] == 0 then suits["Spades"] = 1
					end
				end
				if suits["Any"] + suits["Clubs"] + suits["Diamonds"] + suits["Hearts"] + suits["Spades"] >= 4 then
					card.ability.extra.Xchip = card.ability.extra.Xchip + card.ability.extra.Xchip_gain
					card_eval_status_text(card, 'extra', nil, nil, nil, {
						message = localize('k_upgrade_ex'),
						colour = G.C.GREEN
					})
				end
			end
			return { xchips = card.ability.extra.Xchip }
		end
    end
}
