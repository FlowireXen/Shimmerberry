local function get_texture(state)
	return { x = state and 9 or 8, y = 3 }
end
SMODS.Joker {
	key = "DATAMINER",
	SEMBY_art = "unkokat",
	atlas = "SEMBY_jokers_2",
	pos = get_texture(),
    eternal_compat = true,
    perishable_compat = false,
    blueprint_compat = false,
	rarity = 2,
	cost = 7,
	config = {
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
	set_ability = function(self, card, initial, delay_sprites)
		if card.config.center.discovered and initial then
			card.ability.SEMBY_tmtrainer_sticker = true
			card.ability.SEMBY_tmtrainer_value = '*401'
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
    end
}
