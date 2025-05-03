CardSleeves.Sleeve {
    key = 'skat_sleeve',
    unlocked = false,
    unlock_condition = { deck = "b_SEMBY_skat", stake = "stake_green" },
    atlas = 'shimmer_sleeves',
    pos = { x = 0, y = 0 },
    loc_vars = function(self)
		local key
		local vars
        if self.get_current_deck_key() == "b_SEMBY_skat" then
			vars = { 
				self.config.start.bonus_discards, -- loc-file is singular
				self.config.extra.discards
			}
            key = "skat_sleeve_alt"
        else
			vars = { 
				self.config.start.min_inclusive_id,
				self.config.start.max_exclusive_id,
				self.config.start.hand_size,
				self.config.start.discards,
				self.config.extra.discards
			}
            key = "skat_sleeve"
        end
        return { key = key, vars = vars }
    end,
	config = {
		start = {
			hand_size = 2, -- add
			discards = 3,  -- remove
			bonus_discards = 1,  -- add
			min_inclusive_id = 2, -- remove and above
			max_exclusive_id = 7  -- remove below
		},
		extra = {
			discards = 2
		}
	},
    apply = function(self)
		if self.get_current_deck_key() == "b_SEMBY_skat" then
			-- DISCARDS EACH ROUND: +1
			G.GAME.starting_params.discards = G.GAME.starting_params.discards + self.config.start.bonus_discards
		else
			-- DISCARDS EACH ROUND: -3
			local failsafe = G.GAME.starting_params.discards - self.config.start.discards
			if failsafe < 0 then
				failsafe = 0
			end
			G.GAME.starting_params.discards = failsafe
			-- HAND SIZE: +2
			G.GAME.starting_params.hand_size = G.GAME.starting_params.hand_size + self.config.start.hand_size
			-- MODIFY DECK: remove all "2 up to 7"
			G.E_MANAGER:add_event(Event({
				func = function()
					for i = #G.playing_cards, 1, -1 do
						if G.playing_cards[i]:get_id() >= self.config.start.min_inclusive_id
						and G.playing_cards[i]:get_id() < self.config.start.max_exclusive_id
						then G.playing_cards[i]:start_dissolve(nil, true) end
					end
					G.E_MANAGER:add_event(Event({
						func = function()
							G.GAME.starting_deck_size = #G.playing_cards
							return true
						end
					}))
					return true
				end
			}))
		end
    end,
	calculate = function(self, back, context)
        if context.after then
			-- ((Based on "The Hook"'s Function!))
			G.E_MANAGER:add_event(Event({
				func = function()
					local any_selected = nil
					local _cards = {}
					for k, v in ipairs(G.hand.cards) do
						_cards[#_cards+1] = v
					end
					local _highlighted = {}
					for k, v in ipairs(G.hand.highlighted) do
						_highlighted[#_highlighted+1] = v
					end
					if _highlighted and #_highlighted > 0 then
						for i = 1, #_highlighted do
							for j = 1, #_cards do
								if _cards[j] == _highlighted[i] then
									table.remove(_cards, j)
									break
								end
							end
						end
					end
					local _selected = {}
					for i = 1, self.config.extra.discards do
						local selected_card, card_key = pseudorandom_element(_cards, pseudoseed('skat_sleeve'))
						_selected[#_selected+1] = selected_card
						table.remove(_cards, card_key)
						any_selected = true
					end
					if any_selected then
						--# Check my Deck-Code on why I'm doing all this.
						-- safety: unselect prev. highlighted
						for i = 1, #_highlighted do
							G.hand:remove_from_highlighted(_highlighted[i], true)
						end
						-- now, highlight my discards
						for i = 1, #_selected do
							G.hand:add_to_highlighted(_selected[i], true)
						end
						-- discard selected cards
						-- THIS GOD FORSAKEN FUNCTION HAS COSTED ME ***SO*** MUCH FFFUCKING TIME
						G.FUNCS.discard_cards_from_highlighted(nil, true)
						-- safety: re-select prev.
						for i = 1, #_highlighted do
							G.hand:add_to_highlighted(_highlighted[i], true)
						end
						-- *don't* unselect my newly selected, that breaks the "discard_cards_from_highlighted" function
					end
					return true
				end
			}))
			--return true
        end
    end
}
