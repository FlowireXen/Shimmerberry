local function get_texture(state)
	return { x = state and 9 or 8, y = 1 }
end
SMODS.Joker {
	key = "to_and_fro",
	SEMBY_art = "unkokat",
	atlas = "SEMBY_jokers_2",
	pos = get_texture(),
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = false,
	rarity = 1,
	cost = 5,
	config = {
		extra = {
			desc_switch = false,
			texture_switch = false
		}
	},
    attributes = {
		'swap'
	},
	loc_vars = function(self, info_queue, card)
		card.ability.extra.desc_switch = not card.ability.extra.desc_switch
		return { key = card.ability.extra.desc_switch and 'j_SEMBY_fro_and_to' or 'j_SEMBY_to_and_fro' }
	end,
	set_sprites = function(self, card, front)
		if card.ability and card.ability.extra then
			card.children.center:set_sprite_pos(get_texture(card.ability.extra.texture_switch))
		end
	end,
    add_to_deck = function(self, card, from_debuff)
		if not from_debuff then
			card.children.center:set_sprite_pos(get_texture(card.ability.extra.texture_switch))
		end
    end,
	calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and not context.blueprint then
			-- Visual + Sound Feedback
        	G.E_MANAGER:add_event(Event({
				trigger = 'after',
				func = function()
					-- Scoring-Area Flair:
					G.hand_text_area.handname:juice_up()
					G.hand_text_area.hand_level:juice_up()
					-- Texture Change
					card.ability.extra.texture_switch = not card.ability.extra.texture_switch
					card.children.center:set_sprite_pos(get_texture(card.ability.extra.texture_switch))
					-- Effects
					card:juice_up()
					play_sound('whoosh', 1.0 + (math.random() * 0.4 - 0.2), 0.6)
					return true
				end
			}))
			-- Swapping Code
			local old_mult = mult
			mult = mod_mult(hand_chips)
			hand_chips = mod_chips(old_mult)
			update_hand_text({delay = 0.2}, {chips = hand_chips, mult = mult})
			return nil, true
			--FIXME: return { swap = true }   <- This makes the Card and Joker wiggle way way too much.
        end
    end
}
