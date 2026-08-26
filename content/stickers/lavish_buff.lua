SMODS.Sticker {
    key = "lavish_buff",
    SEMBY_art = "flowire",
    badge_colour = G.C.MONEY,
    atlas = "SEMBY_stickers",
    pos = { x = 0, y = 1 },
    should_apply = function(self, card, center, area, bypass_roll)
        return (bypass_roll or false)
    end,
    apply = function(self, card, val)
        SMODS.Sticker.apply(self, card, val)
        if G.GAME.blind then
            SMODS.debuff_card(card, val and 'prevent_debuff' or false, 'SEMBY_lavish_buff')
        end
    end
}
