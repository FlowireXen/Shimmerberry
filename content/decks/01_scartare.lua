SMODS.Back{
	key = "scartare",
	name = "SEMBY_scartare",
	atlas = "SEMBY_decks",
	pos = { x = 0, y = 0 },
	config = {
		extra = {
			discard_mod = 3,    -- remove discards
			discard_limit = 3,	-- remove discardable amount
			hand_size = 2,      -- add hand size
			min_id = 7,         -- remove card-id below
			discards = 2        -- visuals for menu
		}
	},
	loc_vars = function(self, info_queue, back)
		--SEMBY_Queue_Artist(back, info_queue)
		return { vars = {
			self.config.extra.min_id,
			self.config.extra.hand_size,
			self.config.extra.discard_mod,
			G.GAME.SEMBY_scartare_view and G.GAME.starting_params.discard_limit or self.config.extra.discards
		} }
	end,
    apply = function(self)
		-- Show Different Auto-Discard Amount:
		G.GAME.SEMBY_scartare_view = true
		-- Discards: -3
		G.GAME.starting_params.discards = math.max(0, G.GAME.starting_params.discards - self.config.extra.discard_mod)
		-- Discard Limit: -3
        G.E_MANAGER:add_event(Event({
            func = function()
				SMODS.change_discard_limit(-self.config.extra.discard_limit)
				return true
            end
        }))
		-- Hand Size: +2
		G.GAME.starting_params.hand_size = G.GAME.starting_params.hand_size + self.config.extra.hand_size
		-- Deck: Remove any below 7
        G.E_MANAGER:add_event(Event({
            func = function()
				for i = #G.playing_cards, 1, -1 do
					if G.playing_cards[i]:get_id() < self.config.extra.min_id then
						G.playing_cards[i]:remove()
					end
				end
				G.GAME.starting_deck_size = #G.playing_cards
                return true
            end
        }))
		-- Bans: Useless Tag
		G.GAME.banned_keys['tag_garbage'] = true
    end,
	calculate = function(self, back, context)
        if context.after then
			SEMBY_Scartare()
        end
    end,
	unlocked = false,
	unlock_condition = {type = 'win_deck', deck = 'b_red'},
}

function SEMBY_Scartare()
	-- "The Hook 2.0"
	G.E_MANAGER:add_event(Event({
		func = function()
			-- Vars
			local cards = {}
			local highlighted = {}
			local selected = {} --> Technically not needed.
			-- Get all Highlighted Cards
			for _, card in ipairs(G.hand.highlighted) do
				highlighted[#highlighted+1] = card
			end
			-- Get all Non-Highlighted Cards
			if #highlighted ~= 0 then
				for _, card in ipairs(G.hand.cards) do
					local valid = true
					for i = 1, #highlighted do
						if card == highlighted[i] then
							valid = false
							break
						end
					end
					if valid then cards[#cards+1] = v end
				end
			else
				for _, card in ipairs(G.hand.cards) do
					cards[#cards+1] = card
				end
			end
			-- Select Cards to Discard
			for i = 1, (G.GAME.starting_params.discard_limit or 0) do
				local selected_card, card_key = pseudorandom_element(cards, pseudoseed('SEMBY_scartare'))
				selected[#selected+1] = selected_card
				table.remove(cards, card_key)
			end
			-- Discard
			if #selected ~= 0 then
				-- Un-Highlight currently Highlighted
				for i = 1, #highlighted do
					G.hand:remove_from_highlighted(highlighted[i], true)
				end
				-- Highlight all Selected
				for i = 1, #selected do
					G.hand:add_to_highlighted(selected[i], true)
				end
				-- Discard (currently Highlighted)
				G.FUNCS.discard_cards_from_highlighted(nil, true)
				-- Re-Highlight previously Highlighted
				for i = 1, #highlighted do
					G.hand:add_to_highlighted(highlighted[i], true)
				end
			end
			return true
		end
	}))
end
