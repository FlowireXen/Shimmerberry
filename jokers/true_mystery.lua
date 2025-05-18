SMODS.Joker {
	key = "true_mystery",
	name = "SEMBY_true_mystery",
	rarity = 2,
	cost = 2,
	atlas = "SEMBY_jokers",
	pos = { x = 7, y = 0 },
	blueprint_compat = false,
	eternal_compat = false,
    config = { extra = { odds = 2, legends = 11 } }, -- 1 in (2*joker_limit) chance to trigger
    add_to_deck = function(self, card, from_debuff)
		-- Play "Animation"
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			func = function()
				card:juice_up()
				play_sound('gold_seal')
				return true
			end
		}))
		-- Mystery Info...
		card_eval_status_text(card, 'extra', nil, nil, nil, {message = '?', colour = G.C.WHITE})
    end,
	calculate = function(self, card, context)
		if not context.blueprint and not self.getting_sliced then
			if context.starting_shop or context.reroll_shop or context.ending_shop or context.using_consumeable or
			   context.setting_blind or (context.joker_main and context.cardarea == G.jokers) or (context.end_of_round and context.cardarea == G.jokers)
			then
				if pseudorandom('true_mystery') < G.GAME.probabilities.normal / (card.ability.extra.odds * G.jokers.config.card_limit) then
					-- Decrease Counter...
					card.ability.extra.legends = card.ability.extra.legends - 1
					-- Play "Animation"
					G.E_MANAGER:add_event(Event({
						trigger = 'after',
						func = function()
							if card.ability.extra.legends > 0 then
								card:juice_up()
								play_sound('gold_seal')
							else
								play_sound('foil2') -- or "paper1"
							end
							return true
						end
					}))
					-- Mystery Info...
					if card.ability.extra.legends > 0 then
						card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('SEMBY_eval_true_mystery_huh'), colour = G.C.WHITE})
					else
						card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('SEMBY_eval_true_mystery_woa'), colour = G.C.PURPLE})
					end
				end
			end
			if context.selling_self then
				G.GAME.joker_buffer = G.GAME.joker_buffer + 1
				G.E_MANAGER:add_event(Event({
					func = function()
						-- In memory of Screw'd
						local screwd = nil
						if card.ability.extra.legends > 0 then
							screwd = create_card('Joker', G.jokers, nil, nil, nil, nil, nil, 'screwd') -- random (common, uncommon, rare...)
						else
							screwd = create_card('Joker', G.jokers, true, nil, nil, nil, nil, 'screwd') -- legendary
						end
						screwd:set_edition('e_negative', true)
						screwd.sell_cost = to_big(0)
						screwd:add_to_deck()
						G.jokers:emplace(screwd)
						screwd:start_materialize()
						G.GAME.joker_buffer = G.GAME.joker_buffer - 1
						return true
					end
				}))
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					func = function()
						play_sound('tarot1')
						return true
					end
				}))
				return
			end
		end
	end
}
