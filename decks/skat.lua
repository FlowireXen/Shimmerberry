SMODS.Back{
	key = "skat",
	loc_txt = {
		name = "Skat Deck",
		text={
			"{C:inactive,s:0.75}Skat decks only have {}{C:blue,s:0.75}32{}{C:inactive,s:0.75} cards!{}",
			"Start with {C:attention}#1#{} hand size",
			"and {C:red}#2#{} discards",
			"Discard {C:red}#3#{} random cards",
			"with each hand played"
		},
	},
	config = {
		start = {
			hand_size = 10, -- set
			discards = 0,   -- set
			min_id = 7,     -- remove below
			buff_id = 11    -- buff: jacks
		},
		extra = {
			discards = 2
		}
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { self.config.start.hand_size, self.config.start.discards, self.config.extra.discards } }
	end,
	unlocked = true,
    discovered = true,
	atlas = "shimmer_decks",
	pos = { x = 0, y = 0 },
    apply = function(self)
		-- DISCARDS EACH ROUND: set to 0
        G.GAME.starting_params.discards = self.config.start.discards
		-- HAND SIZE: set to 10
		G.GAME.starting_params.hand_size = self.config.start.hand_size
		-- MODIFY DECK: buff jacks, remove all below 7
        G.E_MANAGER:add_event(Event({
            func = function()
				for i = #G.playing_cards, 1, -1 do
					if G.playing_cards[i]:get_id() == self.config.start.buff_id then
						G.playing_cards[i]:set_ability(G.P_CENTERS.m_wild)
						G.playing_cards[i]:set_edition('e_foil', true)
					elseif G.playing_cards[i]:get_id() < self.config.start.min_id then
						--G.playing_cards[i]:remove()
						G.playing_cards[i]:start_dissolve(nil, true)
					end
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
						local selected_card, card_key = pseudorandom_element(_cards, pseudoseed('skat'))
						_selected[#_selected+1] = selected_card
						table.remove(_cards, card_key)
						any_selected = true
					end
					if any_selected then
						-- Okay, let me explain =>
						
						--# I go trough all already selected cards and unselect them
						for i = 1, #_highlighted do
							G.hand:remove_from_highlighted(_highlighted[i], true)
						end
						
						--# Then, I select two cards to Discard (much like "The Hook")
						for i = 1, #_selected do
							G.hand:add_to_highlighted(_selected[i], true)
						end
						
						--# I "Discard" all SELECTED cards
						--[ Remember this ]
						G.FUNCS.discard_cards_from_highlighted(nil, true)
						
						--# And then I re-select the previously selected
						for i = 1, #_highlighted do
							G.hand:add_to_highlighted(_highlighted[i], true)
						end
						
						--# Note: I'm not unselecting my newly selected cards (that leads to it's own set of issues)
						--[ This might have compatibility issues with other selection-based effects, but it works for now ]
						
						--# So, WHY am I doing all of this?
						--# The Function "G.FUNCS.discard_cards_from_highlighted" has a little quirk to it.
						--# If you call the function more than once, shit hits the fan;
						--# It Discards already discarded cards a second time (or more times depending on call amount)
						--# Which basically puts a second Reference-Copy into the Discard Pile
						--# At the end, it shuffles the discard-pile into your deck, then you can Draw said copies...
						--# Best case: They'll just sit there... Worst case, they'll start counting for scoring and softlock your game
						--# Eitherway: The run is now BRICKED.
						
						--# But surely, you would never call the function twice, right?
						--# Well, let me ask you this: What do you think my Card-Sleeve is doing? :)
						--# Or maybe another Mod adds a Joker that Discards cards with the same function... ¯\_(owo)_/¯
						
						--# Figuring this out was an asolute pain, I cannot recommend :')
					end
					return true
				end
			}))
			--return true
        end
    end
}
