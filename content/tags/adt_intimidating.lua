SMODS.Tag {
    key = "adt_intimidating",
	SEMBY_art = "flowire",
	atlas = "SEMBY_tags",
    pos = { x = 1, y = 0 },
    min_ante = 2,
	config = {
		extra = {
            percent = 0.2
        }
	},
    loc_vars = function(self, info_queue, tag)
        return { vars = {
			(tag.config.extra.percent * 100)
		} }
    end,
    apply = function(self, tag, context)
        if context.type == 'round_start_bonus' then
            tag:yep('-', G.C.SEMBY_PERCENT)
			SEMBY_Reduce_Blindsize(tag.config.extra.percent, nil, true)
            tag.triggered = true
            return true
        end
    end
}
