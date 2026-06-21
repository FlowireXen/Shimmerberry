SMODS.Consumable {
    key = 'microcosm',
    SEMBY_art = "lizrushpy",
	atlas = "SEMBY_consumables",
    pos = { x = 3, y = 0 },
    set = "Planet",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_SEMBY_vintage
        if G.hand and G.hand.highlighted and #G.hand.highlighted ~= 0 then
            -- Get Infos:
            local hand_id, loc_text, _, scoring_hand, _ = G.FUNCS.get_poker_hand_info(G.hand.highlighted)
            if hand_id and scoring_hand then
                -- Visual Info:
                for _, v_card in pairs(scoring_hand) do
                    v_card:juice_up(0.1, 0.2)
                end
                -- Text Info:
                return {
                    key = 'c_SEMBY_microcosm_highlighted',
                    vars = {
                        G.GAME.hands[hand_id].level,
                        loc_text,
                        G.GAME.hands[hand_id].l_mult,
                        G.GAME.hands[hand_id].l_chips,
                        #scoring_hand,
                        colours = {(
                            G.GAME.hands[hand_id].level == 1 and G.C.UI.TEXT_DARK or
                            G.C.HAND_LEVELS[math.min(7, G.GAME.hands[hand_id].level)]
                        )}
                    }
                }
            end
        end
    end,
    set_ability = function(self, card, initial, delay_sprites)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                if not G.GAME.SEMBY_microcosm_pack and G.hand and #G.hand == 0 and card.area and card.area == G.pack_cards then
                    -- Limit
                    G.GAME.SEMBY_microcosm_pack = true
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.GAME.SEMBY_microcosm_pack = nil
                            return true
                        end
                    }))
                    -- Animate
                    play_sound('tarot1')
                    card:juice_up(0.2)
                    -- Draw!
                    SMODS.draw_cards(G.hand.config.card_limit)
                end
                return true
            end
        }))
    end,
    use = function(self, card, area, copier)
        -- Get Infos:
        local hand_id, _, _, scoring_hand, _ = G.FUNCS.get_poker_hand_info(G.hand.highlighted)
        -- Enhance:
        if scoring_hand and #scoring_hand > 0 then
            -- Animation Start:
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    play_sound('tarot1')
                    card:juice_up(0.3)
                    return true
                end
            }))
            for i = 1, #scoring_hand do
                local percent = 1.15 - (i - 0.999) / (#scoring_hand - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        scoring_hand[i]:flip()
                        play_sound('card1', percent)
                        scoring_hand[i]:juice_up(0.3)
                        return true
                    end
                }))
            end
            delay(0.2)
            -- Downgrade:
            if hand_id and G.GAME.hands[hand_id] and G.GAME.hands[hand_id].level > 1 then
                SMODS.upgrade_poker_hands({
                    hands = hand_id,
                    level_up = -1,
                    from = card
                })
            end
            -- Conversion:
            for i = 1, #scoring_hand do
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()
                        scoring_hand[i]:set_ability('m_SEMBY_vintage')
                        return true
                    end
                }))
            end
            -- Animation End:
            for i = 1, #scoring_hand do
                local percent = 0.85 + (i - 0.999) / (#scoring_hand - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        scoring_hand[i]:flip()
                        play_sound('tarot2', percent, 0.6)
                        scoring_hand[i]:juice_up(0.3)
                        return true
                    end
                }))
            end
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                update_hand_text( { }, { mult = 0, chips = 0, handname = '', level = '' } )
                return true
            end
        }))
        delay(0.5)
    end,
    can_use = function(self, card)
        if G.hand and #G.hand.highlighted > 0 then
            local _, _, _, scoring_hand, _ = G.FUNCS.get_poker_hand_info(G.hand.highlighted)
            return scoring_hand and #scoring_hand > 0
        end
        return false
    end
}
