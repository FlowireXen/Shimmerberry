-- Known "Issue" (won't be fixed):
-- Has no Duplicate Protection, when you have two Buttons, Death will reroll you twice.
SMODS.Joker {
	key = "emergency_button",
	name = "SEMBY_emergency_button",
	atlas = "SEMBY_jokers",
	pos = { x = 2, y = 1 },
    unlocked = true,
    discovered = false,
    eternal_compat = false,
    perishable_compat = true,
    blueprint_compat = false,
	rarity = 2,
	cost = 6,
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
	end,
	calculate = function(self, card, context)
        if context.end_of_round and context.game_over and context.main_eval and not context.blueprint then
			if (G.hand and #G.hand.cards == 0)
			and (G.deck and #G.deck.cards == 0)
			then -- Won't save you:
				G.E_MANAGER:add_event(Event({
					blockable = false,
					func = function()
						card:juice_up(0.2, 0.1)
						play_sound('tarot1')
						card:set_debuff(true)
						return true
					end
				}))
				return nil, false
			else -- Get Saved:
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
							if not SMODS.is_eternal(G.consumeables.cards[i], card) then
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
							else
								G.consumeables.cards[i]:juice_up(0.2, 0.1)
								play_sound('tarot'..math.random(1, 2))
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
							if not SMODS.is_eternal(G.jokers.cards[i], card) then
								-- Get Rarity
								local rarity = G.jokers.cards[i].config.center.rarity
								if     rarity == 4 then rarity = 2.0
								elseif rarity == 3 then rarity = 1.0
								elseif rarity == 2 then rarity = 0.8
								elseif rarity == 1 then rarity = 0.5
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
							else
								G.jokers.cards[i]:juice_up(0.2, 0.1)
								play_sound('tarot'..math.random(1, 2))
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
	end
}
