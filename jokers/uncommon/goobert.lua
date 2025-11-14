SMODS.Joker {
	key = "goobert",
	name = "SEMBY_goobert",
	atlas = "SEMBY_jokers",
	pos = { x = 3, y = 6 },
	soul_pos = { x = 4, y = 6 },
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = false,
	rarity = 2,
	cost = 8,
	config = {
		extra = {
			SEMBY_Durability = {
				max_durability = 10,
				durability = 10,
				repair_cost = 25,
				repair_gain = 1,
				is_liquid = true
			},
			soul_pos = true, --> Bad but I don't care
			soul_pos_valid = { left = 5, right = 4, y = 6 }
		}
	},
	pools = {
        Repairable = true,
    },
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
		return { vars = {
			card:durability_amount(),
			colours = { 
				card:durability_color()
			}
		} }
	end,
	calculate = function(self, card, context)
		-- This Joker was initially designed with Blueprint in Mind;
		if context.playing_card_added and not context.blueprint then
			-- Get & Create new Cards:
			local slimed_cards = {}
			for _, playing_card in ipairs(context.cards) do
				if not playing_card.ability.SEMBY_goobert then
					if context.blueprint or card:durability_use() then
						-- Create Copy
						G.playing_card = (G.playing_card and G.playing_card + 1) or 1
						local slime_card = copy_card(playing_card, nil, nil, G.playing_card)
						slime_card.ability.SEMBY_goobert = true
						slime_card.states.visible = nil --> Visual Stuff;
						-- Modify Copy
						local slime_mod = pseudorandom("SEMBY_goobert")
						if slime_mod < 0.2 then --# Suit
							assert(SMODS.change_base(slime_card, pseudorandom_element(SMODS.Suits, pseudoseed("SEMBY_goobert")).key, nil))
						elseif slime_mod < 0.4 then --# Rank
							assert(SMODS.modify_rank(slime_card, math.random(-2, 2)))
						elseif slime_mod < 0.6 then --# Enhancement
							slime_card:set_ability(SMODS.poll_enhancement{ guaranteed = true }, true, true)
						elseif slime_mod < 0.8 then --# Edition
							slime_card:set_edition(poll_edition(nil, nil, false, true), true, true)
						else --slime_mod < 1.0 --# Seal
							slime_card:set_seal(SMODS.poll_seal{ guaranteed = true }, true, true)
						end
						-- Add to Deck
						slime_card:add_to_deck()
						G.deck.config.card_limit = G.deck.config.card_limit + 1
						table.insert(G.playing_cards, slime_card)
						-- Setup for Visuals and correct Emplace!
						slimed_cards[#slimed_cards + 1] = slime_card
					end
				end
			end
			if slimed_cards and #slimed_cards ~= 0 then
				-- Emplace
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					func = function()
						for i = 1, #slimed_cards do
							G.hand:emplace(slimed_cards[i])
							G.GAME.blind:debuff_card(slimed_cards[i])
						end
						G.hand:sort()
						return true
					end
				}))
				-- Vars. for Visuals:
				local juice_card = (context.blueprint_card or card)
				local soul_ref = card.ability.extra.soul_pos_valid
				local pos_1 = card.ability.extra.soul_pos and soul_ref.left or soul_ref.right
				local pos_2 = card.ability.extra.soul_pos and soul_ref.right or soul_ref.left
				local v_rot = card.ability.extra.soul_pos and 0.5 or -0.5
				card.ability.extra.soul_pos = not card.ability.extra.soul_pos
				-- Swing Visibility, Step 1
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.2,
					func = function()
						-- Visuals
						play_sound('SEMBY_brush_paint_'..math.random(1, 2), math.random()*0.3 + 0.8)
						juice_card:juice_up(0.2, v_rot)
						card:set_soul_pos('SEMBY_jokers', { x = pos_1, y = soul_ref.y })
						-- Visibility
						for i = 1, #slimed_cards do
							slimed_cards[i].states.visible = true
							slimed_cards[i]:set_dissolve({{0, 1, 0, 1}, {0.2, 0.8, 0.2, 0.8}}, 1.0, 0.7, 0.4)
						end
						return true
					end
				}))
				-- Swing Visibility, Step 2
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.6,
					func = function()
						-- Visuals
						play_sound('SEMBY_brush_paint_'..math.random(1, 2), math.random()*0.3 + 0.8)
						juice_card:juice_up(0.2, -v_rot)
						card:set_soul_pos('SEMBY_jokers', { x = pos_2, y = soul_ref.y })
						-- Visibility
						for i = 1, #slimed_cards do
							slimed_cards[i]:set_dissolve({{0, 1, 0, 1}, {0.2, 0.8, 0.2, 0.8}}, 0.7, 0.3, 0.4)
						end
						return true
					end
				}))
				-- Swing Visibility, Step 3
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.6,
					func = function()
						-- Visuals
						play_sound('SEMBY_brush_paint_'..math.random(1, 2), math.random()*0.3 + 0.8)
						juice_card:juice_up(0.2, v_rot)
						card:set_soul_pos('SEMBY_jokers', { x = pos_1, y = soul_ref.y })
						-- Visibility
						for i = 1, #slimed_cards do
							slimed_cards[i]:set_dissolve({{0, 1, 0, 1}, {0.2, 0.8, 0.2, 0.8}}, 0.3, 0.0, 0.4)
						end
						return true
					end
				}))
				-- Shuffle Cards into Deck (if needed)
				if not G.GAME.blind.in_blind then
					G.E_MANAGER:add_event(Event({
						trigger = 'after',
						delay = 0.4,
						func = function()
							-- Add to Deck instead:
							for i = 1, #slimed_cards do
								slimed_cards[i].area:remove_card(slimed_cards[i])
								slimed_cards[i]:add_to_deck()
								G.deck:emplace(slimed_cards[i])
							end
							return true
						end
					}))
				else
					delay(0.4)
				end
				local alive = card:durability_check()
				return {
					message = localize('SEMBY_goobert_'..(alive and math.random(1, 4) or 'X')),
					colour = G.C.GREEN,
					func = function()
						G.E_MANAGER:add_event(Event({
							func = function()
								SMODS.calculate_context({ playing_card_added = true, cards = slimed_cards })
								for i = 1, #slimed_cards do
									slimed_cards[i].ability.SEMBY_goobert = nil
								end
								return true
							end
						}))
					end
				}
			end
            return nil, true
		end
	end
}
