CardSleeves.Sleeve {
    key = "burning_sl",
	SEMBY_art = "flowire",
    atlas = "SEMBY_sleeves",
    pos = { x = 3, y = 0 },
    calculate = function(self, sleeve, context)
        if context.destroy_card and context.destroy_card == context.scoring_hand[1] then
            -- Message doesn't take up any time:
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				blocking = false,
				func = function()
					context.scoring_hand[1]:juice_up(0.15)
                    G.deck:juice_up(0.1)
					play_sound('generic1', 1.2, 0.5)
					attention_text({
						text = localize('SEMBY_burn'),
						backdrop_colour = G.C.RED,
						scale = 0.8,
						hold = 1.0,
						major = G.deck,
						align = 'tm',
						offset = { x = 0, y = -0.5 }
					})
					return true
				end
			}))
            return {
                remove = true
            }
        end
    end,
    unlocked = false,
    unlock_condition = { deck = "b_SEMBY_scartare", stake = "stake_purple" },
}
