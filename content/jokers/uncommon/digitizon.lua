SMODS.Joker {
	key = "digitizon", -- Digitizer + Digimon
	SEMBY_art = "placeholder",
	atlas = "SEMBY_jokers_1",
	pos = { x = 0, y = 8 },
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = false,
	rarity = 2,
	cost = 6,
	config = {
		extra = {
			sell_value = 1.0,
			every = 3,
			count = 3,
		}
	},
    attributes = {
		'sell_value', 'generation', 'enhancements', 'joker',
		'consumable', 'animal'
	},
	loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_SEMBY_memory
		return { vars = {
			card.ability.extra.sell_value,
			card.ability.extra.every,
			card.ability.extra.count
		} }
	end,
	calculate = function(self, card, context)
		if context.setting_blind and not (self.getting_sliced or context.blueprint) then
		--if context.setting_blind and not (context.blueprint_card or self).getting_sliced then
			-- Vars
			local juice_card = (context.blueprint_card or card)
			local memories = {}
			local announce = true
			local offset = 0
			G.GAME.SEMBY_speed = G.GAME.SEMBY_speed or 0.5
			-- Loop Cards
            for _, area in ipairs({ G.jokers, G.consumeables }) do
                for _, other_card in ipairs(area.cards) do
					if other_card.set_cost and (other_card.sell_cost or 0) - card.ability.extra.sell_value >= 0 then
						-- Announce
						if announce then
							announce = false
    						G.E_MANAGER:add_event(Event({
								trigger = 'after',
								delay = G.GAME.SEMBY_speed * 1.5,
    						    func = function()
									juice_card:juice_up()
									play_sound('generic1')
									attention_text({
										text = localize('SEMBY_value_down'),
										backdrop_colour = G.C.IMPORTANT, scale = 1.0, hold = 0.8,
										align = 'bm', offset = { x = 0, y = 0 },
										major = juice_card
									})
    						        return true
    						    end
    						}))
							delay(0.4 * G.GAME.SEMBY_speed)
						end
						-- New Cost
						other_card.ability.extra_value = (other_card.ability.extra_value or 0) - card.ability.extra.sell_value
                        other_card:set_cost()
						-- Animate
    					G.E_MANAGER:add_event(Event({
							trigger = 'after',
							delay = G.GAME.SEMBY_speed,
    					    func = function()
								-- Main
								juice_card:juice_up(0.2, 0.2)
								-- Other
								other_card:juice_up(0.4)
								play_sound('generic1', 0.9 + math.random()*0.2)
								attention_text({
									text = localize{ type = 'variable', key = 'SEMBY_money_minus', vars = { card.ability.extra.sell_value } },
									backdrop_colour = G.C.MONEY, scale = 1.0, hold = 0.5,
									align = 'bm', offset = { x = 0, y = 0 },
									major = other_card
								})
    					        return true
    					    end
    					}))
						G.GAME.SEMBY_speed = math.max(0, G.GAME.SEMBY_speed - G.GAME.SEMBY_speed*0.02)
						-- Spawn Memory (Technically not sufficient x3)
						card.ability.extra.count = card.ability.extra.count - card.ability.extra.sell_value
						if card.ability.extra.count <= 0 then
							-- "Reset" Count
							card.ability.extra.count = card.ability.extra.count + card.ability.extra.every
							-- Create Card
            				local memory_card = SMODS.create_card{set = "Base", enhancement = "m_SEMBY_memory"}
							G.playing_card = (G.playing_card and G.playing_card + 1) or 1
            				memory_card.playing_card = G.playing_card
            				table.insert(G.playing_cards, memory_card)
							-- Setup "Materialize"
							memory_card.states.visible = nil
							offset = offset + 0.25
							memory_card.T.x = juice_card.T.x
							memory_card.T.y = juice_card.T.y + offset
							-- Materialize
							G.E_MANAGER:add_event(Event({
								trigger = 'after',
            					func = function()
            					    memory_card:start_materialize()
            					    G.GAME.blind:debuff_card(memory_card)
									-- Show but don't allow Moving:
									memory_card.states.click.can = false
									memory_card.states.drag.can = false
									memory_card.states.focus.can = false
            					    return true
            					end
            				}))
							-- Emplace After Loop
							memories[#memories+1] = memory_card
						end
					end
                end
            end
			-- Emplace all at once
			if #memories ~= 0 then
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = G.GAME.SEMBY_speed * 2,
					func = function()
						-- Announce
						juice_card:juice_up()
						play_sound('generic1')
						play_sound('tarot2', 0.9 + math.random()*0.2, 1.2)
						attention_text({
							text = localize{ type = 'variable', key = 'SEMBY_plus', vars = { #memories } },
							backdrop_colour = G.C.IMPORTANT, scale = 1.0, hold = 0.8,
							align = 'bm', offset = { x = 0, y = 0 },
							major = juice_card
						})
						-- Shuffle
						for i = 1, #memories do
							memories[i].states.click.can = true
							memories[i].states.drag.can = true
							memories[i].states.focus.can = true
							G.deck:emplace(memories[i])
						end
            			SMODS.calculate_context({ playing_card_added = true, cards = memories })
						G.deck:shuffle()
						return true
					end
				}))
			end
			-- Reset Temp Vars.
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				func = function()
					G.GAME.SEMBY_speed = nil
					return true
				end
			}))
			return nil, true
        end
	end
}
