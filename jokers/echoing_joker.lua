SMODS.Joker{
	key = "echoing_joker",
	loc_txt = {
		name = "Echoing Joker",
        text = {
			"Duplicate the next used",
			"{C:attention}Consumable{} {C:green}#1#{} time#2#"
        }
	},
    atlas = 'SEMBY_jokers',
    pos = { x = 1, y = 0 },
    rarity = 3,
    cost = 12,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = false,
	loc_vars = function(self, info_queue, card)
		local retval = ""
		if G.GAME.probabilities.normal and G.GAME.probabilities.normal > 1 then
			retval = "s"
		end
		return { vars = { (G.GAME.probabilities.normal or 1), retval } }
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
			
			G.E_MANAGER:add_event(Event({
				func = function()
					play_sound('tarot1')
					card:juice_up(0.3, 0.4)
					if destroy == true then
						G.E_MANAGER:add_event(Event({
							trigger = 'after',
							blockable = false,
							func = function()
								G.jokers:remove_card(card)
								card:remove()
								card = nil
								return true;
							end
						}))
					end
					return true
				end
			}))
			
			return {
				message = 'Echoed!'
			}
        end
    end
}
