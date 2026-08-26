SMODS.Joker {
	key = "singularity", -- black hole, black_hole, blackhole
	SEMBY_art = "unkokat",
	atlas = "SEMBY_jokers_1",
	pos = { x = 9, y = 5 },
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = false,
	rarity = 3,
	cost = 10,
	config = {
		extra = {
			copies = 2
		},
		extra_slots_used = 1
	},
    attributes = {
		'generation', 'destroy_card', 'joker_slot', 'space'
	},
	loc_vars = function(self, info_queue, card)
        --info_queue[#info_queue + 1] = {key = 'SEMBY_event_horizon', set = 'Other'}
		return { vars = {
			math.max(1, card.ability.extra.copies),
			card.ability.extra_slots_used + 1
		} }
	end,
    add_to_deck = function(self, card, from_debuff)
		if from_debuff then card.SEMBY_remove_from_deck = nil end
	end,
    remove_from_deck = function(self, card, from_debuff)
		if from_debuff then card.SEMBY_remove_from_deck = true else
			-- Select Cards:
			local removed_hand = 0
			local removed_deck = {}
			for _, playing_card in ipairs(G.playing_cards) do
				if playing_card.ability.SEMBY_singularity == card.sort_id then
					--playing_card.ability.SEMBY_singularity = nil
					removed_deck[#removed_deck + 1] = playing_card
				end
			end
			if #removed_deck > 0 then
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
						for _, playing_card in pairs(removed_deck) do
							playing_card.ability.SEMBY_singularity = nil
							playing_card.ability.SEMBY_event_horizon = nil
						end
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
		-- This Joker was initially designed with Blueprint in Mind;
		if context.playing_card_added and not context.blueprint then
			-- Get & Create new Cards:
			local sincalories = {}
			for _, playing_card in ipairs(context.cards) do
				if not playing_card.ability.SEMBY_copy then
					for i = 1, math.max(1, card.ability.extra.copies) do
						-- Create Copy
						G.playing_card = (G.playing_card and G.playing_card + 1) or 1
						local sincalorie = copy_card(playing_card, nil, nil, G.playing_card)
						sincalorie.ability.SEMBY_copy = true
						sincalorie.ability.SEMBY_singularity = card.sort_id
						if not sincalorie.ability.SEMBY_event_horizon then
							sincalorie:add_sticker('SEMBY_event_horizon', true)
						end
						-- Add to Deck
						sincalorie:add_to_deck()
						G.deck.config.card_limit = G.deck.config.card_limit + 1
						table.insert(G.playing_cards, sincalorie)
						sincalorie.states.visible = nil
						-- Setup for Visuals and correct Emplace!
						sincalorie.SEMBY_keep_area = playing_card.area == G.hand
						sincalories[#sincalories + 1] = sincalorie
					end
				end
			end
			if #sincalories ~= 0 then
				local juice_card = (context.blueprint_card or card)
				-- Emplace
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					func = function()
						for i = 1, #sincalories do
							G.hand:emplace(sincalories[i])
							G.GAME.blind:debuff_card(sincalories[i])
						end
						G.hand:sort()
						return true
					end
				}))
				-- Animate
				for i = 1, #sincalories do
					G.E_MANAGER:add_event(Event({
						trigger = 'after',
						delay = 0.2,
						func = function()
							juice_card:juice_up(0.2, 0.1)
							sincalories[i]:start_materialize({{0, 0, 0, 1}, {0, 0, 0, 1}}, true, 2.0)
							play_sound('magic_crumple3', math.random()*0.3 + 1.4, 0.8)
							return true
						end
					}))
				end
				-- Update Area
				local wait_before = true
				for i = 1, #sincalories do
					if not sincalories[i].SEMBY_keep_area then
						if wait_before then wait_before = false; delay(1.0) end
						G.E_MANAGER:add_event(Event({
							trigger = 'after',
							delay = 0.2,
							func = function()
								play_sound('cardSlide1', math.random()*0.2 + 0.9, 0.8)
								sincalories[i].area:remove_card(sincalories[i])
								G.deck:emplace(sincalories[i])
								return true
							end
						}))
					end
					sincalories[i].SEMBY_keep_area = nil
				end
				if wait_before then delay(0.2) end
				-- Remove "Copy"-Tag
				return {
					func = function()
						G.E_MANAGER:add_event(Event({
							func = function()
								SMODS.calculate_context({ playing_card_added = true, cards = sincalories })
								for i = 1, #sincalories do
									sincalories[i].ability.SEMBY_copy = nil
								end
								return true
							end
						}))
					end
				}
			end
			return
		end
	end
}

-- Very hacky "Ignore Debuff" effect:
-- (I didn't want to update "added_to_deck" directly)
local remove_from_deck = Card.remove_from_deck
function Card:remove_from_deck(from_debuff)
	if self.SEMBY_remove_from_deck then
		--self:add_to_deck(from_debuff)
		self.added_to_deck = true
	end
	remove_from_deck(self, from_debuff)
end
