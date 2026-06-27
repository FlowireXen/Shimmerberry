local OFFSET, AMOUNT = 3, 4
local function get_texture()
	return { x = math.random(1, AMOUNT) + OFFSET, y = 4 }
end
SMODS.Joker {
	key = "annoying_dog",
	SEMBY_art = "placeholder",
	atlas = "SEMBY_jokers_2",
	pos = get_texture(),
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
	rarity = 3,
	cost = 7,
	config = {
		extra = {
			xmult = 3
		}
	},
    attributes = {
		'xmult',
		'consumable', 'animal',
	},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { key = "inspired_vio_undertale", set = "Other" }
		return { vars = {
			(card.ability.extra.xmult % 1 == 0) and card.ability.extra.xmult..'.0' or card.ability.extra.xmult
		} }
	end,
	set_ability = function(self, card, initial, delay_sprites)
		if card.config.center.discovered and initial then
			card.children.center:set_sprite_pos(get_texture())
		end
	end,
	load = function(self, card, card_table, other_card)
		G.E_MANAGER:add_event(Event({
			func = function()
				card.children.center:set_sprite_pos(get_texture())
				return true
			end
		}))
	end,
    add_to_deck = function(self, card, from_debuff)
		G.consumeables:SEMBY_add_text_override(card.sort_id, 'SEMBY_dog_overflow')
		G.consumeables:SEMBY_block()
    end,
    remove_from_deck = function(self, card, from_debuff)
		G.consumeables:SEMBY_unblock()
		G.consumeables:SEMBY_remove_text_override(card.sort_id)
    end,
	calculate = function(self, card, context)
		if context.joker_main then
        	return {
				xmult = card.ability.extra.xmult,
				remove_default_message = true,
				message = localize('SEMBY_bark_'..math.random(1, 5)),
				colour = G.C.MULT,
				sound = 'multhit2',
				volume = 0.7
			}
        end
	end
}
