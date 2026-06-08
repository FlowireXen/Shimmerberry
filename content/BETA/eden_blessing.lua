SMODS.Joker {
	key = "eden_blessing",
    SEMBY_art = "lizrushpy",
	atlas = "SEMBY_jokers_1",
	pos = { x = 7, y = 7 },
	eternal_compat = true,
	perishable_compat = false,
	blueprint_compat = true,
	rarity = 2,
	cost = 4,
	config = {
		extra = {
			xcom = 1.5
		}
	},
    attributes = {
		'xchips', 'xmult'
	},
	loc_vars = function(self, info_queue, card)
		return {
			key = not SEMBY_Eden_Valid() and 'j_SEMBY_eden_blessing_alt' or nil,
			vars = { card.ability.extra.xcom }
		}
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
		and G.GAME.blind.boss and not context.blueprint and SEMBY_Eden_Valid() then
			if G.GAME.SEMBY_eden_checksum == Shimmerberry.config.eden_checksum then
				SEMBY_Eden_Token(1)
			end
			return {
				message = '+1 '..localize('SEMBY_eden_token'),
				colour = SMODS.Gradients.SEMBY_EDEN
			}
		end
	end
}
