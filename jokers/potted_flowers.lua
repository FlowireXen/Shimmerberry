SMODS.Joker {
	key = "potted_flowers",
	loc_txt = {
		name = "Potted Flowers",
		text = {
            "Gains {X:chips,C:white}X#1#{} Chips if",
            "poker hand contains a",
            "{C:diamonds}Diamond{} card, {C:clubs}Club{} card,",
            "{C:hearts}Heart{} card, and {C:spades}Spade{} card",
			"{C:inactive}(Currently {}{X:chips,C:white}X#2#{}{C:inactive} Chips){}"
		}
	},
	rarity = 2,
	cost = 6,
	atlas = "SEMBY_jokers",
	pos = { x = 3, y = 1 },
	blueprint_compat = true,
    config = { Xchip_gain = 0.15, Xchip = 1.0 },
	loc_vars = function(self, _info, card)
		return { vars = { card.ability.Xchip_gain, card.ability.Xchip } }
    end,
	calculate = function(self, card, context)
        if context.cardarea == G.jokers then
            if context.joker_main then
				if not context.blueprint then
					local suits = { ['Hearts'] = 0, ['Diamonds'] = 0, ['Spades'] = 0, ['Clubs'] = 0 }
					for i = 1, #context.scoring_hand do
						if context.scoring_hand[i].ability.name ~= 'Wild Card' then
							if context.scoring_hand[i]:is_suit('Hearts', true) and suits["Hearts"] == 0 then suits["Hearts"] = suits["Hearts"] + 1
							elseif context.scoring_hand[i]:is_suit('Diamonds', true) and suits["Diamonds"] == 0  then suits["Diamonds"] = suits["Diamonds"] + 1
							elseif context.scoring_hand[i]:is_suit('Spades', true) and suits["Spades"] == 0  then suits["Spades"] = suits["Spades"] + 1
							elseif context.scoring_hand[i]:is_suit('Clubs', true) and suits["Clubs"] == 0  then suits["Clubs"] = suits["Clubs"] + 1 end
						end
					end
					for i = 1, #context.scoring_hand do
						if context.scoring_hand[i].ability.name == 'Wild Card' then
							if context.scoring_hand[i]:is_suit('Hearts') and suits["Hearts"] == 0 then suits["Hearts"] = suits["Hearts"] + 1
							elseif context.scoring_hand[i]:is_suit('Diamonds') and suits["Diamonds"] == 0  then suits["Diamonds"] = suits["Diamonds"] + 1
							elseif context.scoring_hand[i]:is_suit('Spades') and suits["Spades"] == 0  then suits["Spades"] = suits["Spades"] + 1
							elseif context.scoring_hand[i]:is_suit('Clubs') and suits["Clubs"] == 0  then suits["Clubs"] = suits["Clubs"] + 1 end
						end
					end
					if suits["Hearts"] > 0 and suits["Diamonds"] > 0 and suits["Spades"] > 0 and suits["Clubs"] > 0 then
						card.ability.Xchip = card.ability.Xchip + card.ability.Xchip_gain
						card_eval_status_text(card, 'extra', nil, nil, nil, { message = localize('k_upgrade_ex'), colour = G.C.BLUE })
					end
				end
				return { xchips = card.ability.Xchip }
			end
        end
    end
}
