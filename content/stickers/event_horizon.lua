--## Code-Logic:
-- > No Logic, Purely Visual.
SMODS.Sticker {
    key = "event_horizon",
	name = "SEMBY_event_horizon",
    badge_colour = HEX('613F96'),
	atlas = "SEMBY_stickers",
    pos = { x = 3, y = 0 },
    loc_vars = function(self, info_queue, card)
      --> SEMBY_Queue_Artist(card, info_queue)
		  if card.area and card.area.config.collection then
		  	-- So the Artists Credits don't Overwrite the Description...
		  	info_queue[#info_queue + 1] = { key = "SEMBY_event_horizon", set = "Other" }
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
