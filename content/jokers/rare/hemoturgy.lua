SMODS.Joker {
	key = "hemoturgy",
	SEMBY_art = "unkokat",
	atlas = "SEMBY_jokers_1",
	pos = { x = 3, y = 5 },
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
	rarity = 3,
	cost = 7,
	config = {
		extra = {
			-- Durability
			durability = 10,
			durability_max = 10,
			-- Joker
			durability_diff = 0.5,
			durability_amnt = 2,
			current_amnt = 0
		}
	},
    attributes = {
		'discard', 'enhancements', 'editions', 'seals', 'modify_card',
		'magic', 'durability'
	},
	pools = {
        ["Durability"] = true,
    },
	loc_vars = function(self, info_queue, card)
		return { vars = {
			card:SEMBY_durability_amount(),
			card.ability.extra.durability_diff,
			card.ability.extra.durability_amnt,
			colours = { card:SEMBY_durability_color() }
		} }
	end,
    calculate = function(self, card, context)
		if context.pre_discard and not context.blueprint then
			card.ability.extra.current_amnt = card.ability.extra.durability_amnt
		end
		if context.discard and context.other_card then
			local other_card = context.other_card
			if not (
				other_card.SEMBY_removed or
				other_card.getting_sliced or
				other_card.shattered or
				other_card.destroyed
			) then
				if not other_card.SEMBY_hemoturgy then
					other_card.SEMBY_hemoturgy = {}
					if not next(SMODS.get_enhancements(other_card)) then
						table.insert(other_card.SEMBY_hemoturgy, 'enhancement')
					end
					if not other_card.edition then
						table.insert(other_card.SEMBY_hemoturgy, 'edition')
					end
					if not other_card:get_seal() then
						table.insert(other_card.SEMBY_hemoturgy, 'seal')
					end
				end
				if #other_card.SEMBY_hemoturgy ~= 0 then
					if context.blueprint or card.ability.extra.current_amnt > 0 or card.ability.extra.durability - 1 >= 0 then
						local change = table.remove(other_card.SEMBY_hemoturgy, pseudorandom("SEMBY_hemoturgy", 1, #other_card.SEMBY_hemoturgy))
						-- Flip Card
						local juice_card = (context.blueprint_card or card)
						G.E_MANAGER:add_event(Event({
							trigger = 'after',
							delay = 0.2,
							func = function()
								other_card:flip()
								juice_card:juice_up(0.1, 0.2)
								play_sound('card1', math.random()*0.2 + 0.85, 0.5)
								return true
							end
						}))
						-- Apply Modifier
						G.E_MANAGER:add_event(Event({
							trigger = 'after',
							delay = 0.4,
							func = function()
								local ret_key, ret_col, ret_scl
								if change == 'enhancement' then
									other_card:set_ability(SMODS.poll_enhancement{ guaranteed = true }, false, false)
									other_card.SEMBY_hemoturgy = true
									ret_key = 'SEMBY_enhancement'
									ret_col = G.C.SECONDARY_SET.Enhanced
									ret_scl = 0.6
									play_sound('generic1', 1.0, 0.8)
								elseif change == 'edition' then
									other_card:set_edition(poll_edition(nil, nil, false, true), false, true)
									other_card.SEMBY_hemoturgy = true
									ret_key = 'k_edition'
									ret_col = G.C.DARK_EDITION
									ret_scl = 0.8
									play_sound('foil1', math.random()*0.4 + 0.95, 0.8)
								elseif change == 'seal' then
									other_card:set_seal(SMODS.poll_seal{ guaranteed = true }, true, false)
									other_card.SEMBY_hemoturgy = true
									ret_key = 'SEMBY_seal'
									ret_col = G.C.IMPORTANT
									ret_scl = 0.8
									play_sound('gold_seal', 1.0, 0.8)
								end
								other_card:juice_up(0.2, 0.2)
								juice_card:juice_up(0.1, 0.2)
								attention_text({
									text = localize(ret_key),
									backdrop_colour = ret_col,
									scale = ret_scl,
									hold = 0.6,
									major = other_card,
									align = 'tm',
									offset = { x = 0, y = 0 }
								})
								return true
							end
						}))
						-- Unflip Card
						G.E_MANAGER:add_event(Event({
							trigger = 'after',
							delay = 0.4,
							func = function()
								other_card:flip()
								juice_card:juice_up(0.1, 0.2)
								play_sound('card1', math.random()*0.2 + 1.05, 0.5)
								return true
							end
						}))
						-- Durability
						if not context.blueprint then
                    	    card:SEMBY_durability_use(card.ability.extra.current_amnt > 0 and card.ability.extra.durability_diff)
							if card.ability.extra.durability <= 0 then card.ability.extra.current_amnt = 0
							else card.ability.extra.current_amnt = card.ability.extra.current_amnt - 1 end
							card:SEMBY_durability_check()
						else delay(1.0) end
					end
				end
				G.E_MANAGER:add_event(Event({
					func = function()
						other_card.SEMBY_hemoturgy = nil
						return true
					end
				}))
			end
			return nil, true
		end
    end
}
