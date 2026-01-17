SMODS.Consumable {
    key = "order_shrine",
	name = "SEMBY_order_shrine",
    set = "Spectral",
	atlas = "SEMBY_consumables",
    pos = { x = 0, y = 0 },
    loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
		local main_challenge_info = nil
		if G.GAME.challenge then
			main_challenge_info = { {
				n = G.UIT.C,
				config = { align = "bm", minh = 0.2 },
				nodes = { { n = G.UIT.C, config = { ref_table = card, align = "m" },
					nodes = { { n = G.UIT.T, config = {
						text = localize('SEMBY_desc_challenge'),
						colour = G.C.UI.TEXT_INACTIVE, scale = 0.32 * 0.8
					} } }
				} }
			} }
		end
        local main_eternal_info = nil
		if G.jokers and #G.jokers.cards > 0 then
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i].ability.eternal then
					if not SMODS.is_eternal(card) then
						info_queue[#info_queue + 1] = { key = "eternal", set = "Other" }
					end
					main_eternal_info = { {
						n = G.UIT.C,
						config = { align = "bm", minh = 0.2 },
						nodes = { { n = G.UIT.C, config = { ref_table = card, align = "m" },
							nodes = { { n = G.UIT.T, config = {
								text = localize('SEMBY_desc_ignore_eternal'),
								colour = G.C.UI.TEXT_INACTIVE, scale = 0.32 * 0.8
							} } }
						} }
					} }
					break
				end
			end
		end
		return {
			main_start = main_challenge_info,
			main_end = main_eternal_info
		}
    end,
    use = function(self, card, area, copier)
        -- Card Selection
        local selected_card = pseudorandom_element(G.jokers.cards, 'SEMBY_order_shrine')
        -- Change Logic
        for i = 1, #G.jokers.cards do
            local percent = 1.15 - (i - 0.999) / (#G.jokers.cards - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.15,
				func = function()
					G.jokers.cards[i]:flip()
					play_sound('card1', percent)
					G.jokers.cards[i]:juice_up(0.3, 0.3)
					return true
				end
			}))
		end
        delay(0.2)
        for i = 1, #G.jokers.cards do
            local percent = 1.05 - (i - 0.999) / (#G.jokers.cards - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.15,
				func = function()
					-- Actual Logic
					if G.jokers.cards[i] ~= selected_card then
						if not G.jokers.cards[i].ability.SEMBY_OI then -- "Order Immune"
							-- copy_card(selected_card, G.jokers.cards[i], nil, nil, nil)
							G.jokers.cards[i]:set_ability(selected_card.config.center)
							G.jokers.cards[i].ability.type = selected_card.ability.type
							G.jokers.cards[i]:set_base(selected_card.config.card)
						end
					end
					-- Flair
					play_sound('paper1', percent, 0.6)
					G.jokers.cards[i]:juice_up(0.3, 0.3)
					return true
				end
			}))
		end
        delay(0.2)
        for i = 1, #G.jokers.cards do
            local percent = 0.80 + (i - 0.999) / (#G.jokers.cards - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.15,
				func = function()
					G.jokers.cards[i]:flip()
					play_sound('tarot2', percent, 0.6)
					G.jokers.cards[i]:juice_up(0.3, 0.3)
					return true
				end
			}))
		end
        delay(0.2)
    end,
    can_use = function(self, card)
        return G.jokers and #G.jokers.cards > 1
    end
}
