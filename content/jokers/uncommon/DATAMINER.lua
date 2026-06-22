local textures = {
	base = { x = 8, y = 4 },
	corrupt = { x = 9, y = 4 }
}
SMODS.Joker {
	key = "DATAMINER",
	SEMBY_art = "placeholder",
	atlas = "SEMBY_jokers_2",
	pos = textures.base,
    eternal_compat = true,
    perishable_compat = false,
    blueprint_compat = false,
	rarity = 2,
	cost = 7,
	config = {
		SEMBY_tmtrainer_sticker = true,
		SEMBY_tmtrainer_value = '401',
		extra = {
			SEMBY_TMTR = "AoN",
			SEMBY_TMTR_MIN = 0.5,
			SEMBY_TMTR_MAX = 2.0,
			-- Special
			SEMBY_corrupt = 0
		}
	},
    attributes = {
		'joker', 'perma_bonus',
		'changing_effects'
	},
	loc_vars = function(self, info_queue, card)
		return { vars = {
			1 - card.ability.extra.SEMBY_TMTR_MIN,
			card.ability.extra.SEMBY_TMTR_MAX,
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
    end
}
