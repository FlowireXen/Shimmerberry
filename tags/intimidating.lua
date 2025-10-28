SMODS.Tag {
    key = "intimidating",
	name = "SEMBY_intimidating",
	atlas = "SEMBY_tags",
    pos = { x = 1, y = 0 },
    unlocked = true,
    discovered = false,
	config = {
		extra = {
			percent = 0.1
		}
	},
    loc_vars = function(self, info_queue, tag)
		--SEMBY_Queue_Artist(tag, info_queue)
        return { vars = {
			(tag.config.extra.percent * 100)
		} }
    end,
    apply = function(self, tag, context)
        if context.type == 'round_start_bonus' then
            tag:yep('-', G.ARGS.LOC_COLOURS.SEMBY_percent, function() return true end)
			SEMBY_Reduce_Blindsize(tag.config.extra.percent, nil, true)
            tag.triggered = true
            return true
        end
    end
}
