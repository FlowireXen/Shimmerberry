CardSleeves.Sleeve {
    key = "scartare_sl",
	name = "SEMBY_scartare_sl",
    atlas = "SEMBY_sleeves",
    pos = { x = 0, y = 0 },
	config = {
		extra = {
			discard_mod = 3,    -- remove discards
			discard_limit = 3,	-- remove discardable amount
			bonus_limit = 2,    -- add if "deck + sleeve"
			hand_size = 2,      -- add hand size
			min_id = 7,         -- remove card-id below
			discards = 2        -- visuals for menu
		}
	},
    loc_vars = function(self)
		--SEMBY_Queue_Artist(self, info_queue)
        if self.get_current_deck_key() == "b_SEMBY_scartare" then
			return { key = "sleeve_SEMBY_scartare_sl_alt", vars = {
				self.config.extra.bonus_limit,
				self.config.extra.bonus_limit
			} }
        else
			return { vars = {
				self.config.extra.min_id,
				self.config.extra.hand_size,
				self.config.extra.discard_mod,
				G.GAME.SEMBY_scartare_view and G.GAME.starting_params.discard_limit or self.config.extra.discards
			} }
        end
    end,
    apply = function(self)
		if self.get_current_deck_key() == "b_SEMBY_scartare" then
			-- Discard Limit Bonus: +2
        	G.E_MANAGER:add_event(Event({
        	    func = function()
					SMODS.change_discard_limit(self.config.extra.bonus_limit)
					return true
        	    end
        	}))
			-- Hand Size Bonus: +2
			G.GAME.starting_params.hand_size = G.GAME.starting_params.hand_size + self.config.extra.bonus_limit
		else -- Any other Deck:
			SMODS.Back.obj_table["b_SEMBY_scartare"].apply(self)
		end
    end,
    calculate = function(self, sleeve, context)
        if context.after and not (self.get_current_deck_key() == "b_SEMBY_scartare") then
			SEMBY_Scartare()
        end
    end,
    unlocked = false,
    unlock_condition = { deck = "b_SEMBY_scartare", stake = "stake_green" },
}
