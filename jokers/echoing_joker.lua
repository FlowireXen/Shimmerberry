SMODS.Joker{
	key = "echoing_joker",
	name = "SEMBY_echoing_joker",
    atlas = 'SEMBY_jokers',
    pos = { x = 1, y = 0 },
    rarity = 3,
    cost = 12,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = false,
	loc_vars = function(self, info_queue, card)
		if G.GAME.probabilities.normal and G.GAME.probabilities.normal > 1 then
			return { key = "j_SEMBY_echoing_joker_multiple", vars = { (G.GAME.probabilities.normal or 1) } }
		else
			return { key = "j_SEMBY_echoing_joker_one" }
		end
	end,
    calculate = function(self, card, context)
        if context.using_consumeable then
			local consumeable = context.consumeable
			local probability = G.GAME.probabilities.normal
			local destroy = true
			
			if probability and probability <= 0 then
				probability = 1
			end
			if context.blueprint then
				card = context.blueprint_card
				destroy = false
			end
			
			G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + probability
			for i = 1, probability do
				G.E_MANAGER:add_event(Event({
					trigger = 'before',
					delay = 0.3,
					func = function()
						local echo = copy_card(consumeable, nil, nil, nil, nil)
						echo:set_edition('e_negative', true)
						echo.sell_cost = to_big(0)
						echo:add_to_deck()
						G.consumeables:emplace(echo)
						G.GAME.consumeable_buffer = G.GAME.consumeable_buffer - 1
						return true;
					end
				}))
			end
			
			card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('SEMBY_eval_echoing_joker'), colour = G.C.ATTENTION})
			if destroy == true then
				G.E_MANAGER:add_event(Event({
					func = function()
						delay(0.5)
						G.E_MANAGER:add_event(Event({
							trigger = 'after',
							blockable = false,
							func = function()
								G.jokers:remove_card(card)
								card:start_dissolve()
								--card:remove()
								card = nil
								return true;
							end
						}))
						return true
					end
				}))
			end
			
			return
        end
    end
}
