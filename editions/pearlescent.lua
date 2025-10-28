--## Shader
SMODS.Shader {
	key = "pearlescent",
	path = "pearlescent.fs"
}

--## Edition
SMODS.Edition {
    key = "pearlescent",
	name = "SEMBY_pearlescent",
    shader = "pearlescent",
    config = {
		percent = 0.05
	},
    in_shop = true,
    weight = 5,
    extra_cost = 3,
    sound = { sound = "SEMBY_pearlescent", per = 1.2 * 1.58, vol = 0.4 },
    loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
        return { vars = {
			((card.edition or {}).percent or self.config.percent) * 100
		} }
    end,
    get_weight = function(self)
        return G.GAME.edition_rate * self.weight
    end,
    calculate = function(self, card, context)
        if context.pre_joker or (context.main_scoring and context.cardarea == G.play) then
			SEMBY_Reduce_Blindsize(self.config.percent, card, true)
			return nil, true
        end
    end
}
