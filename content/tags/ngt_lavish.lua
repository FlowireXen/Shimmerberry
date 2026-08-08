SMODS.Tag {
    key = "ngt_lavish",
	SEMBY_art = "flowire",
	atlas = "SEMBY_tags",
    pos = { x = 4, y = 0 },
	config = {
		extra = {
			base_percent = 0.5
		}
	},
    loc_vars = function(self, info_queue, tag)
        return { vars = {
			((tag.ability.lavish_percent or tag.config.extra.base_percent) * 100)
		} }
    end,
	set_ability = function(self, tag)
		tag.ability.debt = true
	end,
    apply = function(self, tag, context)
        if context.type == 'round_start_bonus' then
            tag:yep('+', G.C.MONEY)
			SEMBY_Increase_Blindsize((tag.ability.lavish_percent or tag.config.extra.base_percent), nil, true)
            tag.triggered = true
            return true
        end
    end,
	in_pool = function(self, args)
		return G.GAME.SEMBY_lavish_mode or false
	end
}
