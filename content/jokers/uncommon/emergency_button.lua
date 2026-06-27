SMODS.Joker {
	key = "emergency_button",
	SEMBY_art = "flowire",
	atlas = "SEMBY_jokers_1",
	pos = { x = 1, y = 3 },
    eternal_compat = false,
    perishable_compat = true,
    blueprint_compat = false,
	rarity = 2,
	cost = 6,
    attributes = {
		'prevents_death', 'joker', 'generation', 'destroy_card',
		'consumable'
	},
	calculate = function(self, card, context)
        if context.end_of_round and context.game_over and context.main_eval and not context.blueprint then
			-- Announce
			G.E_MANAGER:add_event(Event({
				func = function()
					G.hand_text_area.blind_chips:juice_up()
					G.hand_text_area.game_chips:juice_up()
					return true
				end
			}))
			card_eval_status_text(card, 'extra', nil, nil, nil, {
				--message = localize('SEMBY_emergency_meeting'),
				message = localize('k_saved_ex'),
				colour = G.C.RED
			})
			-- Consumables
			for i = #G.consumeables.cards, 1, -1 do
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.8,
					func = function()
						if SMODS.is_eternal(G.consumeables.cards[i], card)
						or G.consumeables.cards[i].ability.SEMBY_shimmer_immune
						then
							G.consumeables.cards[i]:juice_up(0.2, 0.2)
							play_sound('tarot'..math.random(1, 2))
							attention_text({
								text = localize('SEMBY_immune_ex'),
								backdrop_colour = G.C.RED,
								scale = 1.0, hold = 0.8,
								major = G.consumeables.cards[i],
								align = 'cm', offset = { x = 0, y = 0 }
							})
						else
							-- Create New Consumable
							local new_con = SMODS.create_card({
								set = G.consumeables.cards[i].ability.set,
								edition = (G.consumeables.cards[i].edition and G.consumeables.cards[i].edition.key),
								soulable = true,
								allow_duplicates = true,
								skip_materialize = true
							})
							new_con.states.visible = nil
							-- Delete Old Consumable
							G.consumeables.cards[i]:flip()
							G.consumeables.cards[i]:start_dissolve({{0.8, 0.2, 0.2, 1}, {1, 0.5, 0.5, 1}}, false, 2.0, true)
							-- Emplace New Consumable
							G.E_MANAGER:add_event(Event({
								blockable = false,
								trigger = 'after',
								delay = 1.5,
								func = function()
									new_con:add_to_deck()
									new_con:start_materialize({{0.2, 0.8, 0.2, 1}, {0.5, 1, 0.5, 1}}, true, 2.0)
									G.consumeables:emplace(new_con)
									return true
								end
							}))
						end
						return true
					end
				}))
			end
			-- Jokers
			for i = #G.jokers.cards, 1, -1 do
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.8,
					func = function()
						if SMODS.is_eternal(G.jokers.cards[i], card)
						or G.jokers.cards[i].ability.SEMBY_shimmer_immune
						then
							G.jokers.cards[i]:juice_up(0.2, 0.2)
							play_sound('tarot'..math.random(1, 2))
							attention_text({
								text = localize('SEMBY_immune_ex'),
								backdrop_colour = G.C.RED,
								scale = 1.0, hold = 0.8,
								major = G.jokers.cards[i],
								align = 'cm', offset = { x = 0, y = 0 }
							})
						else
							-- Get Rarity
							local rarity = G.jokers.cards[i].config.center.rarity
							if type(rarity) == "number" then
								if     rarity == 4 then rarity = 2.0
								elseif rarity == 3 then rarity = 1.0
								elseif rarity == 2 then rarity = 0.8
								elseif rarity == 1 then rarity = 0.5
								end -- Keep current pony ;3
							end
							-- Create New Joker
							local new_joke = SMODS.create_card({
								set = G.jokers.cards[i].ability.set,
								legendary = (rarity == 2.0),
								rarity = rarity,
								edition = (G.jokers.cards[i].edition and G.jokers.cards[i].edition.key),
								soulable = true,
								allow_duplicates = true,
								skip_materialize = true
							})
							new_joke.states.visible = nil
							-- Delete Old Joker
							G.jokers.cards[i]:flip()
							G.jokers.cards[i]:start_dissolve({{0.8, 0.2, 0.2, 1}, {1, 0.5, 0.5, 1}}, false, 2.0, true)
							-- Emplace New Joker
							G.E_MANAGER:add_event(Event({
								blockable = false,
								trigger = 'after',
								delay = 1.5,
								func = function()
									new_joke:add_to_deck()
									new_joke:start_materialize({{0.2, 0.8, 0.2, 1}, {0.5, 1, 0.5, 1}}, true, 2.0)
									G.jokers:emplace(new_joke)
									return true
								end
							}))
						end
						return true
					end
				}))
			end
			-- Done;
			return {
				saved = 'SEMBY_emergency_meeting'
			}
        end
	end
}
