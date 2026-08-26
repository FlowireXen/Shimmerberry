local function DEGRADING()
    return G.GAME.perishable_rounds or 5
end
SMODS.Sticker {
    key = "degrading",
    SEMBY_art = "flowire",
    badge_colour = G.C.SEMBY_DEGRADING,
    atlas = "SEMBY_stickers",
    pos = { x = 1, y = 0 },
    loc_vars = function(self, info_queue, card)
        local degrading = DEGRADING()
        -- Collection View
        if card.area and card.area.config.collection and card.ability and card.ability.set ~= "Joker" then
            info_queue[#info_queue + 1] = { key = "SEMBY_degrading", set = "Other", vars = { degrading, degrading } }
            return { key = "SEMBY_degrading_playing_card", set = "Other" }
        end
        -- Normal View:
        if card.playing_card or (card.ability and (card.ability.set == "Default" or card.ability.set == "Enhanced")) then
            return { key = 'SEMBY_degrading_playing_card', set = "Other" }
        else
            return { vars = { degrading, card.ability.SEMBY_degrading_tally or degrading } }
        end
    end,
    should_apply = function(self, card, center, area, bypass_roll)
        return (bypass_roll or G.GAME.SEMBY_degrading or false)
    end,
    apply = function(self, card, val)
        SMODS.Sticker.apply(self, card, val)
        card.ability.SEMBY_degrading_tally = val and (card.ability.SEMBY_degrading_tally or DEGRADING()) or nil
    end,
    calculate = function(self, card, context)
        if context.end_of_round and not (context.repetition or context.individual) then
            local destroy = false
            if card.playing_card or card.ability.set == "Default" or card.ability.set == "Enhanced" then
                destroy = card.area and card.area == G.hand
            else
                card.ability.SEMBY_degrading_tally = (card.ability.SEMBY_degrading_tally or DEGRADING()) - 1
                if card.ability.SEMBY_degrading_tally > 0 then
                    card_eval_status_text(card, 'extra', nil, nil, nil, {
                        message = localize{type = 'variable', key = 'a_remaining', vars = {card.ability.SEMBY_degrading_tally}},
                        colour = G.C.FILTER,
                        delay = 0.45
                    })
                else destroy = true end
            end
            if destroy then
                card_eval_status_text(card, 'extra', nil, nil, nil, {
                    message = localize('SEMBY_destroyed_ex'),
                    colour = G.C.FILTER,
                    delay = 0.45
                })
                SMODS.destroy_cards(card)
            end
        end
    end
}
