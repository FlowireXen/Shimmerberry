SMODS.Back{
	key = "hopeless",
	name = "SEMBY_hopeless",
	atlas = "SEMBY_decks",
	pos = { x = 2, y = 0 },
	config = {
		extra = {
			slots = 1,			-- gain slots
			blinds = 4,			-- every X blinds
			ante_min = -2,		-- min. win-change
			ante_max = 6		-- max. win-change
		}
	},
	loc_vars = function(self, info_queue, back)
		--SEMBY_Queue_Artist(back, info_queue)
		return { vars = {
			self.config.extra.slots,
			G.GAME.SEMBY_hopeless_view and
				localize { type = 'variable', key = 'SEMBY_out_of', vars = {
					(G.GAME.SEMBY_hopeless_progress or 0),
					(G.GAME.SEMBY_hopeless_goal or self.config.extra.blinds)
				} }
			or self.config.extra.blinds
		} }
	end,
    apply = function(self)
		-- Activate "Hide Ante":
		G.GAME.SEMBY_hide_win_ante = true
		-- Track Progress:
		G.GAME.SEMBY_hopeless_progress = 0
		G.GAME.SEMBY_hopeless_goal = self.config.extra.blinds
		G.GAME.SEMBY_hopeless_view = true
		-- Actual Ante-Change
        G.E_MANAGER:add_event(Event({
            func = function()
				G.GAME.win_ante = math.floor(math.max(2, G.GAME.win_ante + pseudorandom(
					"SEMBY_hopeless_"..(G.GAME.pseudorandom.seed or G.SEED),
					self.config.extra.ante_min,
					self.config.extra.ante_max
				)))
                return true
            end
        }))
    end,
	calculate = function(self, back, context)
		if context.end_of_round and context.main_eval
		and context.game_over == false and G.GAME.blind.boss then
			G.GAME.SEMBY_hopeless_progress = G.GAME.SEMBY_hopeless_progress + 1
			if G.GAME.SEMBY_hopeless_progress >= (G.GAME.SEMBY_hopeless_goal or self.config.extra.blinds) then
				G.GAME.SEMBY_hopeless_progress = 0
				return {
					message = localize('SEMBY_joker_slot_plus'),
					colour = G.C.DARK_EDITION,
					G.E_MANAGER:add_event(Event({
						func = function()
							G.jokers:handle_card_limit(self.config.extra.slots)
							return true
						end
					}))
				}
			else
				return {
					message = localize { type = 'variable', key = 'SEMBY_out_of', vars = {
						G.GAME.SEMBY_hopeless_progress,
						(G.GAME.SEMBY_hopeless_goal or self.config.extra.blinds)
					} },
					colour = G.C.DARK_EDITION
				}
			end
		end
    end,
	unlocked = false,
	unlock_condition = {type = 'win_deck', deck = 'b_abandoned'},
}
