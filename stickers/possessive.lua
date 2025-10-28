--## Code-Logic (Lovely-Patch):
-- @ lovely/possessive.toml
SMODS.Sticker {
    key = "possessive",
	name = "SEMBY_possessive",
    badge_colour = HEX('BE3740'),
	atlas = "SEMBY_stickers",
    pos = { x = 0, y = 0 },
    loc_vars = function(self, info_queue, card)
        --> SEMBY_Queue_Artist(card, info_queue)
		if card.area and card.area.config.collection then
			-- Makes sure it only shows Up in the intended Area;
			if card.ability.set ~= "Joker" then
				-- So the Artists Credits don't Overwrite the Description...
				info_queue[#info_queue + 1] = { key = "SEMBY_possessive", set = "Other" }
				return { key = "art_flowire", set = "Other" }
			end
		end
    end,
    should_apply = function(self, card, center, area, bypass_roll)
		return (bypass_roll or false)
    end,
    apply = function(self, card, val)
        card.ability[self.key] = val
    end
}
