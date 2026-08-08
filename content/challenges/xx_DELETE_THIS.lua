SMODS.Challenge {
    key = 'SEMBY_DELETE_THIS',
    rules = {
        custom = {
            { id = 'SEMBY_DELETE_THIS_'..math.random(1, 5) },
            { id = 'SEMBY_DELETE_THIS_'..math.random(1, 5) },
            { id = 'SEMBY_space' },
            { id = 'SEMBY_DELETE_THIS_'..math.random(1, 5) },
            { id = 'SEMBY_DELETE_THIS_'..math.random(1, 5) },
            { id = 'SEMBY_DELETE_THIS_'..math.random(1, 5) },
        },
        modifiers = {
            { id = 'dollars', value = 20 },
			{ id = 'winning_ante', value = localize('k_nope_ex') },
        }
    },
    restrictions = {
        banned_cards = {
            { id = 'j_SEMBY_TMTRAINER' },
            { id = 'j_SEMBY_DATAMINER' },
            { id = 'j_SEMBY_TMTRAINER' },
        },
    },
    consumeables = {
        { id = 'j_SEMBY_TMTRAINER', eternal = true }, --!! Has to be manually moved
    },
    deck = {
        type = 'Challenge Deck',
        cards = { -- 100 Cards -- !!! HIGHLY UNSTABLE !!!
            { s = 'S', r = '0' }, { s = 'S', r = '0' }, { s = 'S', r = '0' }, { s = 'S', r = '0' }, { s = 'S', r = '0' },
            { s = 'S', r = '0' }, { s = 'S', r = '0' }, { s = 'S', r = '0' }, { s = 'S', r = '0' }, { s = 'S', r = '0' },
            { s = 'S', r = '0' }, { s = 'S', r = '0' }, { s = 'S', r = '0' }, { s = 'S', r = '0' }, { s = 'S', r = '0' },
            { s = 'S', r = '0' }, { s = 'S', r = '0' }, { s = 'S', r = '0' }, { s = 'S', r = '0' }, { s = 'S', r = '0' },
            { s = 'S', r = '0' }, { s = 'S', r = '0' }, { s = 'S', r = '0' }, { s = 'S', r = '0' }, { s = 'S', r = '0' },
            { s = 'H', r = '0' }, { s = 'H', r = '0' }, { s = 'H', r = '0' }, { s = 'H', r = '0' }, { s = 'H', r = '0' },
            { s = 'H', r = '0' }, { s = 'H', r = '0' }, { s = 'H', r = '0' }, { s = 'H', r = '0' }, { s = 'H', r = '0' },
            { s = 'H', r = '0' }, { s = 'H', r = '0' }, { s = 'H', r = '0' }, { s = 'H', r = '0' }, { s = 'H', r = '0' },
            { s = 'H', r = '0' }, { s = 'H', r = '0' }, { s = 'H', r = '0' }, { s = 'H', r = '0' }, { s = 'H', r = '0' },
            { s = 'H', r = '0' }, { s = 'H', r = '0' }, { s = 'H', r = '0' }, { s = 'H', r = '0' }, { s = 'H', r = '0' },
            { s = 'C', r = '0' }, { s = 'C', r = '0' }, { s = 'C', r = '0' }, { s = 'C', r = '0' }, { s = 'C', r = '0' },
            { s = 'C', r = '0' }, { s = 'C', r = '0' }, { s = 'C', r = '0' }, { s = 'C', r = '0' }, { s = 'C', r = '0' },
            { s = 'C', r = '0' }, { s = 'C', r = '0' }, { s = 'C', r = '0' }, { s = 'C', r = '0' }, { s = 'C', r = '0' },
            { s = 'C', r = '0' }, { s = 'C', r = '0' }, { s = 'C', r = '0' }, { s = 'C', r = '0' }, { s = 'C', r = '0' },
            { s = 'C', r = '0' }, { s = 'C', r = '0' }, { s = 'C', r = '0' }, { s = 'C', r = '0' }, { s = 'C', r = '0' },
            { s = 'D', r = '0' }, { s = 'D', r = '0' }, { s = 'D', r = '0' }, { s = 'D', r = '0' }, { s = 'D', r = '0' },
            { s = 'D', r = '0' }, { s = 'D', r = '0' }, { s = 'D', r = '0' }, { s = 'D', r = '0' }, { s = 'D', r = '0' },
            { s = 'D', r = '0' }, { s = 'D', r = '0' }, { s = 'D', r = '0' }, { s = 'D', r = '0' }, { s = 'D', r = '0' },
            { s = 'D', r = '0' }, { s = 'D', r = '0' }, { s = 'D', r = '0' }, { s = 'D', r = '0' }, { s = 'D', r = '0' },
            { s = 'D', r = '0' }, { s = 'D', r = '0' }, { s = 'D', r = '0' }, { s = 'D', r = '0' }, { s = 'D', r = '0' },
		}
    },
	apply = function(self)
        -- Apply Gold Stake
		SMODS.setup_stake(SMODS.Stakes["stake_gold"].order)
		G.GAME.stake = SMODS.Stakes["stake_gold"].order
        -- Hide Doom & Stats
        G.GAME.SEMBY_doomed = 0.0
        G.GAME.SEMBY_hide_doom = true
        -- Setup Challenge
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			func = function()
			    -- Add Area Overrides
			    G.jokers:SEMBY_add_text_override(0, (pseudorandom("SEMBY_DELETE_THIS") <= 0.75) and 'SEMBY_NaN' or 'SEMBY_QQQ')
			    G.consumeables:SEMBY_add_text_override(0, (pseudorandom("SEMBY_DELETE_THIS") <= 0.75) and 'SEMBY_NaN' or 'SEMBY_QQQ')
			    G.hand:SEMBY_add_text_override(0, (pseudorandom("SEMBY_DELETE_THIS") <= 0.5) and 'SEMBY_NaN' or 'SEMBY_QQQ')
			    G.deck:SEMBY_add_text_override(0, (pseudorandom("SEMBY_DELETE_THIS") <= 0.25) and 'SEMBY_NaN' or 'SEMBY_QQQ')
                -- Starting Stats Change (Static):
                G.jokers.config.card_limit = G.jokers.config.card_limit + 1
		        G.consumeables.config.card_limit = G.consumeables.config.card_limit + 1
                -- Starting Stats Change (Random):
		        G.hand.config.real_card_limit = pseudorandom("SEMBY_DELETE_THIS", 6, 12)
		        G.hand.config.card_limit = G.hand.config.real_card_limit
                -- Randomize Ranks in Deck (Once)
                local suit = pseudorandom_element(SMODS.Suits).key
                local rank = pseudorandom_element(SMODS.Ranks).key
		        for i = #G.playing_cards, 1, -1 do
                    if i % 5 == 0 then
                        suit = pseudorandom_element(SMODS.Suits).key
                        rank = pseudorandom_element(SMODS.Ranks).key
                    end
		        	assert(SMODS.change_base(G.playing_cards[i], suit, rank))
		        end
                -- Cheaper & Better Shops:
                SEMBY_Global_ShopMod_Add('DELETE_THIS', -0.2)
		        G.GAME.round_resets.reroll_cost = G.GAME.round_resets.reroll_cost - 2.0
                SMODS.change_booster_limit(1)
                -- Increased Challenge:
        	    SEMBY_Global_BlindMod_Add('DELETE_THIS', 0.25)
		        G.GAME.win_ante = 8 --> Says "Nope!" but it's 8 :3
                G.GAME.SEMBY_no_win_ante = nil
				-- Change TMTRAINER:
		        G.E_MANAGER:add_event(Event({
		        	func = function()
                        local joker = G.jokers.cards[1]
                        -- Modify Joker:
		        		joker.ability.extra.SEMBY_TMTR = "RNG"
		        		joker.ability.extra.SEMBY_TMTR_MIN = 2.00
		        		joker.ability.extra.SEMBY_TMTR_MAX = 4.00
                        joker.ability.SEMBY_tmtrainer_value = '???'
		        		joker.ability.extra.corrupt = true
		        		joker.children.center:set_sprite_pos({ x = 9, y = 2 })
                        -- Move Joker to Area: "G.consumeable"
		        		joker.area:remove_card(joker)
		        		joker:add_to_deck()
		        		G.consumeables:emplace(joker)
		        		save_run()
		        		return true
		        	end
		        }))
				return true
			end
		}))
        -- Custom Death Reason (Imitate Fallback):
        G.GAME.SEMBY_defeated = {
            atlas = "SEMBY_jokers_1",
            position = { x = 0, y = 0 },
            loc_key = 'SEMBY_lose_xx_DELETE',
            color = HEX('FF00FF')
        }
	end,
    calculate = function(self, context)
        -- Skipping = 1/2 Chance for a "Double Tag"
        if (context.skip_blind or context.skipping_booster) and pseudorandom("SEMBY_DELETE_THIS") <= 0.5 then
			add_tag(Tag('tag_double'))
			return { message = localize{ type = 'variable', key = 'SEMBY_plus', vars = { '2' } }, colour = G.C.GREEN }
        end
        -- Each Reroll generates another Booster
        if context.reroll_shop then
            G.GAME.SEMBY_booster_bonus = (G.GAME.SEMBY_booster_bonus or 0) + 1
            SMODS.change_booster_limit(1)
        end
        if context.ending_shop then
            SMODS.change_booster_limit(-(G.GAME.SEMBY_booster_bonus or 0))
        end
        -- ~1/3 Chance to duplicate used Consumables
        if context.using_consumeable and pseudorandom("SEMBY_DELETE_THIS") <= 0.33 then
			local consumeable = context.consumeable
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.2,
				func = function()
					local echo = copy_card(consumeable, nil, nil, nil, nil)
					echo:add_to_deck()
					echo:start_materialize({{1, 1, 1, 1}, {0.8, 0.8, 0.8, 0.8}}, true, 0.5)
					G.consumeables:emplace(echo)
					play_sound('tarot'..math.random(1, 2), math.random() + 0.8, 0.5)
					return true;
				end
			}))
        end
        -- 1/4 Chance to gain/remove one Joker Slot (After getting/selling a Joker)
		if context.card_added and context.card.ability.set == "Joker" and pseudorandom("SEMBY_DELETE_THIS") <= 0.25 then
            G.jokers.config.card_limit = G.jokers.config.card_limit + 1
        end
        if context.selling_card and context.card.ability.set == "Joker" and pseudorandom("SEMBY_DELETE_THIS") <= 0.25 then
            G.jokers.config.card_limit = G.jokers.config.card_limit - 1
        end
        -- 1/4 Chance to NOT change Ante:
        if context.modify_ante and pseudorandom("SEMBY_DELETE_THIS") <= 0.25 then
			return { message = localize('k_nope_ex'), colour = G.C.RED, modify = 0 }
        end
        -- Increase Challenge Stats for each Boss Blind defeated
		if context.end_of_round and context.main_eval and context.game_over == false and G.GAME.blind.boss then
            -- Stat Change
            SEMBY_Global_ShopMod_Add('DELETE_THIS', -0.05)
            SEMBY_Global_BlindMod_Add('DELETE_THIS', 0.25)
            -- Hide Doom until first Blind defeated
            if G.GAME.SEMBY_hide_doom then
                G.GAME.SEMBY_hide_doom = false
				add_tag(Tag('tag_SEMBY_ngt_doom'))
				play_sound('highlight1', 1.2 + math.random() * 0.1, 0.5)
			    return { message = localize('SEMBY_announce_doom'), colour = G.C.PURPLE }
            end
        end
        -- Each Hand played, increases Hand size, unless Discards are '0'
        if context.after and G.GAME.current_round.discards_left ~= 0 then
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				func = function()
                    G.hand:change_size(3)
                    G.GAME.round_resets.temp_handsize = (G.GAME.round_resets.temp_handsize or 0) + 3
					return true;
				end
			}))
        end
        -- DOOMED
        if context.press_play then
            if G.GAME.SEMBY_hide_doom then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    func = function()
                        G.GAME.SEMBY_doomed = (G.GAME.SEMBY_doomed or 0) + (#G.play.cards * 0.02)
                        return true
                    end
                }))
            else
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.2,
                    func = function()
                        for i = 1, #G.play.cards do
                            -- Actual Doom
                            G.GAME.SEMBY_doomed = (G.GAME.SEMBY_doomed or 0) + 0.02
                            -- Animation
			    	        G.E_MANAGER:add_event(Event({
			    	        	trigger = 'after',
			    	        	--blocking = false,
			    	        	func = function()
			    	        		G.play.cards[i]:juice_up(0.1)
			    	                play_sound('highlight1', 1.2 + math.random() * 0.4, 0.5)
			    	        		attention_text({
			    	        			text = localize{type = 'variable', key = 'SEMBY_percentage', vars = { 2 }},
			    	        			backdrop_colour = G.C.SEMBY_PERCENT, scale = 1.0, hold = 0.5,
			    	        			major = G.play.cards[i], align = 'tm', offset = { x = 0, y = 0 }
			    	        		})
			    	        		return true
			    	        	end
			    	        }))
                            delay(0.23)
                        end
                        return true
                    end
                }))
                delay(0.4)
            end
        end
	end,
	button_colour = HEX("FF00FF00")
}
