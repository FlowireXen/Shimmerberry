SMODS.Sticker {
    key = "possessive",
	SEMBY_art = "flowire",
    badge_colour = G.C.SEMBY_POSSESSIVE,
	atlas = "SEMBY_stickers",
    pos = { x = 0, y = 0 },
    loc_vars = function(self, info_queue, card)
		-- Sticker Credits; because stickers are ..... Strange. :)
		if card.area and card.area.config.collection and card.ability.set ~= "Joker" then
			info_queue[#info_queue + 1] = { key = "SEMBY_possessive", set = "Other" }
			return { key = "art_flowire", set = "Other" }
		end
    end,
    should_apply = function(self, card, center, area, bypass_roll)
		return (bypass_roll or false)
    end,
    apply = function(self, card, val)
        card.ability[self.key] = val
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
