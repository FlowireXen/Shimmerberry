SMODS.Joker {
	key = "quest",
	name = "SEMBY_quest",
	atlas = "SEMBY_jokers",
	pos = { x = 3, y = 9 },
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = false,
    blueprint_compat = false,
	rarity = 2,
	cost = 7,
    config = {
		extra = {
			-- Version 3.0 State-Logic
			quest = {
				active = false,
				complete = false,
				reset = false,
				check = false,
				silent = false
			},
			states = {
				items = { "hand", "discard", "money", "consumable", "joker" },
				types = { "use", "beat", "shot" }
			},
			state = {
				item = "unset",
				type = "unset"
			},
			goals = {
				["hand"]       = { ["use"] = 60,  ["beat"] = 6,  ["shot"] = 8,   },
				["discard"]    = { ["use"] = 250, ["beat"] = 9,  ["shot"] = 30,  },
				["money"]      = { ["use"] = 300, ["beat"] = 6,  ["shot"] = 100, },
				["consumable"] = { ["use"] = 100, ["beat"] = 12, ["shot"] = 10,  },
				["joker"]      = { ["use"] = 25,  ["beat"] = 6,  ["shot"] = 8,   },
			},
			progress = {
				main = 0,
				alt = 0
			},
			pos_valid = { base = 9, active = 10, complete = 11 },
			pos_overwrite = { x = 3, y = 9 },
		}
	},
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
		local ret_key = 'j_SEMBY_quest'
		local ret_val = nil
		local info_val = nil
		if card.ability.extra then
			if card.ability.extra.quest.complete then
				ret_key = ret_key..'_complete'
			elseif card.ability.extra.quest.active then
				ret_key = ret_key..'_'..card.ability.extra.state.item..'_'..card.ability.extra.state.type
				ret_val = math.max(0, card.ability.extra.goals[card.ability.extra.state.item][card.ability.extra.state.type] - card.ability.extra.progress.main)
				local info_key = 'SEMBY_quest_active_'..card.ability.extra.state.type
				if card.ability.extra.quest.reset then
					if card.ability.extra.state.type == "beat" then
						info_key = info_key..'_reset'
					elseif card.ability.extra.state.type == "shot" then
						ret_val = math.max(0, card.ability.extra.goals[card.ability.extra.state.item][card.ability.extra.state.type] - card.ability.extra.progress.alt)
					end
				end
				info_val = { {
					n = G.UIT.C, config = { align = "bm", minh = 0.3 },
					nodes = { {
						n = G.UIT.C, config = { ref_table = card, align = "m" },
						nodes = { {
							n = G.UIT.T, config = { text = localize(info_key), colour = G.C.UI.TEXT_INACTIVE, scale = 0.32 * 0.9 }
						} }
					} }
				} }
			end
		end
		-- Return
		return {
			key = ret_key,
			vars = { ret_val },
			main_end = info_val
		}
	end,
	load = function(self, card, card_table, other_card)
		G.E_MANAGER:add_event(Event({
			func = function()
				card.children.center:set_sprite_pos(card.ability.extra.pos_overwrite)
				return true
			end
		}))
	end,
    add_to_deck = function(self, card, from_debuff)
		if not from_debuff then
			if card.ability.extra.quest.complete then
				-- Allow Duplicating Completed Quests... May be removed in v3.0 o3o
				card.ability.extra.pos_overwrite.y = card.ability.extra.pos_valid.complete
				card.children.center:set_sprite_pos(card.ability.extra.pos_overwrite)
				card_eval_status_text(card, 'extra', nil, nil, nil, { message = localize('SEMBY_quest_duplicated'), colour = G.C.DARK_EDITION })
			else
				-- Reset Progress
				card.ability.extra.progress.main = 0
				card.ability.extra.progress.alt = 0
				-- Select Quest
				card.ability.extra.state.item = pseudorandom_element(card.ability.extra.states.items, 'SEMBY_quest_joker_'..card.sort_id)
				card.ability.extra.state.type = pseudorandom_element(card.ability.extra.states.types, 'SEMBY_quest_joker_'..card.sort_id)
				-- Activate Joker
				card.ability.extra.quest.active = true
				card.ability.extra.quest.reset = false
				if G.GAME.blind.in_blind then
					if card.ability.extra.state.type == "beat" then
						card.ability.extra.quest.reset = true
					end
				else
					if card.ability.extra.state.type == "shot" then
						card.ability.extra.quest.reset = true
					end
				end
				-- Texture
				if card.ability.extra.quest.reset then
					card.ability.extra.pos_overwrite.y = card.ability.extra.pos_valid.base
				else
					card.ability.extra.pos_overwrite.y = card.ability.extra.pos_valid.active
				end
				card.children.center:set_sprite_pos(card.ability.extra.pos_overwrite)
				-- Announce Start!
				card_eval_status_text(card, 'extra', nil, nil, nil, { message = localize('SEMBY_quest_accepted'), colour = G.C.GREEN })
			end
		end
    end,
    remove_from_deck = function(self, card, from_debuff)
		if not from_debuff then
			if card.ability.extra.quest.complete then
				local legend = SMODS.create_card({ set = 'Joker', legendary = true })
				if legend.config.center_key == 'j_joker' then
					legend:start_dissolve(nil, true, 0, true)
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
				card.ability.extra.progress.alt = 0
				card.ability.extra.quest.check = false
				if card.ability.extra.quest.reset then
					card.ability.extra.quest.reset = false
					G.E_MANAGER:add_event(Event({
						trigger = 'after',
						func = function()
							play_sound('button')
							-- Texture: Active
							card.ability.extra.pos_overwrite.y = card.ability.extra.pos_valid.active
							card.children.center:set_sprite_pos(card.ability.extra.pos_overwrite)
							return true
						end
					}))
					return {
						message = localize('k_reset'),
						colour = G.C.ATTENTION
					}
				end
				return --> early
			end
			if not card.ability.extra.quest.reset then
				if card.ability.extra.state.item == "hand" then
					if context.joker_main and context.cardarea == G.jokers then
						if card.ability.extra.state.type == "use" or card.ability.extra.state.type == "shot" then
							card.ability.extra.progress.main = card.ability.extra.progress.main + 1
							card.ability.extra.quest.check = true
						elseif card.ability.extra.state.type == "beat" then
							card.ability.extra.progress.alt = card.ability.extra.progress.alt + 1
							if card.ability.extra.progress.alt > 1 then card.ability.extra.quest.reset = true end
						end
					end
				elseif card.ability.extra.state.item == "discard" then
					if context.discard and context.cardarea == G.jokers then
						if card.ability.extra.state.type == "use" or card.ability.extra.state.type == "shot" then
							card.ability.extra.progress.main = card.ability.extra.progress.main + 1
							card.ability.extra.quest.check = true
							-- A lil' scuffed but generally works:
							if context.other_card ~= context.full_hand[#context.full_hand] then
								card.ability.extra.quest.silent = true
							end
						elseif card.ability.extra.state.type == "beat" then
							card.ability.extra.quest.reset = true
						end
					end
				elseif card.ability.extra.state.item == "money" then
					if context.money_altered then
						if card.ability.extra.state.type == "use" then
							if context.amount < 0 then
								card.ability.extra.progress.main = card.ability.extra.progress.main + math.abs(context.amount)
								card.ability.extra.quest.check = true
							end
						elseif card.ability.extra.state.type == "beat" then
							if context.amount < 0 then
								card.ability.extra.quest.reset = true
							end
						elseif card.ability.extra.state.type == "shot" then
							if context.amount > 0 then
								card.ability.extra.progress.main = card.ability.extra.progress.main + context.amount
								card.ability.extra.quest.check = true
							end
						end
					end
				elseif card.ability.extra.state.item == "consumable" then
					if context.using_consumeable then
						if card.ability.extra.state.type == "use" or card.ability.extra.state.type == "shot" then
							card.ability.extra.progress.main = card.ability.extra.progress.main + 1
							card.ability.extra.quest.check = true
						elseif card.ability.extra.state.type == "beat" then
							card.ability.extra.quest.reset = true
						end
					end
				elseif card.ability.extra.state.item == "joker" then
					if card.ability.extra.state.type == "use" then
						if context.open_booster then
							if context.card.config.center.kind == "Buffoon" then
								card.ability.extra.progress.alt = 1
							else
								card.ability.extra.progress.alt = 0
							end
							return --> early
						end
						-- If needed, "context.ending_booster" exists.
						if context.skipping_booster then
							if card.ability.extra.progress.alt == 1 then
								card.ability.extra.progress.main = card.ability.extra.progress.main + 1
								card.ability.extra.quest.check = true
							end
						end
					elseif card.ability.extra.state.type == "beat" then
						if context.card_added and context.card.ability.set == "Joker" then
							card.ability.extra.quest.reset = true
						end
						if context.selling_card and context.card.ability.set == "Joker" then
							card.ability.extra.quest.reset = true
						end
					elseif card.ability.extra.state.type == "shot" then
						if context.selling_card and card.ability.set == "Joker" then
							card.ability.extra.progress.main = card.ability.extra.progress.main + 1
							card.ability.extra.quest.check = true
						end
					end
				end
				if context.end_of_round and context.main_eval then
					if card.ability.extra.state.type == "beat" and not card.ability.extra.quest.reset then
						card.ability.extra.progress.main = card.ability.extra.progress.main + 1
						card.ability.extra.quest.check = true
					elseif card.ability.extra.state.type == "shot" then
						card.ability.extra.progress.alt = card.ability.extra.progress.main
						card.ability.extra.quest.reset = true
					end
				end
				if card.ability.extra.quest.reset then
					card.ability.extra.progress.main = 0
					G.E_MANAGER:add_event(Event({
						trigger = 'after',
						func = function()
							play_sound('button')
							-- Texture: Inactive
							card.ability.extra.pos_overwrite.y = card.ability.extra.pos_valid.base
							card.children.center:set_sprite_pos(card.ability.extra.pos_overwrite)
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
					if card.ability.extra.progress.main >= card.ability.extra.goals[card.ability.extra.state.item][card.ability.extra.state.type] then
						-- Quest Complete
						card.ability.extra.quest.complete = true
						card.ability.extra.quest.active = false
						-- Texture
						G.E_MANAGER:add_event(Event({
							trigger = 'after',
							func = function()
								card:juice_up()
								play_sound('gold_seal')
								-- Texture: Active
								card.ability.extra.pos_overwrite.y = card.ability.extra.pos_valid.complete
								card.children.center:set_sprite_pos(card.ability.extra.pos_overwrite)
								return true
							end
						}))
						delay(1.0)
						-- Bonus/Failsafe
						if G.GAME.blind.in_blind then--and not G.STATE == G.STATES.SELECTING_HAND then
							-- Playing your Last hand to Finish the Quest doesn't Murder you! YIPPEEEE!!!!
							ease_hands_played(1)
							card_eval_status_text(card, 'extra', nil, nil, nil, { message = localize('SEMBY_bonus_hand'), colour = G.C.BLUE })
						end
						if SMODS.is_eternal(card, card) then
							-- Be able to claim your Reward! :3
							G.E_MANAGER:add_event(Event({ func = function() card.ability.eternal = false return true end }))
							card_eval_status_text(card, 'extra', nil, nil, nil, { message = localize('SEMBY_eternal_cleared'), colour = G.C.ETERNAL })
						end
						-- Debuff, No More!
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
						if card.ability.extra.state.type == "use" then
							return {
								message = localize {
									type = 'variable',
									key = 'SEMBY_out_of',
									vars = {
										math.min(card.ability.extra.progress.main, card.ability.extra.goals[card.ability.extra.state.item][card.ability.extra.state.type]),
										card.ability.extra.goals[card.ability.extra.state.item][card.ability.extra.state.type]
									}
								},
								colour = G.C.ATTENTION
							}
						elseif card.ability.extra.state.type == "beat" or card.ability.extra.state.type == "shot" then
							return {
								message = localize {
									type = 'variable',
									key = 'SEMBY_left',
									vars = { 
										math.max(0, card.ability.extra.goals[card.ability.extra.state.item][card.ability.extra.state.type] - card.ability.extra.progress.main)
									}
								},
								colour = G.C.ATTENTION
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
