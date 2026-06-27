SMODS.Sticker {
    key = "shimmer_immune",
    SEMBY_art = "flowire",
    badge_colour = G.C.SEMBY,
    atlas = "SEMBY_stickers",
    pos = { x = 2, y = 1 },
    should_apply = function(self, card, center, area, bypass_roll)
        return (bypass_roll or false)
    end
}
