--## Shader
SMODS.Shader {
	key = "resonance",
	path = "resonance.fs"
}

--## Edition
SMODS.Edition {
    key = "resonance",
	SEMBY_art = "flowire",
    shader = "resonance",
	disable_base_shader = true,
	apply_to_float = true,
    config = {
		percent = 0.05
	},
    in_shop = true,
    weight = 3,
    extra_cost = 2,
    sound = { sound = "SEMBY_resonance", per = 1.2, vol = 1.1 },
	badge_colour = SMODS.Gradients.SEMBY_RESONANCE,
    loc_vars = function(self, info_queue, card)
		--info_queue[#info_queue + 1] = { key = "debuffed_default", set = "Other" }
        return { vars = {
			((card.edition or {}).percent or self.config.percent) * 100
		} }
    end,
    get_weight = function(self)
        return G.GAME.edition_rate * self.weight
    end,
    on_apply = function(card)
		if G.GAME.blind then SMODS.debuff_card(card, 'prevent_debuff', 'SEMBY_resonance') end
    end,
    on_remove = function(card)
		if G.GAME.blind then SMODS.debuff_card(card, false, 'SEMBY_resonance') end
    end,
    calculate = function(self, card, context)
        if context.pre_joker or (context.main_scoring and context.cardarea == G.play) then
			SEMBY_Increase_Blindsize(self.config.percent, card, true)
			return nil, true
        end
    end
}
