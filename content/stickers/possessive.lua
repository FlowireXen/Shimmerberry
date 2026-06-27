SMODS.Sticker {
    key = "possessive",
    SEMBY_art = "flowire",
    badge_colour = G.C.SEMBY_POSSESSIVE,
    atlas = "SEMBY_stickers",
    pos = { x = 0, y = 0 },
    should_apply = function(self, card, center, area, bypass_roll)
        return (bypass_roll or false)
    end
}

local sell_hook = Card.can_sell_card
function Card:can_sell_card(context)
    if (G.SETTINGS.tutorial_complete
        or G.GAME.pseudorandom.seed ~= 'TUTORIAL'
        or G.GAME.round_resets.ante > 1)
    and self.ability.SEMBY_possessive then
        return false
    end
    return sell_hook(self, context)
end
