SMODS.Tag {
    key = "lavish_debt",
	name = "SEMBY_lavish_debt",
	atlas = "SEMBY_tags",
    pos = { x = 4, y = 0 },
    unlocked = true,
    discovered = false,
	config = {
		--ability: debt, lavish_percent
		extra = {
			base_percent = 0.5
		}
	},
    loc_vars = function(self, info_queue, tag)
		--SEMBY_Queue_Artist(tag, info_queue)
        return { vars = {
			((tag.ability.lavish_percent or tag.config.extra.base_percent) * 100)
		} }
    end,
	set_ability= function(self, tag)
		tag.ability.debt = true
	end,
    apply = function(self, tag, context)
        if context.type == 'round_start_bonus' then
            tag:yep('+', G.C.MONEY, function() return true end)
			SEMBY_Increase_Blindsize((tag.ability.lavish_percent or tag.config.extra.base_percent), nil, true)
            tag.triggered = true
            return true
        end
    end,
	in_pool = function(self, args)
		if G.GAME.SEMBY_lavish_mode then return true else return false end
	end
}
