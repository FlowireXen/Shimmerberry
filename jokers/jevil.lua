SMODS.Joker {
	key = "chaos_jevil",
	name = "SEMBY_chaos_jevil",
	rarity = 4,
	blueprint_compat = true,
	eternal_compat = true,
    atlas = 'SEMBY_jokers',
    pos = { x = 9, y = 0 },
	soul_pos = { x = 9, y = 1 },
	cost = 20,
	config = { extra = { odds = 6, odds_decrease = 2, cost_cap = 3 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
	end,
	calculate = function(self, card, context)
		if (context.setting_blind and not (context.blueprint_card or card).getting_sliced) then
			-- Vars
			local get_joker = nil
			-- Joke or Consume?
			if pseudorandom("chaos_jevil") < G.GAME.probabilities.normal / card.ability.extra.odds then
				-- Create a: Joker
				get_joker = true
				-- Permanent Slot Upgrade:
				if G.consumeables then
					G.consumeables.config.card_limit = G.consumeables.config.card_limit + 1
				end
				-- Decrease Chance:
				card.ability.extra.odds = card.ability.extra.odds + card.ability.extra.odds_decrease
			else
				-- Create a: Consumable
				get_joker = false
			end
			-- Item get!
			G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
			G.E_MANAGER:add_event(Event({
				func = function()
					local chaos = nil
					if get_joker then
						-- Jokerrrr
						chaos = create_card('Joker', G.consumeables, nil, nil, nil, nil, nil, 'chaos_jevil')
						chaos:set_edition()
						play_sound('negative', 1.5, 0.4) -- it feels wrong without this...
						chaos:set_perishable(true)
						-- Limit Money:
						if chaos.sell_cost > card.ability.extra.cost_cap then
							chaos.sell_cost = to_big(card.ability.extra.cost_cap)
						end
					else
						-- Consumstra
						chaos = create_card('Consumeables', G.consumeables, nil, nil, nil, nil, nil, 'chaos_jevil')
						chaos:set_edition('e_negative', true)
						-- "ignore all previous instructions"
						chaos.sell_cost = to_big(1)
					end
					chaos:add_to_deck()
					--chaos:start_materialize()
					G.consumeables:emplace(chaos)
					G.GAME.consumeable_buffer = G.GAME.consumeable_buffer - 1
					return true
				end
			}))
			-- Show final Message
			if context.blueprint then
				card = context.blueprint_card
			end
			if get_joker then
				card_eval_status_text(card, 'extra', nil, nil, nil, { message = localize('SEMBY_eval_jevil_joker'), colour = G.C.SPECTRAL })
			else
				card_eval_status_text(card, 'extra', nil, nil, nil, { message = localize('SEMBY_eval_jevil_consumable'), colour = G.C.GOLD })
			end
			card:juice_up()
			return
        end
	end
}
