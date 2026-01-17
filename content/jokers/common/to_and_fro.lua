SMODS.Joker {
	key = "to_and_fro",
	name = "SEMBY_to_and_fro",
	atlas = "SEMBY_jokers",
	pos = { x = 0, y = 10 },
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = false,
	rarity = 1,
	cost = 5,
	config = {
		extra = {
			desc_switch = false,
			pos_valid = { base = 10, mod = 11 },
			pos_overwrite = { x = 0, y = 10 }
		}
	},
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
		card.ability.extra.desc_switch = not card.ability.extra.desc_switch
		return { key = card.ability.extra.desc_switch and 'j_SEMBY_fro_and_to' or 'j_SEMBY_to_and_fro' }
	end,
	load = function(self, card, card_table, other_card)
		G.E_MANAGER:add_event(Event({
			func = function()
				card.children.center:set_sprite_pos(card.ability.extra.pos_overwrite)
				return true
			end
		}))
	end,
    add_to_deck = function(self, card, from_debuff)
		if not from_debuff then
			card.children.center:set_sprite_pos(card.ability.extra.pos_overwrite)
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
					card.ability.extra.pos_overwrite.y =
						card.ability.extra.pos_overwrite.y == card.ability.extra.pos_valid.base
						and card.ability.extra.pos_valid.mod
						or card.ability.extra.pos_valid.base
					card.children.center:set_sprite_pos(card.ability.extra.pos_overwrite)
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
			-- return { swap = true }   <- This makes the Card and Joker wiggle way way too much.
        end
    end
}
