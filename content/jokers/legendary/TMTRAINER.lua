local textures = {
	base = { x = 8, y = 3 },
	corrupt = { x = 9, y = 3 }
}
SMODS.Joker {
	key = "TMTRAINER",
	SEMBY_art = "flowire",
	atlas = "SEMBY_jokers_2",
	pos = textures.base,
    eternal_compat = true,
    perishable_compat = false,
    blueprint_compat = false,
	rarity = 3, --> "Legendary"
	cost = 9,
	config = {
		SEMBY_tmtrainer_sticker = true,
		SEMBY_tmtrainer_value = '404',
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
	load = function(self, card, card_table, other_card)
		G.E_MANAGER:add_event(Event({
			func = function()
				if card.ability.extra.SEMBY_corrupt ~= 0 then
					card.children.center:set_sprite_pos(textures.corrupt)
				end
				return true
			end
		}))
	end,
    add_to_deck = function(self, card, from_debuff)
		SEMBY_TMTR_State(true)
		if not from_debuff and card.ability.extra.SEMBY_corrupt ~= 0 then
			card.children.center:set_sprite_pos(textures.corrupt)
		end
    end,
    remove_from_deck = function(self, card, from_debuff)
		SEMBY_TMTR_State(false)
    end,
	in_pool = function(self, args)
		-- Doesn't (usually) spawn in the Shop!
		return G.GAME.SEMBY_TMTRAINER or (not args or (args.source ~= "sho" and args.source ~= "uta"))
	end
}
