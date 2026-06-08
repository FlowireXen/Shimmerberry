--## Code-Logic:
-- > No Logic, Purely Visual.
SMODS.Sticker {
    key = "tmtrainer_sticker",
	SEMBY_art = "flowire",
    badge_colour = G.C.SEMBY_TMTRAINER,
	atlas = "SEMBY_stickers",
    pos = { x = 2, y = 0 },
    loc_vars = function(self, info_queue, card)
		local ret_value = card.ability.SEMBY_tmtrainer_value or (math.floor((pseudorandom("TMTRAINER")+9.75)*10)/100)
		if type(ret_value) == "number" then ret_value = 'x'..(
			ret_value >= 1000 and math.floor(ret_value)
			or string.format("%.2f", round_number(ret_value, 2))
		) end
		-- Sticker Credits; because stickers are ..... Strange. :)
		if card.area and card.area.config.collection and card.ability.set ~= "Joker" then
			info_queue[#info_queue + 1] = { key = "SEMBY_tmtrainer_sticker", set = "Other", vars = { ret_value } }
			return { key = "art_flowire", set = "Other" }
		end
		-- Actual Sticker:
		return { vars = { ret_value } }
    end,
    should_apply = function(self, card, center, area, bypass_roll)
		return (bypass_roll or false)
    end,
    apply = function(self, card, val)
        card.ability[self.key] = val
    end
}
