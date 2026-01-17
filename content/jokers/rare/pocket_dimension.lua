SMODS.Joker {
	key = "pocket_dimension",
	name = "SEMBY_pocket_dimension",
	atlas = "SEMBY_jokers",
	pos = { x = 8, y = 2 },
    unlocked = true,
    discovered = false,
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
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
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
        if context.other_consumeable then
			-- This Context is Janky: All these Events Trigger Instantly upon scoring:
			--[[
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				func = function()
					attention_text({
						text = localize{type = "name_text", set = context.other_consumeable.config.center.set, key = context.other_consumeable.config.center.key},
						backdrop_colour = G.C.SECONDARY_SET[context.other_consumeable.config.center.set] or G.C.DARK_EDITION,
						scale = 0.7, hold = 1.0, major = card,
						align = 'bm', offset = { x = 0, y = 0 }
					})
					return true
				end
			}))
			--]]
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
