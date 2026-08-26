SMODS.Sticker {
    key = "event_horizon",
    SEMBY_art = "flowire",
    badge_colour = HEX('613F96'),
    atlas = "SEMBY_stickers",
    pos = { x = 3, y = 0 },
    should_apply = function(self, card, center, area, bypass_roll)
        return (bypass_roll or false)
    end
}
