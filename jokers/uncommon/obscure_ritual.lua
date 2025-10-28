SMODS.Joker {
	key = "obscure_ritual",
	name = "SEMBY_obscure_ritual",
	atlas = "SEMBY_jokers",
	pos = { x = 6, y = 6 },
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = false,
	rarity = 2,
	cost = 5,
	config = {
		extra = {
			percent = 0.50,
			active = false,
			pos_valid = { base = 6, mod = 7 },
			pos_overwrite = { x = 6, y = 6 }
		}
	},
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
		return { vars = {
			card.ability.extra.percent * 100
		} }
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
		if not context.blueprint then
			if context.hand_drawn then
				if not card.ability.extra.active and G.deck and #G.deck.cards <= 0 then
					card.ability.extra.active = true
					G.E_MANAGER:add_event(Event({
						func = function()
							card.ability.extra.pos_overwrite.x = card.ability.extra.pos_valid.mod
							card.children.center:set_sprite_pos(card.ability.extra.pos_overwrite)
							return true
						end
					}))
					SEMBY_Reduce_Blindsize(card.ability.extra.percent, nil, true)
					return {
						message = localize('SEMBY_ritual_complete'),
						colour = HEX('CC0000'),
						func = function()
							SEMBY_Blind_Check(card)
						end
					}
				end
			end
			if context.end_of_round and context.cardarea == G.jokers then
				if card.ability.extra.active then
					card.ability.extra.active = false
					G.E_MANAGER:add_event(Event({
						func = function()
							card.ability.extra.pos_overwrite.x = card.ability.extra.pos_valid.base
							card.children.center:set_sprite_pos(card.ability.extra.pos_overwrite)
							return true
						end
					}))
					return {
						message = localize('SEMBY_ritual_inactive'),
						colour = HEX('666666')
					}
				end
			end
		end
	end
}
