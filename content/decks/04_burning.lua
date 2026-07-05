local function SEMBY_Announce(card)
	G.E_MANAGER:add_event(Event({
		trigger = 'after',
		blocking = false,
		func = function()
			card:juice_up(0.15, 0.2)
			play_sound('generic1', 0.8+math.random()*0.4)
			attention_text({
				text = localize('SEMBY_burn_'..math.random(1, 9)),
				backdrop_colour = G.C.RED,
				scale = 0.75, hold = 1.0,
				major = card, align = 'tm',
				offset = { x = 0, y = 0 }
			})
			return true
		end
	}))
end
SMODS.Back{
	key = "burning",
	SEMBY_art = "flowire",
	atlas = "SEMBY_decks",
	pos = { x = 3, y = 0 },
    calculate = function(self, sleeve, context)
        if context.destroy_card and context.destroy_card == context.scoring_hand[1] then
			SEMBY_Announce(context.scoring_hand[1] or G.deck)
            return { remove = true }
        end
    end,
	unlocked = false,
	unlock_condition = { type = 'win_deck', deck = 'b_plasma' },
}
if Shimmerberry.compat.sleeves then CardSleeves.Sleeve {
    key = "burning_sl",
	SEMBY_art = "flowire",
    atlas = "SEMBY_sleeves",
    pos = { x = 3, y = 0 },
    loc_vars = function(self)
		return { key = self.get_current_deck_key() == "b_SEMBY_burning" and "sleeve_SEMBY_burning_sl_alt" or nil }
    end,
    calculate = function(self, sleeve, context)
		if (self.get_current_deck_key() == "b_SEMBY_burning") then
			if context.pre_discard and not context.hook then
				--context.full_hand[1].SEMBY_removed = 'Burned'
				-- "Hitman" Support:
				for i = 1, #context.full_hand do
					if not context.full_hand[i].SEMBY_removed then
						context.full_hand[i].SEMBY_removed = 'Burned'
						break
					end
				end
			end
			if context.discard and context.other_card.SEMBY_removed
			and context.other_card.SEMBY_removed == 'Burned' then
				SEMBY_Announce(context.other_card or G.deck)
				return { remove = true }
			end
		else
			return SMODS.Back.obj_table["b_SEMBY_burning"].calculate(self, sleeve, context)
		end
    end,
    unlocked = false,
    unlock_condition = { deck = "b_SEMBY_burning", stake = "stake_purple" },
} end
