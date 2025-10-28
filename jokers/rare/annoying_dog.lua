SMODS.Joker {
	key = "annoying_dog",
	name = "SEMBY_annoying_dog",
	atlas = "SEMBY_jokers",
	pos = { x = 11, y = 1 },
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
	rarity = 3,
	cost = 7,
	config = {
		extra = {
			xmult = 3,
			slots = 103
		}
	},
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
		info_queue[#info_queue + 1] = { key = "inspired_vio_undertale", set = "Other" }
		return { vars = {
			(card.ability.extra.xmult % 1 == 0) and card.ability.extra.xmult..'.0' or card.ability.extra.xmult
		} }
	end,
    add_to_deck = function(self, card, from_debuff)
		G.consumeables:add_text_overwrite(card.sort_id, 'SEMBY_dog_overflow')
		G.consumeables:handle_card_limit(0, card.ability.extra.slots)
    end,
    remove_from_deck = function(self, card, from_debuff)
		G.consumeables:handle_card_limit(0, -card.ability.extra.slots)
		G.consumeables:remove_text_overwrite(card.sort_id)
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
