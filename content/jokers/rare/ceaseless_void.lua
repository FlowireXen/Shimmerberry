SMODS.Joker {
	key = "ceaseless_void",
	name = "SEMBY_ceaseless_void",
	atlas = "SEMBY_jokers",
	pos = { x = 5, y = 1 },
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = false,
    blueprint_compat = true,
	rarity = 3,
	cost = 9,
	config = {
		extra = {
			scale   = 0, scale_mod  = 1.00, -- 0
			chips   = 0, chips_mod  =   25, -- 1
			mult    = 0, mult_mod   =    5, -- 2
			xchips  = 1, xchips_mod =  0.2, -- 3
			xmult   = 1, xmult_mod  =  0.2, -- 4
		}
	},
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
		return { vars = {
			card.ability.extra.scale * 100,
			card.ability.extra.chips,
			card.ability.extra.mult,
			card.ability.extra.xchips,
			card.ability.extra.xmult,
		} }
	end,
    add_to_deck = function(self, card, from_debuff)
		if not from_debuff then card.ability.extra.last_ID = 0 end
	end,
	calculate = function(self, card, context)
        if context.selling_card and not (context.blueprint) and context.card.ability.set == "Joker" then
			if context.selling_self or context.card == card then return nil, false end
			local statID = pseudorandom("SEMBY_ceaseless_void", 1, 4)
			if statID == (card.ability.extra.last_ID or 0) then -- Blind Size
				card.ability.extra.last_ID = 0
				card.ability.extra.scale = card.ability.extra.scale + card.ability.extra.scale_mod
            	return {
            	    message = localize{ type = 'variable', key = 'SEMBY_up_blind_size', vars = { card.ability.extra.scale_mod * 100 } },
            	    colour = G.C.SEMBY_PERCENT
            	}
			else
				card.ability.extra.last_ID = statID
				if statID == 1 then -- Chips
					card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_mod
					return { -- "a_chips" just says "+123" and that's not enough for me :)
						message = localize{ type = 'variable', key = 'SEMBY_up_chips', vars = { card.ability.extra.chips_mod } },
						colour = G.C.CHIPS
					}
				elseif statID == 2 then -- Mult
					card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
					return {
						message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult_mod } },
						colour = G.C.MULT
					}
				elseif statID == 3 then -- Xchips
					card.ability.extra.xchips = card.ability.extra.xchips + card.ability.extra.xchips_mod
					return {
						message = localize{ type = 'variable', key = 'a_xchips', vars = { card.ability.extra.xchips_mod } },
						colour = (G.C.XCHIPS or G.C.CHIPS)
					}
				elseif statID == 4 then -- Xmult
					card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_mod
					return {
						message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult_mod } },
						colour = (G.C.XMULT or G.C.MULT)
					}
				end
			end
        end
		if context.setting_blind and not (self.getting_sliced or context.blueprint) and card.ability.extra.scale ~= 0 then
			SEMBY_Increase_Blindsize(card.ability.extra.scale, (context.blueprint_card or card), true)
			return nil, true
        end
		if context.joker_main then
			return {
				chips = card.ability.extra.chips,
				mult = card.ability.extra.mult,
				xchips = card.ability.extra.xchips,
				xmult = card.ability.extra.xmult
			}
        end
	end
}
