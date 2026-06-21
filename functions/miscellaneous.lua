--## SEMBY Miscellaneous Functions

-- Input into Valid Number:
function SEMBY_tonum(input)
    local inum = tonumber(input)
    if not inum then
        input = input:gsub("O", "0")
        inum = tonumber(input)
    end
    return inum or 0
end

-- Count Suits in list
function SEMBY_count_suits(cards)
	local ret_val = 0
	local suit_map = { }
	for i = 1, #cards do
		if SMODS.has_any_suit(cards[i]) then
			ret_val = ret_val + 1
		elseif not SMODS.has_no_suit(cards[i]) then
			for suit,_ in pairs(SMODS.Suits) do
				if not suit_map[suit] and cards[i]:is_suit(suit) then
					ret_val = ret_val + 1
					suit_map[suit] = true
					break
				end
			end
		end
	end
    return ret_val
end

-- Get Vintage Hand
function SEMBY_vintage_hand(check_name)
	-- Get Highest Hand Level
	local eqbalance, vintage_level = 0, next(G.GAME.hands).level or 1
    for handname, _ in pairs(G.GAME.hands) do
		eqbalance = eqbalance ~= 0 and (eqbalance + G.GAME.hands[handname].level)/2 or G.GAME.hands[handname].level
        if SMODS.is_poker_hand_visible(handname) and G.GAME.hands[handname].level > vintage_level then
			vintage_level = G.GAME.hands[handname].level
		end
    end
	-- All Levels are the same; Allow Vintage
	vintage_level = vintage_level + (vintage_level == eqbalance and 1 or 0)
	-- Is checked hand vintage?
	local vintage_check = check_name and G.GAME.hands[check_name] and G.GAME.hands[check_name].level < vintage_level
	-- Return Vintage info
	return vintage_level, vintage_check
end

-- Semby Global Revive-Function; Also known as the "Pray that the Timings aren't wrong"-Function
function SEMBY_revive_list(rev_list, rev_source, rev_type)
    local revives = {}
    if rev_source and rev_list and #rev_list ~= 0 then
        if rev_type == "chrono_break" then
	    	for i = 1, #rev_list do
                if not rev_list[i].SEMBY_chronos then
                    if rev_list[i].glass_trigger
                    or rev_list[i].shattered
                    --or SMODS.has_enhancement(rev_list[i], 'm_glass')
                    or SMODS.shatters(rev_list[i])
                    then
	                    G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                        revives[#revives+1] = copy_card(rev_list[i], nil, nil, G.playing_card)
                        rev_list[i].SEMBY_chronos = true
                    end
                end
	    	end
        elseif rev_type == "tempered_glass" then
            local numerator = rev_source and rev_source.ability.extra.numerator or 1
            local denominator = rev_source and rev_source.ability.extra.denominator or 2
	    	for i = 1, #rev_list do
                if not rev_list[i].SEMBY_chronos then
                    if SMODS.has_enhancement(rev_list[i], 'm_glass')
                    and SMODS.pseudorandom_probability(rev_source, 'SEMBY_tempered_glass', numerator, denominator, nil, true)
                    then
	                    G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                        revives[#revives+1] = copy_card(rev_list[i], nil, nil, G.playing_card)
                        rev_list[i].SEMBY_chronos = true
                    end
                end
	    	end
        else -- Everything:
	    	for i = 1, #rev_list do
                G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                revives[#revives+1] = copy_card(rev_list[i], nil, nil, G.playing_card)
	    	end
        end
    end
    if #revives ~= 0 then
        local offset = 0
        local delay = 0.4
	    for i = 1, #revives do
            -- Add to Deck
	        revives[i]:add_to_deck()
            G.deck.config.card_limit = G.deck.config.card_limit + 1
            table.insert(G.playing_cards, revives[i])
            revives[i].states.visible = nil
            -- Position
            revives[i].T.x = rev_source.T.x
            revives[i].T.y = rev_source.T.y + (offset % 3) + 0.5
            offset = offset + 0.5
            -- Animate
	        G.E_MANAGER:add_event(Event({
			    trigger = 'after',
			    delay = delay,
	        	func = function()
	                revives[i]:SEMBY_revive_animation()
		            G.GAME.blind:debuff_card(revives[i])
                    if rev_source then rev_source:juice_up() end
					-- Show but don't allow Moving:
					revives[i].states.click.can = false
					revives[i].states.drag.can = false
					revives[i].states.focus.can = false
	        		return true
	        	end
	        }))
            -- Move to Deck
		    G.E_MANAGER:add_event(Event({
		    	trigger = 'after',
		    	delay = 0.4 + delay,
				blocking = false,
		    	func = function()
		            play_sound('cardSlide1', math.random()*0.2 + 0.9, 0.8)
                    -- Allow moving again:
					revives[i].states.click.can = true
					revives[i].states.drag.can = true
					revives[i].states.focus.can = true
		    		G.deck:emplace(revives[i])
		    		return true
		    	end
		    }))
            delay = math.max(0.1, delay - 0.02)
	    end
	    G.E_MANAGER:add_event(Event({
		    trigger = 'after',
		    delay = 1.0,
	    	func = function()
		        G.deck:shuffle()
	    		SMODS.calculate_context({ playing_card_added = true, cards = revives })
	    		return true
	    	end
	    }))
    end
end

-- Updates Blind-Select View (if possible)
function SEMBY_Update_Blind_Select(skip_anim)
	if G.blind_select and not G.SEMBY_anim_buffer then
		stop_use()
		if skip_anim then
			-- Remove Components
			G.blind_prompt_box:remove()
			G.blind_select:remove()
			G.blind_select = nil
		else
			G.SEMBY_anim_buffer = true
			-- Move/Hide Components
			G.E_MANAGER:add_event(Event({
				trigger = 'before',
				delay = 0.2,
				func = function()
					G.blind_prompt_box.alignment.offset.y = -10
					G.blind_select.alignment.offset.y = 40
					G.blind_select.alignment.offset.x = 0
					return true
				end
			}))
			-- Remove Components
			G.E_MANAGER:add_event(Event({
				trigger = 'immediate',
				func = function()
					G.SEMBY_anim_buffer = nil
					G.blind_prompt_box:remove()
					G.blind_select:remove()
					G.blind_select = nil
					delay(0.2)
					return true
				end
			}))
		end
		-- Rebuild Components
		G.STATE_COMPLETE = false
		G:update_blind_select(0)
	end
end
