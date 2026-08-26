local BLOOM = 0
SMODS.Sticker {
    key = "blooming",
    SEMBY_art = "flowire",
    badge_colour = G.C.SEMBY,
    atlas = "SEMBY_stickers",
    pos = { x = 3, y = 1 },
    loc_vars = function(self, info_queue, card)
        return { vars = { BLOOM } }
    end,
    should_apply = function(self, card, center, area, bypass_roll)
        return (bypass_roll or false)
    end,
    apply = function(self, card, val)
        SMODS.Sticker.apply(self, card, val)
        if card.ability then
            local mod = math.floor(card.cost/2) - BLOOM
            card.ability.extra_value = (card.ability.extra_value or 0) + (val and -mod or mod)
		    card:set_cost()
        end
    end
}
