SMODS.Tag {
    key = "ngt_doom",
	SEMBY_art = "flowire",
	atlas = "SEMBY_tags",
    pos = { x = 5, y = 0 },
    loc_vars = function(self, info_queue, tag)
        return { vars = { (G.GAME.SEMBY_doomed or 0) * 100 } }
    end,
	set_ability = function(self, tag)
		tag.ability.debt = true
	end,
    apply = function(self, tag, context)
        if G.GAME.blind.boss and G.GAME.blind.config.blind.boss.showdown and context.type == 'round_start_bonus' then
            -- Animate
            tag:SEMBY_Yap('+', G.C.SEMBY_PERCENT)
            tag.ability.uses = nil
            -- Apply Doom
			SEMBY_Increase_Blindsize((G.GAME.SEMBY_doomed or 0), nil, true)
            G.GAME.SEMBY_doomed = 0
            return true
        end
    end,
	in_pool = function(self, args)
		return false
	end
}
