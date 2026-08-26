SMODS.Tag {
    key = "bnt_shop",
	SEMBY_art = "flowire",
	atlas = "SEMBY_tags",
    pos = { x = 3, y = 1 },
    min_ante = 2,
	config = {
        extra = {
            slots = 1
        }
    },
    loc_vars = function(self, info_queue, tag)
        return { vars = { tag.config.extra.slots } }
    end,
    apply = function(self, tag, context)
        if context.type == 'shop_start' then
            tag:yep('+', G.C.SET.Default)
        	change_shop_size(tag.config.extra.slots)
			G.GAME.current_round.SEMBY_shop_size = (G.GAME.current_round.SEMBY_shop_size or 0) + tag.config.extra.slots
            tag.triggered = true
            return true
        end
    end
}
