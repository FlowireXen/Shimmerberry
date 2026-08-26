-- Get Quest-Infos
local function SEMBY_Get_Quest()
	if G.GAME.SEMBY_questing then
		-- Select Quest
		local challenge = pseudorandom_element({
			{ "hand", "use", 100 }, { "hand", "beat", 12 },
			{ "discard", "use", 500 }, { "discard", "beat", 21 },
			{ "money", "shot", 300 },
			{ "consumable", "shot", 12 }, --{ "consumable", "shot", 12 },
			{ "joker", "beat", 12 },
		})
		-- Return
		return { category = challenge[1], action = challenge[2], target = challenge[3] }
	else-- "Vanilla" then
		-- Select Category
		local qCategory = pseudorandom_element({ "hand", "discard", "money", "consumable", "joker" }, 'SEMBY_quest_category')
		-- Select Action
		local qAction = pseudorandom_element({ "use", "use", "beat", "beat", "shot" }, 'SEMBY_quest_action')
		-- Possible Targets
		local qGoals = {
			["hand"]       = { ["use"] =  60, ["beat"] =  6, ["shot"] =   8, },
			["discard"]    = { ["use"] = 250, ["beat"] =  9, ["shot"] =  30, },
			["money"]      = { ["use"] = 300, ["beat"] =  6, ["shot"] = 100, },
			["consumable"] = { ["use"] = 100, ["beat"] = 12, ["shot"] =  10, },
			["joker"]      = { ["use"] =  25, ["beat"] =  6, ["shot"] =   8, },
		}
		-- Return
		return { category = qCategory, action = qAction, target = qGoals[qCategory][qAction] }
	end
end
-- Texture Data
local SEMBY_quest_pos = {
	base     = { x = 0, y = 2 },
	active   = { x = 1, y = 2 },
	complete = { x = 2, y = 2 },
}
-- Joker Code
SMODS.Joker {
	key = "quest",
	SEMBY_art = "flowire",
	atlas = "SEMBY_jokers_2",
	pos = SEMBY_quest_pos.base,
    eternal_compat = true,
    perishable_compat = false,
    blueprint_compat = false,
	rarity = 2,
	cost = 7,
    config = {
		extra = {
			-- Version 3.5 State-Logic
			quest = {
				category = "unset",
				action = "unset",
				-- Old State-Logic
				active = false, complete = false,
				reset = false, check = false, silent = false
			},
			major = 0,
			minor = 0,
			target = 0,
		}
	},
    attributes = {
		'scaling', 'reset', 'generation',
		'changing_effects'
	},
	loc_vars = function(self, info_queue, card)
		local ret_key = 'j_SEMBY_quest'
		local ret_val = nil
		local info_val = nil
		if card.ability.extra.quest.complete then
			ret_key = ret_key..'_complete'
		elseif card.ability.extra.quest.active then
			ret_key = ret_key..'_'..card.ability.extra.quest.category..'_'..card.ability.extra.quest.action
			ret_val = math.max(0, card.ability.extra.target - card.ability.extra.major)
			local info_key = 'SEMBY_quest_active_'..card.ability.extra.quest.action
			if card.ability.extra.quest.reset then
				if card.ability.extra.quest.action == "beat" then
					info_key = info_key..'_reset'
				elseif card.ability.extra.quest.action == "shot" then
					ret_val = math.max(0, card.ability.extra.target - card.ability.extra.minor)
				end
			end
			info_val = { {
				n = G.UIT.C, config = { align = "bm", minh = 0.3 }, nodes = { {
					n = G.UIT.C, config = { ref_table = card, align = "m" }, nodes = { {
						n = G.UIT.T, config = { text = localize(info_key), colour = G.C.UI.TEXT_INACTIVE, scale = 0.32 * 0.9 }
					} }
				} }
			} }
		end
		-- Return
		return {
			key = ret_key,
			vars = { ret_val },
			main_end = info_val
		}
	end,
	set_sprites = function(self, card, front)
		if card.ability and card.ability.extra then
			if card.ability.extra.quest.complete then
				card.children.center:set_sprite_pos(SEMBY_quest_pos.complete)
			elseif card.ability.extra.quest.action == "use" then
				card.children.center:set_sprite_pos(SEMBY_quest_pos.active)
			elseif not card.ability.extra.quest.reset then
				card.children.center:set_sprite_pos(SEMBY_quest_pos.active)
			else
				card.children.center:set_sprite_pos(SEMBY_quest_pos.base)
			end
		end
	end,
    add_to_deck = function(self, card, from_debuff)
		if not from_debuff then
			local new_quest = SEMBY_Get_Quest()
			-- Set new Quest
			card.ability.extra.quest.category = new_quest.category
			card.ability.extra.quest.action = new_quest.action
			card.ability.extra.target = new_quest.target
			-- Reset Progress
			card.ability.extra.major = 0
			card.ability.extra.minor = 0
			-- Activate Joker
			card.ability.extra.quest.active = true
			card.ability.extra.quest.complete = false
			card.ability.extra.quest.reset = false
			if (G.GAME.blind.in_blind and card.ability.extra.quest.action == "beat")
			or card.ability.extra.quest.action == "shot" then
				card.ability.extra.quest.reset = true
			end
			-- Safety Reset
			card.ability.extra.quest.check = false
			card.ability.extra.quest.silent = false
			-- Set Correct Texture
			card.children.center:set_sprite_pos(
				card.ability.extra.quest.reset and SEMBY_quest_pos.base or SEMBY_quest_pos.active
			)
			-- Announce Start!
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = localize('SEMBY_quest_accepted'), colour = G.C.GREEN })
		end
    end,
    remove_from_deck = function(self, card, from_debuff)
		if not from_debuff then
			if card.ability.extra.quest.complete then
				local legend = SMODS.create_card({ set = 'Joker', legendary = true })
				if legend.config.center_key == 'j_joker' then
					legend:remove()--legend:start_dissolve(nil, true, 0, true)
					legend = SMODS.create_card({ set = 'Joker', legendary = true, allow_duplicates = true })
				end
				legend:add_to_deck()
				G.jokers:emplace(legend)
				play_sound('timpani')
				card_eval_status_text(legend, 'extra', nil, nil, nil, { message = localize('k_legendary'), colour = G.C.RARITY.Legendary })
				check_for_unlock { type = 'spawn_legendary' }
			else
				card_eval_status_text(card, 'extra', nil, nil, nil, { message = localize('SEMBY_quest_abandoned'), colour = G.C.RED })
			end
		end
    end,
	calculate = function(self, card, context)
		if card.ability.extra.quest.active and not context.blueprint then
			if context.setting_blind and not self.getting_sliced then
				card.ability.extra.minor = 0
				card.ability.extra.quest.check = false
				if card.ability.extra.quest.reset then
					card.ability.extra.quest.reset = false
					G.E_MANAGER:add_event(Event({
						trigger = 'after',
						func = function()
							play_sound('button')
							-- Texture: Active
							card.children.center:set_sprite_pos(SEMBY_quest_pos.active)
							return true
						end
					}))
					return {
						message = localize('k_reset'),
						colour = G.C.IMPORTANT
					}
				end
				return --> early
			end
			if not card.ability.extra.quest.reset then
				if card.ability.extra.quest.category == "hand" then
					if context.joker_main then
						if card.ability.extra.quest.action == "use" or card.ability.extra.quest.action == "shot" then
							card.ability.extra.major = card.ability.extra.major + 1
							card.ability.extra.quest.check = true
						elseif card.ability.extra.quest.action == "beat" then
							card.ability.extra.minor = card.ability.extra.minor + 1
							if card.ability.extra.minor > 1 then card.ability.extra.quest.reset = true end
						end
					end
				elseif card.ability.extra.quest.category == "discard" then
					if context.discard then
						if card.ability.extra.quest.action == "use" or card.ability.extra.quest.action == "shot" then
							card.ability.extra.major = card.ability.extra.major + 1
							card.ability.extra.quest.check = true
							-- A lil' scuffed but generally works:
							if context.other_card ~= context.full_hand[#context.full_hand] then
								card.ability.extra.quest.silent = true
							end
						elseif card.ability.extra.quest.action == "beat" then
							card.ability.extra.quest.reset = true
						end
					end
				elseif card.ability.extra.quest.category == "money" then
					if context.money_altered then
						if card.ability.extra.quest.action == "use" then
							if context.amount < 0 then
								card.ability.extra.major = card.ability.extra.major + math.abs(context.amount)
								card.ability.extra.quest.check = true
							end
						elseif card.ability.extra.quest.action == "beat" then
							if context.amount < 0 then
								card.ability.extra.quest.reset = true
							end
						elseif card.ability.extra.quest.action == "shot" then
							if context.amount > 0 then
								card.ability.extra.major = card.ability.extra.major + context.amount
								card.ability.extra.quest.check = true
							end
						end
					end
				elseif card.ability.extra.quest.category == "consumable" then
					if context.using_consumeable then
						if card.ability.extra.quest.action == "use" or card.ability.extra.quest.action == "shot" then
							card.ability.extra.major = card.ability.extra.major + 1
							card.ability.extra.quest.check = true
						elseif card.ability.extra.quest.action == "beat" then
							card.ability.extra.quest.reset = true
						end
					end
				elseif card.ability.extra.quest.category == "joker" then
					if card.ability.extra.quest.action == "use" then
						if context.open_booster then
							if context.card.config.center.kind == "Buffoon" then
								card.ability.extra.minor = 1
							else
								card.ability.extra.minor = 0
							end
							return --> early
						end
						-- If needed, "context.ending_booster" exists.
						if context.skipping_booster then
							if card.ability.extra.minor == 1 then
								card.ability.extra.major = card.ability.extra.major + 1
								card.ability.extra.quest.check = true
							end
						end
					elseif card.ability.extra.quest.action == "beat" then
						if context.card_added and context.card.ability.set == "Joker" then
							card.ability.extra.quest.reset = true
						end
						if context.selling_card and context.card.ability.set == "Joker" then
							card.ability.extra.quest.reset = true
						end
					elseif card.ability.extra.quest.action == "shot" then
						if context.selling_card and card.ability.set == "Joker" then
							card.ability.extra.major = card.ability.extra.major + 1
							card.ability.extra.quest.check = true
						end
					end
				end
				if context.end_of_round and context.main_eval then
					if card.ability.extra.quest.action == "beat" and not card.ability.extra.quest.reset then
						card.ability.extra.major = card.ability.extra.major + 1
						card.ability.extra.quest.check = true
					elseif card.ability.extra.quest.action == "shot" then
						card.ability.extra.minor = card.ability.extra.major
						card.ability.extra.quest.reset = true
					end
				end
				if card.ability.extra.quest.reset then
					card.ability.extra.major = 0
					G.E_MANAGER:add_event(Event({
						trigger = 'after',
						func = function()
							play_sound('button')
							-- Texture: Inactive
							card.children.center:set_sprite_pos(SEMBY_quest_pos.base)
							return true
						end
					}))
					return {
						message = localize('SEMBY_failed_ex'),
						colour = G.C.RED
					}
				end
				if card.ability.extra.quest.check then
					card.ability.extra.quest.check = false
					if card.ability.extra.major >= card.ability.extra.target then
						-- Quest Complete
						card.ability.extra.quest.active = false
						card.ability.extra.quest.complete = true
						-- Texture
						G.E_MANAGER:add_event(Event({
							trigger = 'after',
							func = function()
								card:juice_up()
								play_sound('gold_seal')
								-- Texture: Active
								card.children.center:set_sprite_pos(SEMBY_quest_pos.complete)
								return true
							end
						}))
						delay(1.0)
						-- Win Blind
						if G.GAME.blind.in_blind then
							G.E_MANAGER:add_event(Event({
								trigger = 'after',
								func = function()
									-- Pull Blind-Size down
									G.GAME.blind.chips = math.floor(G.GAME.chips)
									G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
									SEMBY_Blind_Wiggle()
									return true
								end
							}))
							SEMBY_Blind_Check(card)
						end
						if SMODS.is_eternal(card, card) then
							-- Be able to claim your Reward! :3
							G.E_MANAGER:add_event(Event({ func = function()
								card.ability.eternal = false
								card.ability.SEMBY_possessive = false
							return true end }))
							card_eval_status_text(card, 'extra', nil, nil, nil, { message = localize('SEMBY_eternal_cleared'), colour = G.C.ETERNAL })
						end
						SMODS.debuff_card(card, 'prevent_debuff', 'SEMBY_quest')
						-- And finally: Win!
						return {
							message = localize('SEMBY_quest_completed'),
							colour = G.C.EDITION,
							func = function()
								if not G.GAME.won then
									-- Delay Win until you reach a savable state
									G.E_MANAGER:add_event(Event({
										blocking = false,
										func = function()
											if G.STATE == G.STATES.SELECTING_HAND
											or G.STATE == G.STATES.SHOP
											or G.STATE == G.STATES.BLIND_SELECT
											or G.STATE == G.STATES.ROUND_EVAL
											then
												-- Triple Check because the Game likes being silly :)
												if not G.GAME.won then
													G.GAME.won = true
													save_run()
													G.E_MANAGER:add_event(Event({
														trigger = 'after',
														delay = 0.2,
														blocking = false,
														func = function()
															win_game()
															--G.GAME.won = true
															return true
														end
													}))
												end
												return true
											end
											return false
										end
									}))
								end
								return true
							end
						}
					else
						if card.ability.extra.quest.silent then
							card.ability.extra.quest.silent = false
							return -- silent return
						end
						if card.ability.extra.quest.action == "use" then
							return {
								message = localize {
									type = 'variable',
									key = 'SEMBY_out_of',
									vars = {
										math.min(card.ability.extra.major, card.ability.extra.target),
										card.ability.extra.target
									}
								},
								colour = G.C.IMPORTANT
							}
						elseif card.ability.extra.quest.action == "beat" or card.ability.extra.quest.action == "shot" then
							return {
								message = localize {
									type = 'variable',
									key = 'SEMBY_left',
									vars = { 
										math.max(0, card.ability.extra.target - card.ability.extra.major)
									}
								},
								colour = G.C.IMPORTANT
							}
						end
					end
				end
			end
		end
	end,
    in_pool = function(self, args)
		return true, { allow_duplicates = true }
	end
}
