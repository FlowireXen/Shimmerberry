SMODS.Joker {
	key = "loop_hero",
	name = "SEMBY_loop_hero",
	rarity = 3, --might as well be a legendary...
	cost = 20,
	atlas = "SEMBY_jokers",
	pos = { x = 4, y = 0 },
	blueprint_compat = true,
    eternal_compat = false,
    config = { oblivion = 1, loop = 0, ante_add = 0.2, ante_modifier = 0.0 },
	loc_vars = function(self, _info, card)
        return { vars = { card.ability.oblivion } }
    end,
    remove_from_deck = function(self, card, from_debuff)
        if G.jokers then
			print("Ante Final Scaling: " .. G.GAME.starting_params.ante_scaling)
			G.GAME.starting_params.ante_scaling = G.GAME.starting_params.ante_scaling - card.ability.ante_modifier
			print("Reset Ante Scaling: " .. G.GAME.starting_params.ante_scaling)
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = localize('SEMBY_eval_loop_hero_removed'), colour = G.C.DARK_EDITION })
        end
    end,
	calculate = function(self, card, context)
		if context.end_of_round and context.cardarea == G.jokers and G.GAME.blind.boss then
			-- the sauce:
			ease_ante(-card.ability.oblivion)
			-- the nerf:
			local ante_add = card.ability.ante_add * math.floor(card.ability.ante_modifier + 1.0)
			G.GAME.starting_params.ante_scaling = G.GAME.starting_params.ante_scaling + ante_add
			card.ability.ante_modifier = card.ability.ante_modifier + ante_add
			print("Current Ante Scaling: " .. G.GAME.starting_params.ante_scaling)
			-- purely visual:
			card.ability.loop = card.ability.loop + 1
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = localize('SEMBY_eval_loop_hero')..card.ability.loop, colour = G.C.DARK_EDITION })
			return
        end
	end
}
