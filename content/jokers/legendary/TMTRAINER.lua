local function get_texture(state)
	return { x = state and 9 or 8, y = 2 }
end
SMODS.Joker {
	key = "TMTRAINER",
	SEMBY_art = "flowire",
	atlas = "SEMBY_jokers_2",
	pos = get_texture(),
    eternal_compat = true,
    perishable_compat = false,
    blueprint_compat = false,
	rarity = 3, --> "Legendary"
	cost = 8,
	config = {
		extra = {
			SEMBY_TMTR = "RNG+",
			SEMBY_TMTR_MIN = 1.15,
			SEMBY_TMTR_MAX = 2.55,
			-- Special
			SEMBY_corrupt = 0
		},
		card_limit = 1
	},
    attributes = {
		'joker', 'perma_bonus',
		'changing_effects'
	},
	loc_vars = function(self, info_queue, card)
		return { vars = {
			math.floor((1-card.ability.extra.SEMBY_TMTR_MIN)*100+0.5),
			math.floor(card.ability.extra.SEMBY_TMTR_MAX*100+0.5),
			card.ability.card_limit
		} }
	end,
	set_ability = function(self, card, initial, delay_sprites)
		if card.config.center.discovered and initial then
			card.ability.SEMBY_tmtrainer_sticker = true
			card.ability.SEMBY_tmtrainer_value = '*404'
		end
	end,
	set_sprites = function(self, card, front)
		if card.ability and card.ability.extra then
			card.children.center:set_sprite_pos(get_texture(card.ability.extra.SEMBY_corrupt ~= 0))
		end
	end,
    add_to_deck = function(self, card, from_debuff)
		SEMBY_TMTR_State(true)
		if not from_debuff then
			card.children.center:set_sprite_pos(get_texture(card.ability.extra.SEMBY_corrupt ~= 0))
		end
    end,
    remove_from_deck = function(self, card, from_debuff)
		SEMBY_TMTR_State(false)
    end,
	in_pool = function(self, args)
		-- Doesn't (usually) spawn in the Shop!
		return G.GAME.SEMBY_TMTRAINER_SPAWN or (not args or (args.source ~= "sho" and args.source ~= "uta"))
	end
}
