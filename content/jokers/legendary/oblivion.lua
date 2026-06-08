-- Hardcoded Variables:
local SEMBY_Loop_Ante = 1
-- Joker
SMODS.Joker {
	key = "oblivion",
	SEMBY_art = "flowire",
	atlas = "SEMBY_jokers_1",
	pos = { x = 7, y = 4 },
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = false,
	rarity = 4,
	cost = 20,
    config = {
		extra = {
			highest_ante = nil,
			difficulty = 0,
			difficulty_mod = 0.5,
			payout = 0,
			payout_mod = 3,
			loop = 0
		}
	},
    attributes = {
		'xblindsize', 'economy',
		'ante'
	},
	loc_vars = function(self, info_queue, card)
		local current_ante = (G.GAME.round_resets.ante or 1)
		local highest_ante = (card.ability.extra.highest_ante or current_ante)
		return { vars = {
			-- Next Loop, Ante Reset
			tostring(highest_ante)..(current_ante > highest_ante and '+' or ''),
			SEMBY_Loop_Ante,
			-- Difficulty Stats
			card.ability.extra.difficulty_mod * 100,
			card.ability.extra.difficulty * 100,
			-- Money Stats
			card.ability.extra.payout_mod,
			card.ability.extra.payout,
			-- Loop Counter
			math.floor(card.ability.extra.loop),
		} }
    end,
    add_to_deck = function(self, card, from_debuff)
		if not from_debuff then
			card.ability.extra.highest_ante = G.GAME.round_resets.ante
		end
		if card.ability.extra.difficulty ~= 0 then
        	SEMBY_Global_BlindMod_Add('oblivion'..card.sort_id, card.ability.extra.difficulty)
			SEMBY_Update_Blind_Select(true)
		end
	end,
    remove_from_deck = function(self, card, from_debuff)
		if card.ability.extra.difficulty ~= 0 then
			SEMBY_Global_BlindMod_Remove('oblivion'..card.sort_id)
			if not from_debuff then
				card_eval_status_text(card, 'extra', nil, nil, nil, {
					message = localize('SEMBY_oblivion_removed'),
					colour = G.C.DARK_EDITION
				})
			end
			SEMBY_Update_Blind_Select()
		end
	end,
	calculate = function(self, card, context)
		if context.ante_change and context.ante_end and not context.blueprint then
			if (G.GAME.round_resets.ante + context.ante_change) > (card.ability.extra.highest_ante or G.GAME.round_resets.ante) then
				-- Increase Loop Target:
				card.ability.extra.highest_ante = (card.ability.extra.highest_ante or G.GAME.round_resets.ante) + 1
				-- More Payout
				card.ability.extra.payout = card.ability.extra.payout + card.ability.extra.payout_mod
				-- Difficulty
				card.ability.extra.difficulty = card.ability.extra.difficulty + card.ability.extra.difficulty_mod
        		SEMBY_Global_BlindMod_Add('oblivion'..card.sort_id, card.ability.extra.difficulty_mod)
				-- Force-Reset & Animate Ante (Only Once!)
				if not G.GAME.SEMBY_oblivion then
					G.GAME.SEMBY_oblivion = true
					-- Force Reset
					G.E_MANAGER:add_event(Event({
						trigger = 'after',
						func = function()
							G.GAME.round_resets.ante = SEMBY_Loop_Ante
						  	G.GAME.SEMBY_oblivion = nil
							return true
						end
					}))
					-- Animate
					G.E_MANAGER:add_event(Event({
						trigger = 'after',
						func = function()
							local ante_UI = G.hand_text_area.ante
							ante_UI.config.object:update()
    				    	G.HUD:recalculate()
    				    	attention_text({
    				    		text = tostring(SEMBY_Loop_Ante),
    				    		scale = 1.0, hold = 1.5, cover = ante_UI.parent,
    				    		cover_colour = G.C.PURPLE, align = 'cm',
    				    	})
							return true
						end
					}))
				end
				-- Current Loop
				card.ability.extra.loop = card.ability.extra.loop + 1
				return {
					message = localize{ type = 'variable', key = 'SEMBY_loop', vars = { math.floor(card.ability.extra.loop) } },
					colour = G.C.DARK_EDITION
				}
			end
		end
	end,
    calc_dollar_bonus = function(self, card)
		-- Payout (on Boss) :3
		if G.GAME.blind.boss and card.ability.extra.payout ~= 0 then
			return card.ability.extra.payout
		end
    end
}
