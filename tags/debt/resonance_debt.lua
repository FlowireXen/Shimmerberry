SMODS.Tag {
    key = "resonance_debt",
	name = "SEMBY_resonance_debt",
	atlas = "SEMBY_tags",
    pos = { x = 5, y = 0 },
    unlocked = true,
    discovered = false,
	config = {
		--ability: debt, resonance_percent
		extra = {
			base_percent = G.SEMBY.Resonance
		}
	},
    loc_vars = function(self, info_queue, tag)
		--SEMBY_Queue_Artist(tag, info_queue)
        return { vars = {
			(tag.ability.resonance_percent or tag.config.extra.base_percent) * 100
		} }
    end,
	set_ability= function(self, tag)
		tag.ability.debt = true
	end,
    apply = function(self, tag, context)
        if context.type == 'round_start_bonus' then
            tag:yep('+', G.C.SEMBY_PERCENT, function() return true end)
			SEMBY_Increase_Blindsize((tag.ability.resonance_percent or tag.config.extra.base_percent), nil, true)
            tag.triggered = true
            return true
        end
    end,
	in_pool = function(self, args)
		return false
	end
}
