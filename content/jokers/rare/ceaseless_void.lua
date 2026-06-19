SMODS.Joker {
	key = "ceaseless_void",
	SEMBY_art = "unkokat",
	atlas = "SEMBY_jokers_1",
	pos = { x = 6, y = 5 },
    eternal_compat = true,
    perishable_compat = false,
    blueprint_compat = true,
	rarity = 3,
	cost = 8,
	config = {
		extra = {
			percent_mod = 0.03,
			xchips_mod = 0.02,
			xmult_mod = 0.02,
			money_mod = 1,
			percent = 0,
			xchips = 1,
			xmult = 1,
		}
	},
    attributes = {
		'joker', 'xblindsize', 'xchips', 'xmult', 'space',
		'animal',
	},
	loc_vars = function(self, info_queue, card)
		return { vars = {
			-- Mod.
			card.ability.extra.percent_mod * 100,
			card.ability.extra.xchips_mod,
			card.ability.extra.xmult_mod,
			card.ability.extra.money_mod,
			-- Val.
			card.ability.extra.percent * 100,
			card.ability.extra.xchips,
			card.ability.extra.xmult,
		} }
	end,
	calculate = function(self, card, context)
		if not context.blueprint then
        	if context.selling_card and not (context.selling_self or context.card == card) then
				local loops = math.floor(context.card.sell_cost / card.ability.extra.money_mod + 0.5)
				if loops ~= 0 then
					G.GAME.SEMBY_speed = G.GAME.SEMBY_speed or 0.5
					-- Change Stats
					local percent = 0
					local xchips = 0
					local xmult = 0
					for i = 1, loops do
						local rng = pseudorandom("SEMBY_ceaseless_void")
						if rng > 0.6 then percent = percent + card.ability.extra.percent_mod
						elseif rng > 0.3 then xchips = xchips + card.ability.extra.xchips_mod
						else xmult = xmult + card.ability.extra.xmult_mod end
					end
					card.ability.extra.percent = card.ability.extra.percent + percent
					card.ability.extra.xchips = card.ability.extra.xchips + xchips
					card.ability.extra.xmult = card.ability.extra.xmult + xmult
					-- Visuals
					if percent ~= 0 then
    					G.E_MANAGER:add_event(Event({
							trigger = 'after',
							delay = G.GAME.SEMBY_speed,
    					    func = function()
								card:juice_up(0.1, 0.2)
								play_sound('generic1', 0.8 + math.random()*0.4, 0.8)
								attention_text({
									text = localize{ type = 'variable', key = 'SEMBY_up_blind_size', vars = { percent * 100 } },
									backdrop_colour = G.C.SEMBY_PERCENT,
									scale = 0.8, hold = 0.5, align = 'bm',
									offset = { x = 0, y = 0 }, major = card
								})
    					        return true
    					    end
    					}), 'other')
					end
					if xchips ~= 0 then
    					G.E_MANAGER:add_event(Event({
							trigger = 'after',
							delay = G.GAME.SEMBY_speed,
    					    func = function()
								card:juice_up(0.1, 0.2)
								play_sound('generic1', 0.8 + math.random()*0.4, 0.8)
								attention_text({
									text = localize{ type = 'variable', key = 'a_xchips', vars = { xchips } },
									backdrop_colour = G.C.XCHIPS or G.C.CHIPS,
									scale = 0.8, hold = 0.5, align = 'bm',
									offset = { x = 0, y = 0 }, major = card
								})
    					        return true
    					    end
    					}), 'other')
					end
					if xmult ~= 0 then
    					G.E_MANAGER:add_event(Event({
							trigger = 'after',
							delay = G.GAME.SEMBY_speed,
    					    func = function()
								card:juice_up(0.1, 0.2)
								play_sound('generic1', 0.8 + math.random()*0.4, 0.8)
								attention_text({
									text = localize{ type = 'variable', key = 'a_xmult', vars = { xmult } },
									backdrop_colour = G.C.XMULT or G.C.MULT,
									scale = 0.8, hold = 0.5, align = 'bm',
									offset = { x = 0, y = 0 }, major = card
								})
    					        return true
    					    end
    					}), 'other')
					end
					delay(G.GAME.SEMBY_speed / 2, 'other')
					G.GAME.SEMBY_speed = math.max(0, G.GAME.SEMBY_speed - G.GAME.SEMBY_speed*0.1)
					G.E_MANAGER:add_event(Event({
						trigger = 'after',
						func = function()
							G.GAME.SEMBY_speed = nil
							return true
						end
					}))
				end
				return nil, true
        	end
			if context.setting_blind and card.ability.extra.percent ~= 0 and not self.getting_sliced then
				SEMBY_Increase_Blindsize(card.ability.extra.percent, (context.blueprint_card or card), true)
				return nil, true
        	end
		end
		if context.joker_main then
			return {
				xchips = card.ability.extra.xchips,
				xmult = card.ability.extra.xmult
			}, true
        end
	end
}
