CardSleeves.Sleeve {
    key = "burning_sl",
	name = "SEMBY_burning_sl",
    atlas = "SEMBY_sleeves",
    pos = { x = 3, y = 0 },
    --loc_vars = function(self) SEMBY_Queue_Artist(self, info_queue) end,
    calculate = function(self, sleeve, context)
		if context.setting_blind then
			-- Stop Player from Selecting any Cards
			for _, playing_card in ipairs(G.playing_cards) do
				playing_card.ability.SEMBY_click = playing_card.states.click.can
				playing_card.states.click.can = false
			end
		end
        if context.first_hand_drawn and G.GAME.blind.boss then
			delay(0.5)
			return {
				message = localize('SEMBY_burn'),
				colour = G.C.RED,
				func = function()
					local first_amount = 0
					for _, card in ipairs(G.hand.cards) do
						first_amount = first_amount + 1
						G.E_MANAGER:add_event(Event({
							trigger = 'after',
							delay = 0.2,
							func = function()
								if SMODS.shatters(card) then card:shatter()
								else card:start_dissolve() end
								return true
							end
						}))
					end
					G.E_MANAGER:add_event(Event({
						trigger = 'after',
						delay = 0.2,
						func = function()
							-- Make Cards Selectable again
							for _, playing_card in ipairs(G.playing_cards) do
								playing_card.states.click.can = (playing_card.ability.SEMBY_click or true)
								playing_card.ability.SEMBY_click = nil
							end
							SMODS.draw_cards(first_amount)
							return true
						end
					}))
				end
			}
		end
    end,
    unlocked = false,
    unlock_condition = { deck = "b_SEMBY_scartare", stake = "stake_purple" },
}
