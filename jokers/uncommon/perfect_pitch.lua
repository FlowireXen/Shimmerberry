SMODS.Joker {
	key = "perfect_pitch",
	name = "SEMBY_perfect_pitch",
	atlas = "SEMBY_jokers",
	pos = { x = 1, y = 8 },
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
	rarity = 2,
	cost = 6,
	config = {
		extra = {
			scoring = {
				state = 2,
				max = 5
			},
			xmult = 2.0,
			xmult_gain = 1.0,
			streak = 0,
			streak_active = false,
			pos_valid = { base = 0 }, --> Starts with state 2, but state 1 is pos 0
			pos_overwrite = { x = 1, y = 8 }
		}
	},
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
		return { vars = {
			card.ability.extra.xmult,
			card.ability.extra.scoring.state,
			card.ability.extra.xmult_gain,
			card.ability.extra.scoring.max,
			card.ability.extra.streak
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
		if context.joker_main and #context.scoring_hand == card.ability.extra.scoring.state then
			card.ability.extra.streak_active = true
			return {
				xmult = card.ability.extra.xmult
			}
        end
		if context.after and not context.blueprint then
			card.ability.extra.scoring.state = card.ability.extra.scoring.state + 1
			if card.ability.extra.scoring.state > card.ability.extra.scoring.max then
				card.ability.extra.scoring.state = 1
			end
			G.E_MANAGER:add_event(Event({
				func = function()
					card.ability.extra.pos_overwrite.x = card.ability.extra.pos_valid.base + card.ability.extra.scoring.state - 1
					card.children.center:set_sprite_pos(card.ability.extra.pos_overwrite)
					return true
				end
			}))
			if card.ability.extra.streak_active then
				card.ability.extra.streak_active = false
				card.ability.extra.streak = card.ability.extra.streak + 1
			elseif card.ability.extra.streak > 0 then
				card.ability.extra.streak = 0
				return {
					message = localize('k_reset'),
					colour = G.C.RED
				}
			end
			if card.ability.extra.streak >= card.ability.extra.scoring.max then
				card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
				card.ability.extra.streak = 0
				return {
					message = localize('k_upgrade_ex'),
					colour = G.C.GREEN
				}
			end
			return {
				message = localize('SEMBY_pitch_shift'),
                colour = G.C.BLUE
			}
		end
    end
}
