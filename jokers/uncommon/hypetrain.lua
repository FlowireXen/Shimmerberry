SMODS.Joker {
	key = "hypetrain",
	name = "SEMBY_hypetrain",
	atlas = "SEMBY_jokers",
	pos = { x = 2, y = 10 },
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
	rarity = 2,
	cost = 7,
	config = {
		extra = {
			mult = 20,
			mult_mod = 1,
			mult_reset = 20,
			xmult = 1.0,
			xmult_mod = 1.0,
			waiting = true,
			pos_valid = { base = 10, mod = 11 },
			pos_overwrite = { x = 2, y = 10 }
		}
	},
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
		if card.ability.extra.waiting then
			if card.ability.extra.xmult == 1.0 then
				return { key = "j_SEMBY_infoboard", vars = {
					card.ability.extra.mult
				} }
			else
				return { key = "j_SEMBY_glitched_infoboard", vars = {
					card.ability.extra.mult,
					card.ability.extra.xmult
				} }
			end
		else
			return { vars = {
				card.ability.extra.xmult,
				card.ability.extra.mult
			} }
		end
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
		if context.joker_main then
			return {
				mult = card.ability.extra.mult,
				xmult = card.ability.extra.xmult
			}
        end
		if context.after and not context.blueprint then
			if card.ability.extra.mult > card.ability.extra.mult_mod then
				card.ability.extra.mult = card.ability.extra.mult - card.ability.extra.mult_mod
                return {
                    message = localize { type = 'variable', key = 'a_mult_minus', vars = { 1 } },
                    colour = G.C.RED
                }
			else
				card.ability.extra.mult = card.ability.extra.mult_reset
				card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_mod
				-- Transform/Upgrade
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.2,
					func = function()
						card:juice_up(0.2, 0.3)
						play_sound('tarot1', 1.1, 1.0)
						return true
					end
				}))
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.4,
					func = function()
						card:juice_up(0.2, -0.3)
						play_sound('tarot1', 1.2, 1.0)
						return true
					end
				}))
				delay(0.4)
				if card.ability.extra.waiting then
					card.ability.extra.waiting = false
					G.E_MANAGER:add_event(Event({
						func = function()
							play_sound('explosion_release1', 1.2, 0.8)
							card.ability.extra.pos_overwrite.y = card.ability.extra.pos_valid.mod
							card.children.center:set_sprite_pos(card.ability.extra.pos_overwrite)
							return true
						end
					}))
					return {
						message = localize('SEMBY_hype_start'),
						colour = G.C.GREEN
					}
				else
					G.E_MANAGER:add_event(Event({
						func = function()
							play_sound('foil2', 1.1, 0.8)
							return true
						end
					}))
					return {
						message = localize('SEMBY_level_up_ex'),
						colour = G.C.GREEN
					}
				end
			end
		end
    end
}
