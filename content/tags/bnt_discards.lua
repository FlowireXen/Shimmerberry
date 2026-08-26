SMODS.Tag {
    key = "bnt_discards",
	SEMBY_art = "flowire",
	atlas = "SEMBY_tags",
    pos = { x = 1, y = 1 },
    min_ante = 2,
	config = {
        extra = {
            uses = 5
        }
    },
    loc_vars = function(self, info_queue, tag)
        return { vars = {
            tag.ability.uses or tag.config.extra.uses
        } }
    end,
    apply = function(self, tag, context)
        if context.type == 'eval' then tag.ability.used = false end
        if context.type == 'round_start_bonus' and not tag.ability.used then
            tag.ability.used = true
            tag:SEMBY_Yap('+', G.C.RED)
            ease_discard(1)
            return true
        end
    end
}
