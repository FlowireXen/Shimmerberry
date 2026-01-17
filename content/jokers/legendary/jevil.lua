SMODS.Joker {
	key = "jevil",
	name = "SEMBY_jevil",
    atlas = 'SEMBY_jokers',
    pos = { x = 1, y = 6 },
	soul_pos = { x = 1, y = 7 },
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
	rarity = 4,
	cost = 20,
	config = {
		card_limit = 2
	},
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
		info_queue[#info_queue + 1] = { key = "SEMBY_degrading", set = "Other",
			vars = { G.GAME.perishable_rounds, G.GAME.perishable_rounds }
		}
		return { vars = {
			card.ability.card_limit
		} }
	end,
    add_to_deck = function(self, card, from_debuff)
		-- Move Card to Consumable-Area
		if not from_debuff then
			G.E_MANAGER:add_event(Event({
				func = function()
					if card.area and card.area ~= G.consumeables then
						card.area:remove_card(card)
						card:add_to_deck()
						G.consumeables:emplace(card)
					end
					return true
				end
			}))
		end
    end,
	calculate = function(self, card, context)
        if context.using_consumeable then
			local message_state = false
			if G.consumeables and #G.consumeables.cards > 1
			and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit
			then
				local consumeables = {}
				-- Get Valid Cards
				for _, consumable in ipairs(G.consumeables.cards) do
					if consumable.ability.set ~= "Joker"
					and consumable.config.center.key ~= context.consumeable.config.center.key
					and not (consumable.ability.SEMBY_degrading_tally and consumable.ability.SEMBY_degrading_tally <= 1)
					then consumeables[#consumeables+1] = consumable end
				end
				if #consumeables > 0 then
					-- Choose, Degrade and Copy Card
					local chaos_card = pseudorandom_element(consumeables, 'chaos_jevil')
					chaos_card.ability.SEMBY_degrading_tally = (chaos_card.ability.SEMBY_degrading_tally or G.GAME.perishable_rounds) - 1
					local chaos_copy = copy_card(chaos_card, nil, nil, G.playing_card)
					-- Add Copy to Deck
					chaos_copy:add_to_deck()
					G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
					table.insert(G.consumeables, chaos_copy)
					chaos_copy.states.visible = nil
					-- Event for Animation;
					G.E_MANAGER:add_event(Event({
						func = function()
							-- Apply Sticker
							chaos_card:add_sticker('SEMBY_degrading', true)
							chaos_copy:add_sticker('SEMBY_degrading', true)
							-- Emplace Copy
							G.consumeables:emplace(chaos_copy)
							chaos_copy:start_revive()
							G.GAME.consumeable_buffer = G.GAME.consumeable_buffer - 1
							-- Original Message
							attention_text({
								major = chaos_card,
								text = ''..(chaos_card.ability.SEMBY_degrading_tally or G.GAME.perishable_rounds),
								scale = 0.8, hold = 1.4, backdrop_colour = G.C.IMPORTANT,
								align = 'cm', offset = { x = 0, y = 0 }
							})
							-- Copy Message
							attention_text({
								major = chaos_copy,
								text = ''..(chaos_copy.ability.SEMBY_degrading_tally or G.GAME.perishable_rounds),
								scale = 0.8, hold = 1.4, backdrop_colour = G.C.IMPORTANT,
								align = 'cm', offset = { x = 0, y = 0 }
							})
							return true
						end
					}))
					-- End: Success
					message_state = true
				end
			end
			if message_state then
				-- Take up Time, Announce new Consumable:
				return {
					message = localize('SEMBY_consumeable_plus'),
					colour = G.C.GREEN
				}
			else -- Don't Take up Time:
				local juice_card = (context.blueprint_card or card)
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					blocking = false,
					func = function()
						juice_card:juice_up(0.3, 0.0)
						play_sound('generic1', 1.2, 0.5)
						attention_text({
							text = localize('SEMBY_consumeable_none_'..math.random(1, 3)),
							backdrop_colour = G.C.RED,
							scale = 0.6, hold = 1.0,
							major = juice_card, align = 'bm',
							offset = { x = 0, y = 0 }
						})
						return true
					end
				}))
				return nil, true
			end
        end
	end
}
