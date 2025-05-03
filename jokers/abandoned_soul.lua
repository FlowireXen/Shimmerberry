SMODS.Joker {
	key = "abandoned_soul",
	loc_txt = {
		name = "Abandoned Soul",
		text = {
			"This Joker gains {X:chips,C:white}X#1#{} Chips every",
			"time a {C:attention}Playing card{} is destroyed",
			"{C:inactive}(Currently {X:chips,C:white}X#2#{}{C:inactive} Chips){}"
		}
	},
	rarity = 3,
	blueprint_compat = true,
	eternal_compat = true,
	atlas = "SEMBY_jokers",
	pos = { x = 5, y = 0 },
	cost = 10,
	config = {
		Xchip_gain = 0.05,
		Xchip = 1.0,
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.Xchip_gain, card.ability.Xchip } }
	end,
	calculate = function(self, card, context)
		if context.remove_playing_cards and not context.blueprint then
			G.E_MANAGER:add_event(Event({
				func = function()
					G.E_MANAGER:add_event(Event({
						func = function()
							card.ability.Xchip = card.ability.Xchip + #context.removed*card.ability.Xchip_gain
							return true
						end
					}))
					card_eval_status_text(card, 'extra', nil, nil, nil, { message = localize{ type = 'variable', key = 'a_xchips', vars = { card.ability.Xchip + #context.removed*card.ability.Xchip_gain } } })
					return true
				end
			}))
			return
		end
		if context.joker_main then
			return {
				xchips = card.ability.Xchip
			}
		end
	end
}
