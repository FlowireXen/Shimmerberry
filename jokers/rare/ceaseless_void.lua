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
			scale = 0.0,
			chips = 20,
			mult = 0,
			xchips = 1.0,
			xmult = 1.0,
			dollar = 0,
			probability = {
				scale = 0.10,  -- fallback
				chips = 0.16,
				mult = 0.21,   -- priority
				xchips = 0.16,
				xmult = 0.21,  -- priority
				dollar = 0.16,
			},
			arithmetic = {
				prob_smoll = 0.01, -- smallest change
				prob_large = 0.06, -- smallest change * amount of change (6)
				-- (arithmetic)
				scale = 2.0,
				chips = 20,
				mult = 4,
				xchips = 0.2,
				xmult = 0.2,
				dollar = 1.2,
			},
			bonus = {
				dollar = 0,
			}
		}
	},
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
		-- Return
		return { vars = {
			card.ability.extra.scale * 100,
			card.ability.extra.chips,
			card.ability.extra.mult,
			card.ability.extra.xchips,
			card.ability.extra.xmult,
			card.ability.extra.dollar == 0 and G.GAME.SEMBY_ceased_money and '-' or math.floor(card.ability.extra.dollar)
		} }
	end,
	calculate = function(self, card, context)
        if context.selling_card and not (context.blueprint) and context.card.ability.set == "Joker" then
			-- Early Exit
			if context.selling_self
			or context.card == card
			then return nil, false end
			
			-- Ceaseless Void
			local rand = pseudorandom("SEMBY_ceaseless_void")
		
			-- Determine Probability Ranges
			-- Note: If something is minus, "dollar" gets shafted
			local scale = 0.0
			if card.ability.extra.probability.scale > 0 then scale = card.ability.extra.probability.scale end
			local chips = scale
			if card.ability.extra.probability.chips > 0 then chips = chips + card.ability.extra.probability.chips end
			local mult = chips
			if card.ability.extra.probability.mult > 0 then mult = mult + card.ability.extra.probability.mult end
			local xchips = mult
			if card.ability.extra.probability.xchips > 0 then xchips = xchips + card.ability.extra.probability.xchips end
			local xmult = xchips
			if card.ability.extra.probability.xmult > 0 then xmult = xmult + card.ability.extra.probability.xmult end
			local dollar = xmult
			if card.ability.extra.probability.dollar > 0 then dollar = dollar + card.ability.extra.probability.dollar end
			
			-- Increase All
			card.ability.extra.probability.scale = card.ability.extra.probability.scale + card.ability.extra.arithmetic.prob_smoll
			card.ability.extra.probability.chips = card.ability.extra.probability.chips + card.ability.extra.arithmetic.prob_smoll
			card.ability.extra.probability.xchips = card.ability.extra.probability.xchips + card.ability.extra.arithmetic.prob_smoll
			card.ability.extra.probability.mult = card.ability.extra.probability.mult + card.ability.extra.arithmetic.prob_smoll
			card.ability.extra.probability.xmult = card.ability.extra.probability.xmult + card.ability.extra.arithmetic.prob_smoll
			card.ability.extra.probability.dollar = card.ability.extra.probability.dollar + card.ability.extra.arithmetic.prob_smoll
			
			-- Decrease One (Change Selected Stat)
			if rand >= scale then
				if rand < chips then
					card.ability.extra.probability.chips = card.ability.extra.probability.chips - card.ability.extra.arithmetic.prob_large
					card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.arithmetic.chips
					return {
						-- "a_chips" just says "+123" and that's not enough :)
						message = localize{ type = 'variable', key = 'SEMBY_up_chips', vars = { card.ability.extra.arithmetic.chips } },
						colour = G.C.CHIPS
					}
				elseif rand < mult then
					card.ability.extra.probability.mult = card.ability.extra.probability.mult - card.ability.extra.arithmetic.prob_large
					card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.arithmetic.mult
					return {
						message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.arithmetic.mult } },
						colour = G.C.MULT
					}
				elseif rand < xchips then
					card.ability.extra.probability.xchips = card.ability.extra.probability.xchips - card.ability.extra.arithmetic.prob_large
					card.ability.extra.xchips = card.ability.extra.xchips + card.ability.extra.arithmetic.xchips
					return {
						message = localize{ type = 'variable', key = 'a_xchips', vars = { card.ability.extra.arithmetic.xchips } },
						colour = (G.C.XCHIPS or G.C.CHIPS)
					}
				elseif rand < xmult then
					card.ability.extra.probability.xmult = card.ability.extra.probability.xmult - card.ability.extra.arithmetic.prob_large
					card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.arithmetic.xmult
					return {
						message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.arithmetic.xmult } },
						colour = G.C.XMULT
					}
				elseif rand < dollar then
					card.ability.extra.probability.dollar = card.ability.extra.probability.dollar - card.ability.extra.arithmetic.prob_large
					if not G.GAME.SEMBY_ceased_money then
						card.ability.extra.dollar = card.ability.extra.dollar + card.ability.extra.arithmetic.dollar
						return {
							message = localize{ type = 'variable', key = 'SEMBY_up_payout', vars = { math.floor(card.ability.extra.arithmetic.dollar) } },
							colour = G.C.MONEY
						}
					end
				end
			else
				card.ability.extra.probability.scale = card.ability.extra.probability.scale - card.ability.extra.arithmetic.prob_large
			end
			-- Blind Size & Fallback
			card.ability.extra.scale = card.ability.extra.scale +
				(G.GAME.SEMBY_ceased_money and card.ability.extra.arithmetic.scale * 0.5 or card.ability.extra.arithmetic.scale)
            return {
                message = localize{ type = 'variable', key = 'SEMBY_up_blind_size', vars = {
					(G.GAME.SEMBY_ceased_money and card.ability.extra.arithmetic.scale * 50 or card.ability.extra.arithmetic.scale * 100)
				} },
                colour = G.C.SEMBY_PERCENT
            }
        end
		if context.setting_blind and not (self.getting_sliced or context.blueprint) and card.ability.extra.scale ~= 0 then
		--if context.setting_blind and not (context.blueprint_card or self).getting_sliced then
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
		if context.end_of_round and context.cardarea == G.jokers and context.blueprint then
			if G.GAME.SEMBY_ceased_money then return nil, false end
			if card.ability.extra.dollar ~= 0 then
				card.ability.extra.bonus.dollar = card.ability.extra.bonus.dollar + card.ability.extra.dollar
				return {
					message = localize{ type = 'variable', key = 'SEMBY_up_payout', vars = { math.floor(card.ability.extra.dollar) } },
					colour = G.C.MONEY
				}
			end
		end
	end,
    calc_dollar_bonus = function(self, card)
		if card.ability.extra.dollar ~= 0 then
			local dollar = math.floor(card.ability.extra.dollar + card.ability.extra.bonus.dollar)
			card.ability.extra.bonus.dollar = 0
			return dollar
		end
    end
}

--[[-- Could be reworked roughly:

probability = {
    scale = 10,
    chips = 16,
    mult = 21,
    xchips = 16,
    xmult = 21,
    dollar = 16
}

local max_index = 0
local for_val = 0
for type, value in pairs(probability)
    if value then
        max_index = max_index + 1
        value = value + 1
        for_val = for_val + value
    end
end

local rand = pseudorandom("SEMBY_ceaseless_void", 0, for_val)

for_val = 0
local ret_type = nil
for type, value in pairs(probability)
    if value then
        for_val = for_val + value
        if rand < for_val then
            ret_type = type
            value = value - max_index
            break
        end
    end
end

--> able to use ret_type now

--]]
