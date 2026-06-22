SMODS.Consumable {
    key = 'eden_spawner',
    SEMBY_art = "placeholder",
	atlas = "SEMBY_consumables",
    pos = { x = 0, y = 0 },
    set = "Spectral",
	disable_shine = true,
	set_card_type_badge = function(self, card, badges)
 		badges[#badges+1] = create_badge(localize('SEMBY_eden_token'), SMODS.Gradients.SEMBY_EDEN, G.C.WHITE, 1.2)
	end,
	cost = 1,
    config = {
		extra_slots_used = -1,
		SEMBY_price_mod = -1
    },
    loc_vars = function(self, info_queue, card)
		if Shimmerberry.config.eden_enabled then
			if G.GAME.challenge then
				return { key = 'c_SEMBY_eden_spawner_alt_2' }
			else
				info_queue[#info_queue + 1] = { key = "SEMBY_eden_info", set = "Other" }
				return { vars = {
					Shimmerberry.config.eden_infinite and localize('SEMBY_infinite')
					or Shimmerberry.config.eden_tokens['P'..G.SETTINGS.profile]
				} }
			end
		else
			return { key = 'c_SEMBY_eden_spawner_alt_1' }
		end
    end,
	calculate = function(self, card, context)
		if context.end_of_round and context.main_eval and context.game_over == false and G.GAME.blind.boss then
    		G.E_MANAGER:add_event(Event({
				trigger = 'after',
				blocking = false,
    		    func = function()
    		        card:juice_up()
    		        play_sound('cancel')
					play_sound('whoosh2', math.random()*0.2 + 0.6, 0.8)
					card:start_dissolve({G.C.RED, G.C.BLUE, G.C.PURPLE}, true, 2.0, true)
    		        return true
    		    end
    		}))
			return
		end
	end,
    use = function(self, card, area, copier)
		if Shimmerberry.config.eden_infinite or SEMBY_Eden_Token() > 0 then
			-- Sound and Text
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				func = function()
					play_sound('SEMBY_holy_explosion', 1.2, 1.0)
					attention_text({
						text = '-1 '..localize('SEMBY_eden_token'),
						backdrop_colour = SMODS.Gradients.SEMBY_EDEN,
						scale = 1.0, hold = 1.0, major = card,
						align = 'bm', offset = { x = 0, y = 0 }
					})
					return true
				end
			}))
			-- Destroy Card
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.25,
				func = function()
					card:juice_up()
					card:start_dissolve({G.C.RED, G.C.BLUE, G.C.PURPLE}, true, 1.2, true)
					return true
				end
			}))
			-- Create Card
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.25,
				func = function()
					card.area:remove_card(card)
					-- Create Joker (2% Legendary Chance)
					local blessing = SMODS.create_card({
						set = 'Joker', skip_materialize = true, no_edition = true, stickers = { },
						legendary = SMODS.pseudorandom_probability(card, 'SEMBY_eden_token', 2, 100, nil, true)
					})
					blessing.ability.SEMBY_price_mod = -blessing.cost
					blessing:set_cost()
					blessing:add_to_deck()
					G.jokers:emplace(blessing)
					blessing:start_materialize({G.C.RED, G.C.BLUE, G.C.PURPLE})
					-- Use Token & Save Game
					if not Shimmerberry.config.eden_infinite then
						SEMBY_Eden_Token(-1)
	    	        	save_run()
					end
					return true
				end
			}))
		else
			-- Text
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				func = function()
					attention_text({
						text = localize('SEMBY_eden_empty'),
						backdrop_colour = SMODS.Gradients.SEMBY_EDEN,
						scale = 1.0, hold = 1.0, major = card,
						align = 'bm', offset = { x = 0, y = 0 }
					})
					return true
				end
			}))
			-- Sound & Destroy Card
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.25,
				func = function()
    		        card:juice_up()
    		        play_sound('cancel')
					play_sound('whoosh2', math.random()*0.2 + 0.6, 0.8)
					card:start_dissolve({G.C.RED, G.C.BLUE, G.C.PURPLE}, true, 2.0, true)
					return true
				end
			}))
		end
	end,
    can_use = function(self, card)
		return SEMBY_Eden_Valid() and G.jokers and #G.jokers.cards < G.jokers.config.card_limit
	end,
	keep_on_use = function(self, card)
		return true --> Manually Destroyed
	end,
    in_pool = function(self, args)
		return false
	end
}
