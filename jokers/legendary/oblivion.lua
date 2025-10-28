SMODS.Joker {
	key = "oblivion",
	name = "SEMBY_oblivion",
	atlas = "SEMBY_jokers",
	pos = { x = 1, y = 1 },
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = false,
	rarity = 4,
	cost = 20,
    config = {
		extra = {
			progress = 0.0,
			difficulty = 0.0,
			loop = 0,
			progress_mod = {
				small = 0.0225,
				big = 0.035, -- default
				boss = 0.055,
				showdown = 0.15,
				cleared = 1.0
			},
			difficulty_mod = {
				skip = 0.0925,
				hand = 0.0175,
				discard = 0.003,
				cleared = 1.25
			},
			loop_win = 40
		}
	},
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
        return { vars = {
			G.GAME.won and '?' or math.floor(math.max(0.0, card.ability.extra.loop_win - card.ability.extra.loop)),
			math.floor(card.ability.extra.progress * 100),
			math.floor(card.ability.extra.difficulty * 100)
		} }
    end,
    add_to_deck = function(self, card, from_debuff)
		if from_debuff then
			G.GAME.SEMBY_blind_mod = G.GAME.SEMBY_blind_mod + card.ability.extra.difficulty
		else
			card.ability.extra.progress = 0.0
			card.ability.extra.difficulty = 0.0
			card.ability.extra.loop = 0.0
		end
    end,
    remove_from_deck = function(self, card, from_debuff)
		G.GAME.SEMBY_blind_mod = G.GAME.SEMBY_blind_mod - card.ability.extra.difficulty
		if not from_debuff then
			card_eval_status_text(card, 'extra', nil, nil, nil, {
				message = localize('SEMBY_oblivion_removed'),
				colour = G.C.DARK_EDITION
			})
		end
    end,
	calculate = function(self, card, context)
		if not context.blueprint then
			-- Progress
			if context.end_of_round and context.main_eval and context.game_over == false then
				local progress_mod = 0
				if G.GAME.blind.boss then
					if G.GAME.blind.config.blind.boss.showdown then
						progress_mod = card.ability.extra.progress_mod.showdown
					else
						progress_mod = card.ability.extra.progress_mod.boss
					end
				else
					if G.GAME.blind:get_type() == 'Small' then
						progress_mod = card.ability.extra.progress_mod.small
					else -- 'Big', Default
						progress_mod = card.ability.extra.progress_mod.big
					end
				end
				card.ability.extra.progress = card.ability.extra.progress + progress_mod
				return {
					message = localize{ type = 'variable', key = 'SEMBY_percentage', vars = { math.floor(progress_mod * 100) } },
					colour = G.C.GREEN
				}
			end
			if context.cardarea == G.jokers then
				-- Ante
				if context.modify_ante and context.modify_ante > 0 then
					if context.ante_end then
						if card.ability.extra.progress >= card.ability.extra.progress_mod.cleared then
							G.GAME.SEMBY_ante_allowed = true
							card.ability.extra.progress = card.ability.extra.progress - card.ability.extra.progress_mod.cleared
							local difficulty_mod = card.ability.extra.difficulty - card.ability.extra.difficulty_mod.cleared
							card.ability.extra.difficulty = math.max(0, difficulty_mod)
							G.GAME.SEMBY_blind_mod = G.GAME.SEMBY_blind_mod - card.ability.extra.difficulty_mod.cleared
							if difficulty_mod < 0 then
								G.GAME.SEMBY_blind_mod = G.GAME.SEMBY_blind_mod + math.abs(difficulty_mod)
							end
							return {
								message = localize('SEMBY_oblivion_allowed'),
								colour = G.C.GREEN,
								modify = context.modify_ante == 0 and 1 or -(context.modify_ante - 1),
								func = function()
									-- Special Bypass:
									G.E_MANAGER:add_event(Event({
										trigger = 'after',
										func = function()
											G.GAME.SEMBY_ante_allowed = false
											return true
										end
									}))
									return true
								end
							}
						else
							card.ability.extra.loop = card.ability.extra.loop + 1
							return {
								message = localize{ type = 'variable', key = 'SEMBY_loop', vars = { card.ability.extra.loop } },
								colour = G.C.DARK_EDITION,
								modify = G.GAME.SEMBY_ante_allowed and 0 or -context.modify_ante,
								func = function()
									if not (G.GAME.won) and card.ability.extra.loop >= card.ability.extra.loop_win then
										win_game()
										G.GAME.won = true
									end
									return true
								end
							}
						end
					else--if not G.GAME.SEMBY_ante_allowed then
						return {
							message = localize('SEMBY_blocked_ex'),
							colour = G.C.RED,
							modify = -context.modify_ante
						}
					end
				end
				-- Difficulty
				if context.skip_blind then
					card.ability.extra.difficulty = card.ability.extra.difficulty + card.ability.extra.difficulty_mod.skip
					G.GAME.SEMBY_blind_mod = G.GAME.SEMBY_blind_mod + card.ability.extra.difficulty_mod.skip
					G.E_MANAGER:add_event(Event({
						trigger = 'after',
						blocking = false,
						func = function()
							card:juice_up(0.1, (math.random() < 0.5) and 0.3 or -0.3)
							play_sound('generic1', 1.2, 0.8)
							attention_text({
								text = '+', backdrop_colour = G.C.RED, scale = 1.2, hold = 1.2,
								major = card, align = 'cm', offset = { x = 0, y = 0 }
							})
							return true
						end
					}))
				end
				if context.joker_main then
					card.ability.extra.difficulty = card.ability.extra.difficulty + card.ability.extra.difficulty_mod.hand
					G.GAME.SEMBY_blind_mod = G.GAME.SEMBY_blind_mod + card.ability.extra.difficulty_mod.hand
					G.E_MANAGER:add_event(Event({
						trigger = 'after',
						blocking = false,
						func = function()
							card:juice_up(0.1, (math.random() < 0.5) and 0.2 or -0.2)
							play_sound('generic1', 1.2, 0.5)
							attention_text({
								text = '+', backdrop_colour = G.C.RED, scale = 1.0, hold = 0.8,
								major = card, align = 'cm', offset = { x = 0, y = 0 }
							})
							return true
						end
					}))
				end
				if context.discard then
					card.ability.extra.difficulty = card.ability.extra.difficulty + card.ability.extra.difficulty_mod.discard
					G.GAME.SEMBY_blind_mod = G.GAME.SEMBY_blind_mod + card.ability.extra.difficulty_mod.discard
					G.E_MANAGER:add_event(Event({
						trigger = 'after',
						blocking = false,
						func = function()
							card:juice_up(0.1, (math.random() < 0.5) and 0.1 or -0.1)
							attention_text({
								text = '+', backdrop_colour = G.C.RED, scale = 0.8, hold = 0.4,
								major = card, align = 'cm', offset = { x = 0, y = 0 }
							})
							return true
						end
					}))
				end
			end
		end
	end
}
