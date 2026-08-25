SMODS.Consumable {
    key = "ocean",
    SEMBY_art = "lanedarushpy",
	atlas = "SEMBY_consumables",
    pos = { x = 1, y = 0 },
    set = "Tarot",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_SEMBY_pearlescent
        info_queue[#info_queue + 1] = G.P_CENTERS.e_SEMBY_shiny
        --info_queue[#info_queue + 1] = { key = "e_SEMBY_shiny_playing_card", set = "Edition", config = G.P_CENTERS.e_SEMBY_shiny.config }
        info_queue[#info_queue + 1] = { key = "SEMBY_shiny_playing_card", set = "Other", vars = { G.P_CENTERS.e_SEMBY_shiny.config.card_value } }
    end,
    use = function(self, card, area, copier)
        -- Gain all valid cards
        local jokers = SMODS.Edition:get_edition_cards(G.jokers, true)
        local pl_cards = SMODS.Edition:get_edition_cards(G.hand, true)
        -- Card Selection
        local selected_card
        if next(jokers) and next(pl_cards) then -- chance for both
            if SMODS.pseudorandom_probability(card, 'SEMBY_ocean', 1, 5, nil, true) then
                selected_card = pseudorandom_element(jokers, 'SEMBY_ocean')
            else
                selected_card = pseudorandom_element(pl_cards, 'SEMBY_ocean')
            end
        elseif next(jokers) then -- random joker
            selected_card = pseudorandom_element(jokers, 'SEMBY_ocean')
        else -- random pl_card
            selected_card = pseudorandom_element(pl_cards, 'SEMBY_ocean')
        end
        -- Message
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                attention_text({
                    text = localize(selected_card.area == G.jokers and 'SEMBY_tides_high' or 'SEMBY_tides_low'),
                    scale = 0.8,
                    hold = 1.4,
                    major = selected_card,
                    backdrop_colour = G.C.SECONDARY_SET.Tarot,
                    align = selected_card.area == G.jokers and 'bm' or 'tm',
                    offset = { x = 0, y = 0 }
                })
                return true
            end
        }))
        -- Change Logic
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                selected_card:juice_up(0.3, 0.5)
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.15,
            func = function()
                selected_card:flip()
                play_sound('card1', 1.1)
                selected_card:juice_up(0.3, 0.3)
                return true
            end
        }))
        delay(0.2)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
                local edition = poll_edition('SEMBY_ocean', nil, true, true, { 'e_SEMBY_pearlescent', 'e_SEMBY_shiny' })
                selected_card:set_edition(edition, true)
                selected_card:juice_up(0.3, 0.5)
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.15,
            func = function()
                selected_card:flip()
                play_sound('tarot2', 0.8, 0.6)
                selected_card:juice_up(0.3, 0.3)
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
        delay(0.5)
    end,
    can_use = function(self, card)
        return (G.hand and next(SMODS.Edition:get_edition_cards(G.hand, true))) or (G.jokers and next(SMODS.Edition:get_edition_cards(G.jokers, true)))
    end
}
