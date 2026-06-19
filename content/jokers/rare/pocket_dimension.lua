SMODS.Joker {
	key = "pocket_dimension",
	SEMBY_art = "unkokat",
	atlas = "SEMBY_jokers_1",
	pos = { x = 8, y = 1 },
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
	rarity = 3,
	cost = 8,
	config = {
		extra = {
			slots = 3,
			xmult = 1.5
		}
	},
    attributes = {
		'xmult', 'space',
		'consumable', 'magic',
	},
	loc_vars = function(self, info_queue, card)
		return { vars = {
			card.ability.extra.slots,
			card.ability.extra.xmult
		} }
	end,
    add_to_deck = function(self, card, from_debuff)
		G.consumeables.config.card_limit = G.consumeables.config.card_limit + card.ability.extra.slots
    end,
    remove_from_deck = function(self, card, from_debuff)
		G.consumeables.config.card_limit = G.consumeables.config.card_limit - card.ability.extra.slots
    end,
	calculate = function(self, card, context)
        if context.other_consumeable and context.other_consumeable.area
		and context.other_consumeable.area == G.consumeables then
            return {
				xmult = card.ability.extra.xmult,
				message_card = context.other_consumeable,
				-- This was part of the Above thingy, but alas...
				remove_default_message = true,
				message = localize{type = "name_text", set = context.other_consumeable.config.center.set, key = context.other_consumeable.config.center.key},
				colour = G.C.SECONDARY_SET[context.other_consumeable.config.center.set] or G.C.DARK_EDITION,
				sound = 'multhit2',
				volume = 0.7
            }
        end
	end
}
