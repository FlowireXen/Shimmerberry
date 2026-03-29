SMODS.Tag {
    key = "doom_debt",
	name = "SEMBY_doom_debt",
	atlas = "SEMBY_tags",
    pos = { x = 5, y = 0 },
    unlocked = true,
    discovered = false,
    loc_vars = function(self, info_queue, tag)
		--SEMBY_Queue_Artist(tag, info_queue)
        return { vars = { (G.GAME.SEMBY_doomed or 0) * 100 } }
    end,
	set_ability = function(self, tag)
		tag.ability.debt = true
	end,
    apply = function(self, tag, context)
        if G.GAME.blind.boss and G.GAME.blind.config.blind.boss.showdown and context.type == 'round_start_bonus' then
            -- Apply Doom
            tag:yep('+', G.C.SEMBY_PERCENT, function() return true end)
			SEMBY_Increase_Blindsize((G.GAME.SEMBY_doomed or 0), nil, true)
            tag.triggered = true
            -- Reset & Retain Doom
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                func = function()
                    G.GAME.SEMBY_doomed = 0.0
			        add_tag(Tag('tag_SEMBY_doom_debt'))
				    --play_sound('highlight1', 1.2 + math.random() * 0.1, 0.5)
                    return true
                end
            }))
            return true
        end
    end,
	in_pool = function(self, args)
		return false
	end
}
