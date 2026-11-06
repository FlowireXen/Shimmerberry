SMODS.Joker {
	key = "eden_blessing",
    SEMBY_art = "lanedarushpy",
	atlas = "SEMBY_jokers_1",
	pos = { x = 7, y = 7 },
	eternal_compat = true,
	perishable_compat = false,
	blueprint_compat = true,
	rarity = 2,
	cost = 4,
	config = {
		extra = {
			xcom = 1.5,
			active = true
		}
	},
    attributes = {
		'xchips', 'xmult',
		'nature',
	},
	loc_vars = function(self, info_queue, card)
		return {
			key = not (card.ability.extra.active and SEMBY_Eden_Valid()) and 'j_SEMBY_eden_blessing_alt' or nil,
			vars = { card.ability.extra.xcom }
		}
	end,
    add_to_deck = function(self, card, from_debuff)
		if not from_debuff then card.ability.extra.active = true end
    end,
	calculate = function(self, card, context)
		if context.joker_main then
			if hand_chips > mult then
				return { xmult = card.ability.extra.xcom }
			else
				return { xchips = card.ability.extra.xcom }
			end
		end
		if context.end_of_round and context.main_eval and context.game_over == false
		and card.ability.extra.active and G.GAME.blind.boss and not context.blueprint then
			if SEMBY_Eden_Valid() then
				card.ability.extra.active = false
				SEMBY_Eden_Token(3)
				return {
					message = '+3 '..localize('SEMBY_eden_token'),
					colour = SMODS.Gradients.SEMBY_EDEN
				}
			end
		end
	end
}
