--## Shader
SMODS.Shader {
	key = "resonance",
	path = "resonance.fs"
}

--## Edition
G.SEMBY.Resonance = 0.25
SMODS.Edition {
    key = "resonance",
	name = "SEMBY_resonance",
    shader = "resonance",
	disable_base_shader = true,
	apply_to_float = true,
    config = {
		card_limit = 1
	},
    in_shop = true,
    weight = 1,
    extra_cost = 7,
    sound = { sound = "SEMBY_resonance", per = 1.2, vol = 1.1 },
	badge_colour = SMODS.Gradients.SEMBY_RESONANCE,
    loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
		info_queue[#info_queue + 1] = { key = "debuffed_default", set = "Other" }
		return { vars = {
			((card.edition or {}).card_limit or self.config.card_limit),
			G.SEMBY.Resonance * 100
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
		if context.end_of_round and context.main_eval and context.game_over == false then
			G.GAME.current_round.SEMBY_resonance = (G.GAME.current_round.SEMBY_resonance or 0) + 1 --> "/functions/common.lua"
		end
    end
}
