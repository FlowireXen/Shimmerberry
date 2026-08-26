SMODS.Tag {
    key = "bnt_reroll",
	SEMBY_art = "flowire",
	atlas = "SEMBY_tags",
    pos = { x = 2, y = 1 },
    min_ante = 2,
	config = {
        extra = {
            reduce = 2,
            uses = 5
        }
    },
    loc_vars = function(self, info_queue, tag)
        return { vars = {
            tag.config.extra.reduce,
            tag.ability.uses or tag.config.extra.uses
        } }
    end,
    apply = function(self, tag, context)
        if context.type == 'shop_start'
        and not G.GAME.shop_d6ed
        and not G.GAME.SEMBY_shop_active
        and G.GAME.current_round.reroll_cost - (G.GAME.current_round.SEMBY_shop_reroll or 0) > 0
        then
            G.GAME.current_round.SEMBY_shop_reroll = (G.GAME.current_round.SEMBY_shop_reroll or 0) + tag.config.extra.reduce
            tag:SEMBY_Yap('+', G.C.GREEN, function()
                G.GAME.current_round.reroll_cost = math.max(0, G.GAME.current_round.reroll_cost - tag.config.extra.reduce)
                return true
            end)
            return true
        end
    end
}
