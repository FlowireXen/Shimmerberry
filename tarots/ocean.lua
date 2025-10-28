SMODS.Consumable {
    key = "ocean",
	name = "SEMBY_ocean",
    set = "Tarot",
	atlas = "SEMBY_tarots",
    pos = { x = 0, y = 0 },
    config = {
        extra = {
            odds = 3
        }
    },
    loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_SEMBY_pearlescent
        info_queue[#info_queue + 1] = G.P_CENTERS.e_SEMBY_shiny
    end,
    use = function(self, card, area, copier)
        -- Card Selection
        local selected_card, message
        if SMODS.pseudorandom_probability(card, 'SEMBY_ocean', 1, card.ability.extra.odds) then
            local editionless_jokers = SMODS.Edition:get_edition_cards(G.jokers, true)
            selected_card = pseudorandom_element(editionless_jokers, 'SEMBY_ocean')
            message = 'SEMBY_tides_high'
        else
            selected_card = G.hand.highlighted[1]
            message = 'SEMBY_tides_low'
        end
        -- Message
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                attention_text({
                    text = localize(message),
                    scale = 0.8,
                    hold = 1.4,
                    major = selected_card,
                    backdrop_colour = G.C.SECONDARY_SET.Tarot,
                    align = 'cm',
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
        return G.hand and #G.hand.highlighted == 1 and not (G.hand.highlighted[1].edition) and next(SMODS.Edition:get_edition_cards(G.jokers, true))
    end
}
