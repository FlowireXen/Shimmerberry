SMODS.Joker {
	key = "hemoturgy",
	name = "SEMBY_hemoturgy",
	atlas = "SEMBY_jokers",
	pos = { x = 7, y = 4 },
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
	rarity = 3,
	cost = 7,
	config = {
		extra = {
			discard_size = 1,
			discard_limit = 2
		}
	},
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
		return { vars = {
			card.ability.extra.discard_size,
			card.ability.extra.discard_limit
		} }
	end,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.discard_size
        ease_discard(-card.ability.extra.discard_size)
		SMODS.change_discard_limit(-card.ability.extra.discard_limit)
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.discard_size
        ease_discard(card.ability.extra.discard_size)
		SMODS.change_discard_limit(card.ability.extra.discard_limit)
    end,
    calculate = function(self, card, context)
        if context.discard then
			local juice_card = (context.blueprint_card or card)
			-- Initial Visuals
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.2,
				func = function()
					context.other_card:flip()
					juice_card:juice_up(0.1, 0.1)
					play_sound('card1', math.random()*0.2 + 0.85, 0.5)
					return true
				end
			}))
			-- Actual Change
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.4,
				func = function()
					-- Check existing Modifiers
					local has_enhancement = false
					if next(SMODS.get_enhancements(context.other_card)) then
						has_enhancement = true
					end
					local has_edition = false
					if context.other_card.edition then
						has_edition = true
					end
					local has_seal = false
					if context.other_card:get_seal() then
						has_seal = true
					end
					-- First: Get a Random Value, then check Modifier
					-- Check: Modifier already Present? Move to next!
					local discard_mod = pseudorandom("SEMBY_discard_test_2")
					if discard_mod > 0.50 and not has_enhancement then
						discard_mod = 1
					elseif discard_mod > 0.15 and not has_edition then
						discard_mod = 2
					elseif not has_seal then
						discard_mod = 3
					elseif discard_mod > 0.15 and not has_enhancement then
						discard_mod = 1
					elseif not has_edition then
						discard_mod = 2
					elseif not has_enhancement then
						discard_mod = 1
					else
						discard_mod = 0
					end
					-- Apply Effect,
					-- Return Value
					-- and Visuals
					local ret_key
					local ret_col
					local ret_scl
					if discard_mod == 1 then
						context.other_card:set_ability(SMODS.poll_enhancement{ guaranteed = true }, false, false)
						ret_key = 'SEMBY_enhancement'
						ret_scl = 0.6
						ret_col = G.C.SECONDARY_SET.Enhanced
						play_sound('generic1', 1.0, 0.8)
					elseif discard_mod == 2 then
						context.other_card:set_edition(poll_edition(nil, nil, false, true), false, true)
						ret_key = 'k_edition'
						ret_scl = 0.8
						ret_col = G.C.DARK_EDITION
						play_sound('foil1', math.random()*0.4 + 0.95, 0.8)
					elseif discard_mod == 3 then
						context.other_card:set_seal(SMODS.poll_seal{ guaranteed = true }, true, false)
						ret_key = 'SEMBY_seal'
						ret_scl = 0.8
						ret_col = G.C.IMPORTANT
						play_sound('gold_seal', 1.0, 0.8)
					else
						ret_key = 'SEMBY_unchanged'
						ret_scl = 0.6
						ret_col = G.C.UI.TEXT_INACTIVE
						play_sound('cancel', 1.0, 0.8)
					end
					context.other_card:juice_up(0.2, 0.5)
					juice_card:juice_up(0.1, -0.1)
					attention_text({
						text = localize(ret_key),
						backdrop_colour = ret_col,
						scale = ret_scl,
						hold = 0.6,
						major = context.other_card,
						align = 'cm',
						offset = { x = 0, y = 0 }
					})
					return true
				end
			}))
			-- Final Visuals
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.4,
				func = function()
					context.other_card:flip()
					juice_card:juice_up(0.1, 0.1)
					play_sound('card1', math.random()*0.2 + 1.05, 0.5)
					return true
				end
			}))
			-- Delay for Better Animation between each Card (and Blueprint)
			delay(0.45)
			return nil, true
        end
    end
}
