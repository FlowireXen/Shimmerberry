SMODS.Joker {
	key = "parking_disc",
	name = "SEMBY_parking_disc",
	atlas = "SEMBY_jokers",
	pos = { x = 8, y = 8 },
	soul_pos = { x = 7, y = 11 },
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
	rarity = 2,
	cost = 6,
	config = {
		extra = {
			setup = false,
			value = {
				main = 0,
				boss = 0,
				mult = 1.0
			},
			index = {
				main = 0,
				boss = 0,
				s12 = false,
			},
			limit = {
				main = { base = 0, min = 1, max = 12, s12 = 11 },
				boss = { base = 0, min = 1, max =  4, s12 =  3 },
			},
			state = {
				main = {
					{ value =    1, desc = "1"  }, -- 01: handsize
					{ value =    2, desc = "2"  }, -- 02: xmult
					{ value =    2, desc = "3"  }, -- 03: blueprint
					{ value =    1, desc = "4"  }, -- 04: discards
					{ value =    5, desc = "5"  }, -- 05: mult
					{ value =    1, desc = "6"  }, -- 06: consumables
					{ value =    3, desc = "7"  }, -- 07: xchips
					{ value =    4, desc = "8"  }, -- 08: money
					{ value = 0.05, desc = "9"  }, -- 09: percent
					{ value =  100, desc = "10" }, -- 10: chips
					{ value =    1, desc = "11" }, -- 11: retrigger
					{ value =  2.0, desc = "12" }, -- 12: random
				},
				boss = {
					{ value =  2.0, desc = "boss_1" }, -- 01: stat_mult
					{ value =    2, desc = "boss_2" }, -- 02: hands
					{ value = 0.25, desc = "boss_3" }, -- 03: percent
					{ value =    0, desc = "boss_4" }, -- 04: disable
				},
			},
			pos_valid = { x = 8, y = 8 },
			pos_overwrite = { x = 8, y = 8 },
			soul_pos_valid = { base = 7 },
			soul_pos_overwrite = { x = 7, y = 11 }
		}
	},
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
		-- Vars:
		local current_key = 'j_'..'SEMBY_parking_disc'
		local current_index = card.ability.extra.index.s12 and card.ability.extra.index.s12 or card.ability.extra.index.main
		local current_val = card.ability.extra.value.main
        local boss_info = nil
        local copy_info = nil
		-- Current State:
		if current_index ~= card.ability.extra.limit.main.base then
			-- Main Info
			current_key = current_key..'_'..card.ability.extra.state.main[current_index].desc
			if current_index == 9 then current_val = current_val * 100 end
			-- Boss/Bonus Info
			if card.ability.extra.index.boss ~= card.ability.extra.limit.boss.base then
				local boss_key = 'SEMBY_parking_disc'..'_'..card.ability.extra.state.boss[card.ability.extra.index.boss].desc
				boss_info = { { n = G.UIT.C, config = { align = "bm", minh = 0.2 },
					nodes = { { n = G.UIT.C, config = { ref_table = card, align = "m" },
						nodes = { { n = G.UIT.T, config = {
							text = card.ability.extra.index.boss == 1 and localize{ type = 'variable', key = boss_key, vars = { card.ability.extra.value.mult } } or localize(boss_key),
							colour = G.C.DARK_EDITION,
							scale = 0.32 * 0.8
						} } }
					} }
				} }
			end
			-- Blueprint Info
			if current_index == 3 then
				local compatible = false
				if card.area and card.area == G.jokers then
					for i = 1, #G.jokers.cards do
						if G.jokers.cards[i] == card then
							if i > 1 then compatible = G.jokers.cards[i-1].config.center.blueprint_compat end
							break
						end
					end
				end
				copy_info = { { n = G.UIT.C, config = { align = "bm", minh = 0.4 }, nodes = { { n = G.UIT.C, config = { 
					ref_table = card, align = "m",
					colour = compatible and mix_colours(G.C.GREEN, G.C.JOKER_GREY, 0.8) or mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8),
					r = 0.05, padding = 0.06
				}, nodes = { { n = G.UIT.T, config = {
					text = ' ' .. localize('k_' .. (compatible and 'compatible' or 'incompatible')) .. ' ',
					colour = G.C.UI.TEXT_LIGHT,
					scale = 0.32 * 0.8
				} } } } } } }
			end
		end
		-- Next State:
		if card.area and not card.area.config.collection then
			local next_index = current_index + 1
			if next_index > card.ability.extra.limit.main.max then
				next_index = card.ability.extra.limit.main.min
			end
			local next_key = 'SEMBY_parking_disc'..'_'..card.ability.extra.state.main[next_index].desc
			local next_val = card.ability.extra.state.main[next_index].value
			if next_index == 9 then next_val = next_val * 100 end
			--1: I tried everything, looked at the Code, tried every possible Combination... I don't understand why this doesn't work:
			-- : info_queue[#info_queue + 1] = { key = 'j_'..next_key, set = "Joker", config = { extra = {}, next_val }, specific_vars = { next_val } }
			-- : Workaround is just creating the Desc. twice ("Joker" & "Other") in the Loc-Files :annoyed:
			--2: I tried again with more Info and Insight and still: Nope, still NIL-Values.
			-- : I would be happy if it Crashes due to Looping the Desc.-Tables, but not even that happens.
			info_queue[#info_queue + 1] = { key = next_key, set = "Other", vars = { next_val } }
		end
		-- Return
		return {
			main_start = boss_info,
			key = current_key,
			vars = { current_val },
			main_end = copy_info
		}
	end,
	load = function(self, card, card_table, other_card)
		G.E_MANAGER:add_event(Event({
			func = function()
				card.children.center:set_sprite_pos(card.ability.extra.pos_overwrite)
				card:set_soul_pos('SEMBY_jokers', card.ability.extra.soul_pos_overwrite)
				return true
			end
		}))
	end,
    add_to_deck = function(self, card, from_debuff)
		if not from_debuff then
			-- Reset: State
			card.ability.extra.index.main = card.ability.extra.limit.main.base
			card.ability.extra.index.boss = card.ability.extra.limit.boss.base
			-- Reset: Value
			card.ability.extra.value.main = card.ability.extra.limit.main.base
			card.ability.extra.value.boss = card.ability.extra.limit.boss.base
			card.ability.extra.value.mult = 1.0
			-- Reset: Texture
			card.ability.extra.pos_overwrite.x = card.ability.extra.pos_valid.x
			card.ability.extra.pos_overwrite.y = card.ability.extra.pos_valid.y
			card.children.center:set_sprite_pos(card.ability.extra.pos_overwrite)
			card.ability.extra.soul_pos_overwrite.x = card.ability.extra.soul_pos_valid.base
			card:set_soul_pos('SEMBY_jokers', card.ability.extra.soul_pos_overwrite)
		end
    end,
	calculate = function(self, card, context)
		if context.end_of_round and context.main_eval and not context.blueprint then
			card.ability.extra.setup = false
		end
		if context.setting_blind and not self.getting_sliced then
			-- Code Simplicity...
			local cref = card.ability.extra -- (Maybe) Remove this for Release!
			local juice_card = (context.blueprint_card or card) -- Not this.
			-- Setup
			if not cref.setup then
				cref.setup = true
				-- Next Effect
				cref.index.main = cref.index.s12 and cref.limit.main.min or cref.index.main + 1
				local mult = 1.0
				-- EOL: State 12
				cref.index.s12 = false
				if cref.index.main == cref.limit.main.max then
					cref.index.s12 = cref.index.main
					mult = mult * cref.state.main[cref.index.main].value
					cref.index.main = pseudorandom("SEMBYPDs12", cref.limit.main.min, cref.limit.main.s12)
				end
				-- Boss Effect
				if G.GAME.blind.boss or cref.index.s12 then
					cref.index.boss = pseudorandom("SEMBYPD_Boss", cref.limit.boss.min, cref.index.s12 and cref.limit.boss.s12 or cref.limit.boss.max)
					mult = mult * (cref.index.boss == 1 and cref.state.boss[cref.index.boss].value or 1.0)
					cref.value.boss = cref.state.boss[cref.index.boss].value * mult
				else
					cref.index.boss = cref.limit.boss.base
					cref.value.boss = cref.limit.boss.base
				end
				-- Math Value
				cref.value.main = cref.state.main[cref.index.main].value * mult
				cref.value.mult = mult -- for Desc.
			end
			-- Texture
			if not context.blueprint then
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					func = function()
						card:flip()
						return true
					end
				}))
				--delay(0.1)
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					func = function()
						-- Main Texture
						cref.pos_overwrite.x = cref.pos_valid.x + (((cref.index.s12 and cref.index.s12 or cref.index.main) - 1) % 4)
						cref.pos_overwrite.y = cref.pos_valid.y + math.floor(((cref.index.s12 and cref.index.s12 or cref.index.main) - 1) / 4)
						card.children.center:set_sprite_pos(cref.pos_overwrite)
						-- Soul Texture
						cref.soul_pos_overwrite.x = cref.soul_pos_valid.base + cref.index.boss
						card:set_soul_pos('SEMBY_jokers', cref.soul_pos_overwrite)
						-- Effects
						card:juice_up()
						card:flip()
						play_sound('tarot1')
						return true
					end
				}))
			end
			-- Main Effects
			if cref.index.main ~= cref.limit.main.base then
				if cref.index.main == 1 then -- Hand Size
                    SMODS.calculate_effect({
						message = localize{ type = 'variable', key = 'a_handsize', vars = { cref.value.main } },
						colour = G.C.IMPORTANT
					}, juice_card)
					G.hand:change_size(cref.value.main)
					G.GAME.round_resets.temp_handsize = (G.GAME.round_resets.temp_handsize or 0) + cref.value.main
				end
				if cref.index.main == 4 then -- Discards
                    SMODS.calculate_effect({
						message = localize{ type = 'variable', key = 'SEMBY_discards', vars = { cref.value.main } },
						colour = G.C.RED
					}, juice_card)
					ease_discard(cref.value.main)
				end
			end
			-- Boss/Bonus Effects:
			if cref.index.boss ~= cref.limit.boss.base then
				if cref.index.boss == 2 then -- Extra Hands
                    SMODS.calculate_effect({
						message = localize{ type = 'variable', key = 'a_hands', vars = { cref.value.boss } },
						colour = G.C.BLUE
					}, juice_card)
					ease_hands_played(cref.value.boss)
					delay(0.2)
				end
				if cref.index.boss == 3 then -- Decrease Blind Size
					SEMBY_Reduce_Blindsize(cref.value.boss, juice_card, true)
				end
				if cref.index.boss == 4 and not context.blueprint then -- Disable Boss
					SMODS.calculate_effect({
						message = localize('ph_boss_disabled'),
						colour = G.C.RED
					}, juice_card)
					G.E_MANAGER:add_event(Event({
						func = function()
							G.GAME.blind:disable()
							play_sound('timpani')
							return true
						end
					}))
					delay(0.4)
				end
			end
			-- Finish
			if cref.index.main ~= 3 then
				return nil, true
			end
		end
		if card.ability.extra.index.main == 3 then -- Blueprint
			local copy_joker = nil
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == card then
					if i > 1 then copy_joker = G.jokers.cards[i - 1] end
					break
				end
			end
			if copy_joker then
				local merged_hell = {}
				for i = 1, card.ability.extra.value.main do
					merged_hell = SMODS.merge_effects( { merged_hell }, { SMODS.blueprint_effect(card, copy_joker, context) } )
				end
				return merged_hell
			else
				return nil
			end
		end
		if context.joker_main then
			if card.ability.extra.index.main == 2 then -- X-Mult
				return { xmult = card.ability.extra.value.main }
			end
			if card.ability.extra.index.main == 6 then -- Consumable
				local juice_card = (context.blueprint_card or card)
				for i = 1, card.ability.extra.value.main do
					if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
						G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
						G.E_MANAGER:add_event(Event({
							trigger = 'after',
							delay = 0.2,
							func = function()
								juice_card:juice_up()
								SMODS.add_card {
									set = 'Consumeables',
									area = G.consumeables,
									key_append = 'SEMBYPDs06'
								}
								G.GAME.consumeable_buffer = G.GAME.consumeable_buffer - 1
								return true
							end
						}))
					else break end
				end
				return {
					message = localize{ type = 'variable', key = 'SEMBY_consumeables', vars = { card.ability.extra.value.main } },
					colour = G.C.IMPORTANT
				}
			end
			if card.ability.extra.index.main == 7 then -- X-Chips
				return { xchips = card.ability.extra.value.main }
			end
			if card.ability.extra.index.main == 8 then -- Money
				return { dollars = card.ability.extra.value.main }
			end
			if card.ability.extra.index.main == 9 then -- Decrease Blind Size
				SEMBY_Reduce_Blindsize(card.ability.extra.percent, (context.blueprint_card or card), true)
				return nil, true
			end
			if card.ability.extra.index.main == 10 then -- Chips
				return { chips = card.ability.extra.value.main }
			end
		end
		if context.individual and context.cardarea == G.play then
			if card.ability.extra.index.main == 5 then -- Mult
				return { mult = card.ability.extra.value.main }
			end
		end
		if context.repetition and context.cardarea == G.play then
			if card.ability.extra.index.main == 11 then -- Retrigger
				return { repetitions = card.ability.extra.value.main }
			end
		end
	end
}
