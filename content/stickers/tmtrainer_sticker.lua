--## Code-Logic:
-- > No Logic, Purely Visual.
SMODS.Sticker {
    key = "tmtrainer_sticker",
	name = "SEMBY_tmtrainer_sticker",
    badge_colour = G.C.SEMBY_TMTRAINER,
	atlas = "SEMBY_stickers",
    pos = { x = 2, y = 0 },
    loc_vars = function(self, info_queue, card)
        --> SEMBY_Queue_Artist(card, info_queue)
		if card.area and card.area.config.collection then
			-- So the Artists Credits don't Overwrite the Description...
			info_queue[#info_queue + 1] = { key = "SEMBY_tmtrainer_sticker", set = "Other", vars = {
				card.ability.SEMBY_tmtrainer_value or string.format("%.2f", round_number(1.0 * (pseudorandom("TMTRAINER") * 0.05 + 0.975), 2))
			}}
			return { key = "art_flowire", set = "Other" }
		end
		return { vars = { card.ability.SEMBY_tmtrainer_value or string.format("%.2f", round_number(1.0 * (pseudorandom("TMTRAINER") * 0.05 + 0.975), 2)) } }
    end,
    should_apply = function(self, card, center, area, bypass_roll)
		return (bypass_roll or false)
    end,
    apply = function(self, card, val)
        card.ability[self.key] = val
		--card.ability.SEMBY_tmtrainer_value = 0
    end
}
