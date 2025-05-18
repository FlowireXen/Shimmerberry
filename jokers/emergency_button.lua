SMODS.Joker {
	key = "emergency_button",
	name = "SEMBY_emergency_button",
	config = { emergency_meeting = false },
	atlas = "SEMBY_jokers",
	pos = { x = 2, y = 0 },
	rarity = 2,
	blueprint_compat = false,
    eternal_compat = false,
	cost = 6,
	calculate = function(self, card, context)
		if context.game_over and not context.blueprint then
			---- Early Exit Condition
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i].ability.emergency_meeting then
					return --{ message = localize('SEMBY_eval_emergency_button'), colour = G.C.ATTENTION }
				end
			end
			card.ability.emergency_meeting = true -- prep early exit for other copies...
			---- Jokers (Info Gathering)
            local num_jokers = 0
			local num_joker_negatives = 0
            local num_legends = 0
			local num_legend_negatives = 0
            local local_jokers = G.jokers.cards
            for k, v in pairs(local_jokers) do
				if not v.ability.eternal then
					if v.config.center.rarity == 4 then
						num_legends = num_legends + 1
						if v.edition and v.edition.key == 'e_negative' then
							num_legend_negatives = num_legend_negatives + 1
						end
					else
						num_jokers = num_jokers + 1
						if v.edition and v.edition.key == 'e_negative' then
							num_joker_negatives = num_joker_negatives + 1
						end
					end
				end
            end
			---- Consumables (Info Gathering)
            local num_consumables = 0
			local num_consumable_negatives = 0
            local local_consumables = G.consumeables.cards
            for k, v in pairs(local_consumables) do
				num_consumables = num_consumables + 1
				if v.edition and v.edition.key == 'e_negative' then
					num_consumable_negatives = num_consumable_negatives + 1
				end
            end
			---- Event After Info-Gathering;
			G.E_MANAGER:add_event(Event({
				trigger = 'before',
				func = function()
					---- Jokers (Deletion)
					for k, v in pairs(local_jokers) do
						if not v.ability.eternal then
							v:start_dissolve()
							--v:remove()
						end
					end
					---- Consumables (Deletion)
					for k, v in pairs(local_consumables) do
						v:start_dissolve()
						--v:remove()
					end
					---- Event After Deletion;
					G.E_MANAGER:add_event(Event({
						delay = 1.0,
						func = function()
							---- Jokers (Generation)
							for i = 1, num_jokers do
								local card = create_card('Joker', G.jokers, nil, nil, nil, nil, nil, 'emergency_meeting')
								if num_joker_negatives > 0 then
									card:set_edition('e_negative', true)
									num_joker_negatives = num_joker_negatives - 1
								end
								card:add_to_deck()
								G.jokers:emplace(card)
							end
							for i = 1, num_legends do
								local card = create_card('Joker', G.jokers, true, nil, nil, nil, nil, 'emergency_meeting')
								if num_legend_negatives > 0 then
									card:set_edition('e_negative', true)
									num_legend_negatives = num_legend_negatives - 1
								end
								card:add_to_deck()
								G.jokers:emplace(card)
							end
							---- Consumables (Generation)
							for i = 1, num_consumables do
								local card = create_card('Consumeables', G.consumeables, nil, nil, nil, nil, nil, 'emergency_meeting')
								if num_consumable_negatives > 0 then
									card:set_edition('e_negative', true)
									num_consumable_negatives = num_consumable_negatives - 1
								end
								card:add_to_deck()
								G.consumeables:emplace(card)
							end
							return true
						end
					}))
					return true
				end
			}))
			---- Finale (Everything Done!)
        	G.E_MANAGER:add_event(Event({
				func = function()
					G.hand_text_area.blind_chips:juice_up()
					G.hand_text_area.game_chips:juice_up()
					return true
				end
			}))
			return {
				message = localize('SEMBY_eval_emergency_button'),
				saved = 'SEMBY_eval_emergency_button', --localize('SEMBY_eval_emergency_button'),
				colour = G.C.ATTENTION
			}
        end
	end
}
