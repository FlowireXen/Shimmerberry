SMODS.Joker {
	key = "singularity",
	name = "SEMBY_singularity",
	atlas = "SEMBY_jokers",
	pos = { x = 9, y = 3 },
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = false,
    blueprint_compat = true,
	rarity = 3,
	cost = 10,
	config = {
		-- [WIP] extra_slots_used = 2
		card_limit = -2
	},
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
		return { vars = {
			math.abs(card.ability.card_limit) + 1,
			colours = { G.C.PERISHABLE }
		} }
	end,
    add_to_deck = function(self, card, from_debuff)
		if not from_debuff then
			SMODS.debuff_card(card, 'prevent_debuff', 'SEMBY_singularity')
		end
    end,
    remove_from_deck = function(self, card, from_debuff)
		if from_debuff then
			card:set_debuff(false)
			card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('SEMBY_blocked_ex'), colour = G.C.PERISHABLE})
		else
			-- Animate: Juice Deck
			G.E_MANAGER:add_event(Event({
				func = function()
					if G.deck then
						if G.deck.cards and G.deck.cards[1] then
							G.deck.cards[1]:juice_up()
						else G.deck:juice_up() end
					end
					play_sound('whoosh2', math.random()*0.2 + 0.6, 0.8)
					return true
				end
			}))
			card_eval_status_text(G.deck, 'extra', nil, nil, nil, {message = localize('SEMBY_collapsed_ex'), colour = HEX('000000')})
			delay(0.2)
			-- Select Cards:
			local removed_hand = 0
			local removed_deck = {}
			for _, playing_card in ipairs(G.playing_cards) do
				if playing_card.ability.SEMBY_singularity == card.sort_id then
					playing_card.ability.SEMBY_singularity = nil
					removed_deck[#removed_deck + 1] = playing_card
				end
			end
			if #removed_deck > 0 then
				-- Animate: Hand Destruction
				for _, playing_card in pairs(removed_deck) do
					if playing_card.area and playing_card.area == G.hand then
						removed_hand = removed_hand + 1
						G.E_MANAGER:add_event(Event({
							trigger = 'after',
							delay = 0.2,
							func = function()
								playing_card:start_dissolve({{1, 0, 0, 1}, {1, 0.5, 0.5, 1}}, true, 2.0, true)
								play_sound('whoosh2', math.random()*0.2 + 0.6, 0.8)
								return true
							end
						}))
					end
				end
				-- Destroy Cards
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.2,
					func = function()
						--> Also calls "SMODS.calculate_context()"
						SMODS.destroy_cards(removed_deck, nil, true, true)
						return true
					end
				}))
				-- Redraw Hand-Cards
				if removed_hand > 0 then
					G.E_MANAGER:add_event(Event({
						trigger = 'after',
						delay = 0.2,
						func = function()
							SMODS.draw_cards(removed_hand)
							return true
						end
					}))
				end
			end
		end
    end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			-- Create Copy
            G.playing_card = (G.playing_card and G.playing_card + 1) or 1
            local singularity_card = copy_card(context.other_card, nil, nil, G.playing_card)
			singularity_card.ability.SEMBY_singularity = card.sort_id
			if not singularity_card.ability.SEMBY_event_horizon then
				singularity_card:add_sticker('SEMBY_event_horizon', true)
			end
			-- Add to Deck
            singularity_card:add_to_deck()
            G.deck.config.card_limit = G.deck.config.card_limit + 1
            table.insert(G.playing_cards, singularity_card)
			-- Add to Hand
			singularity_card.states.visible = nil
			local juice_card = (context.blueprint_card or card)
            G.E_MANAGER:add_event(Event({
                func = function()
					juice_card:juice_up()
					G.hand:emplace(singularity_card)
					singularity_card:start_materialize({{0, 0, 0, 1}, {0, 0, 0, 1}}, true, 2.0)
					play_sound('magic_crumple3', math.random()*0.3 + 1.4, 0.8)
					G.GAME.blind:debuff_card(singularity_card)
					G.hand:sort()
                    return true
                end
            }))
			-- Further Handling
            G.E_MANAGER:add_event(Event({
                func = function()
                    SMODS.calculate_context({ playing_card_added = true, cards = { singularity_card } })
                    return true
                end
            }))
			delay(0.1)
			return nil, true
		end
	end
}
