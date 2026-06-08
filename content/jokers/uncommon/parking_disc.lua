local SEED = "SEMBY_parking_disc_V3"
-- Hardcoded Properties
local MAIN_PROPS = { base = 0, min = 1, max = 12, s12 = 11, key = 'm' }
local BOSS_PROPS = { base = 0, min = 1, max =  4, s12 =  3, key = 'b' }
-- Texture Code
local function get_texture(state)
	if state and state ~= 0 then
		if state == 1 then return { x = 1, y = 3 } end
		if state == 2 then return { x = 2, y = 3 } end
		if state == 3 then return { x = 3, y = 3 } end
		if state == 4 then return { x = 4, y = 3 } end
	end
	return { x = 0, y = 3 }
end
-- Joker Code
SMODS.Joker {
	key = "parking_disc",
	SEMBY_art = "flowire",
	atlas = "SEMBY_jokers_2",
	pos = get_texture(),
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
	rarity = 2,
	cost = 6,
	config = {
		extra = {
			-- Drawing
			SEMBY_Graphics = { Parking = true }, --> /functions/drawsteps.lua
			SEMBY_Text = 'P', setup = false,
			-- Base
			index = { main = 0, boss = 0, s12 = false },
			value = { main = 0, boss = 0, mult = 1.0 },
			-- Values: Main
			["m1"]  =   1, -- 01: handsize
			["m2"]  =   2, -- 02: xmult
			["m3"]  =   2, -- 03: blueprint
			["m4"]  =   1, -- 04: discards
			["m5"]  =   5, -- 05: mult
			["m6"]  =   1, -- 06: consumables
			["m7"]  =   3, -- 07: xchips
			["m8"]  =   4, -- 08: money
			["m9"]  = 0.1, -- 09: percent
			["m10"] = 100, -- 10: chips
			["m11"] =   1, -- 11: retrigger
			["m12"] = 2.0, -- 12: random + stat_mult
			-- Values: Boss
			["b1"] =  2.0, -- 01: stat_mult
			["b2"] =    2, -- 02: hands
			["b3"] = 0.25, -- 03: percent
			["b4"] =    0, -- 04: disable
		}
	},
    attributes = {
		'scaling', 'reset', 'boss_blind',
		'changing_effects'
	},
	loc_vars = function(self, info_queue, card)
		-- Vars.
		local current_key, boss_info, copy_info
		local current_index = math.floor(card.ability.extra.index.s12 or card.ability.extra.index.main)
		local current_val = card.ability.extra.value.main
		-- Current State:
		if current_index >= MAIN_PROPS.min and current_index <= MAIN_PROPS.max then
			-- Main Info
			current_key = 'SEMBY_parking_disc'..'_'..current_index
			if current_index == 9 then current_val = current_val * 100 end
			-- Boss/Bonus Info
			local boss_index = math.floor(card.ability.extra.index.boss)
			if boss_index >= BOSS_PROPS.min and boss_index <= BOSS_PROPS.max then
				local boss_key = 'SEMBY_parking_disc'..'_boss_'..boss_index
				boss_info = { { n = G.UIT.C, config = { align = "bm", minh = 0.2 },
					nodes = { { n = G.UIT.C, config = { ref_table = card, align = "m" },
						nodes = { { n = G.UIT.T, config = {
							text = boss_index == 1 and localize{ type = 'variable',
								key = boss_key, vars = { card.ability.extra.value.mult }
							} or localize(boss_key), colour = G.C.DARK_EDITION, scale = 0.32 * 0.8
						} } }
					} }
				} }
			end
			-- Blueprint Info
			if current_index == 3 then
				local compatible = false
				if card.area and not card.area.config.collection then
					for i = 1, #card.area.cards do
						if card.area.cards[i] == card then
							if i > 1 then compatible = card.area.cards[i-1].config.center.blueprint_compat end
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
		if G.GAME.SEMBY_random_parking then
			info_queue[#info_queue + 1] = { key = 'SEMBY_parking_disc_XX', set = "Other" }
		elseif card.area and not card.area.config.collection then
			local next_index = current_index + 1
			if next_index > MAIN_PROPS.max or next_index < MAIN_PROPS.min
			then next_index = MAIN_PROPS.min end
			local next_key = 'SEMBY_parking_disc'..'_'..next_index
			local next_val = card.ability.extra[MAIN_PROPS.key..next_index]
			if next_index == 9 then next_val = next_val * 100 end
			info_queue[#info_queue + 1] = { key = next_key, set = "Other", vars = { next_val } }
		end
		-- Return
		if current_key then
			return {
				main_start = boss_info,
				key = current_key,
				set = "Other",
				vars = { current_val },
				main_end = copy_info
			}
		end
	end,
	load = function(self, card, card_table, other_card)
		G.E_MANAGER:add_event(Event({
			func = function()
				card.children.center:set_sprite_pos(get_texture(card.ability.extra.index.boss))
				return true
			end
		}))
	end,
    add_to_deck = function(self, card, from_debuff)
		if not from_debuff then
			-- Reset: Index
			card.ability.extra.index.main = MAIN_PROPS.base
			card.ability.extra.index.boss = BOSS_PROPS.base
			-- Reset: Value
			card.ability.extra.value.main = 0
			card.ability.extra.value.boss = 0
			card.ability.extra.value.mult = 1.0
			-- Reset: Texture
			card.ability.extra.SEMBY_Text = G.GAME.SEMBY_random_parking and '?' or 'P'
			card.children.center:set_sprite_pos(get_texture())
		end
    end,
	calculate = function(self, card, context)
		if context.end_of_round and context.main_eval and not context.blueprint then
			card.ability.extra.setup = false
		end
		if context.setting_blind and not self.getting_sliced then
			local cref = card.ability.extra
			local juice_card = (context.blueprint_card or card)
			-- Setup
			if not cref.setup then
				-- Setup
				cref.setup = true
				local mult = 1.0
				-- Next Effect
				if G.GAME.SEMBY_random_parking then cref.index.main = pseudorandom(SEED, MAIN_PROPS.min, MAIN_PROPS.max)
				else cref.index.main = cref.index.s12 and MAIN_PROPS.min or math.min(MAIN_PROPS.min, math.floor(cref.index.main)+1) end
				-- EOL: Special 12
				cref.index.s12 = false
				if cref.index.main >= MAIN_PROPS.max then
					cref.index.s12 = MAIN_PROPS.max
					mult = mult * cref[MAIN_PROPS.key..MAIN_PROPS.max]
					cref.index.main = pseudorandom(SEED, MAIN_PROPS.min, MAIN_PROPS.s12)
				end
				-- Boss Effect
				if G.GAME.blind.boss or cref.index.s12 then
					cref.index.boss = pseudorandom(SEED, BOSS_PROPS.min, cref.index.s12 and BOSS_PROPS.s12 or BOSS_PROPS.max)
					cref.value.boss = cref[BOSS_PROPS.key..cref.index.boss]
					if cref.index.boss == 1 then mult = mult * cref.value.boss
					else cref.value.boss = cref.value.boss * mult end
				else cref.index.boss = BOSS_PROPS.base; cref.value.boss = 0 end
				-- Math Value
				cref.value.main = cref[MAIN_PROPS.key..cref.index.main] * mult
				cref.value.mult = mult --> Desc.
				-- TMTRAINER Support:
				if cref.index.main == 1 or cref.index.main == 3
				or cref.index.main == 6 or cref.index.main == 11
				then cref.value.main = math.floor(cref.value.main+0.5) end
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
						card.ability.extra.SEMBY_Text = cref.index.s12 or cref.index.main
						card.children.center:set_sprite_pos(get_texture(cref.index.boss))
						-- Effects
						card:juice_up()
						card:flip()
						play_sound('tarot1')
						return true
					end
				}))
			end
			-- Main Effects
			if cref.index.main ~= MAIN_PROPS.base then
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
			if cref.index.boss ~= BOSS_PROPS.base then
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
			if card.area then
				local copy_joker = nil
				for i = 1, #card.area.cards do
					if card.area.cards[i] == card then
						if i > 1 then copy_joker = card.area.cards[i - 1] end
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
									key_append = SEED
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
				SEMBY_Reduce_Blindsize(card.ability.extra.value.main, (context.blueprint_card or card), true)
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
