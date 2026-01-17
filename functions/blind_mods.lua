--## SEMBY Blind Functions

-- Corrected "Blind Wiggle"
function SEMBY_Blind_Wiggle()
	G.E_MANAGER:add_event(Event({
		trigger = 'after',
		func = function()
			play_sound('tarot2', 1, 0.4)
			G.GAME.blind.children.animatedSprite:juice_up(0.3)
			return true
		end
	}))
	G.E_MANAGER:add_event(Event({
		trigger = 'after',
		delay = 0.06*G.SETTINGS.GAMESPEED,
		func = function()
			play_sound('tarot2', 0.76, 0.4)
			return true
		end
	}))
end

-- Change Blind Size
function SEMBY_Change_Blindsize(mult)
	G.E_MANAGER:add_event(Event({
		trigger = 'after',
		func = function()
			G.GAME.blind.chips = math.max(0, math.floor(G.GAME.blind.chips * mult))
			G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
			return true
		end
	}))
end

-- Increase Blind Size
function SEMBY_Increase_Blindsize(percent, card, wiggle)
	if percent then
		if G.GAME.blind.chips ~= 0 then
			SEMBY_Change_Blindsize(1.0 + percent)
		end
		if wiggle then
			SEMBY_Blind_Wiggle()
		end
		if card then
			card_eval_status_text(card, 'extra', nil, nil, nil, {
				message = localize{type = 'variable', key = 'SEMBY_percentage', vars = {100 * percent}},
				colour = G.C.SEMBY_PERCENT
			})
		end
	end
end

-- Reduce Blind Size
function SEMBY_Reduce_Blindsize(percent, card, wiggle)
	if percent then
		if G.GAME.blind.chips ~= 0 then
			SEMBY_Change_Blindsize(1.0 - percent)
		end
		if wiggle then
			SEMBY_Blind_Wiggle()
		end
		if card then
			card_eval_status_text(card, 'extra', nil, nil, nil, {
				message = localize{type = 'variable', key = 'SEMBY_percentage_minus', vars = {100 * percent}},
				colour = G.C.SEMBY_PERCENT
			})
		end
	end
end

-- Setup Check: Has the Blind been Defeated?
function SEMBY_Blind_Check(card)
	G.E_MANAGER:add_event(Event({
		blocking = false,
		func = function()
			if G.STATE == G.STATES.SELECTING_HAND then
				--print("defeated")
				if G.GAME.chips >= G.GAME.blind.chips then
					if card then card:juice_up() end
					play_sound('tarot1')
					G.STATE = G.STATES.HAND_PLAYED
					G.STATE_COMPLETE = true
					-- If it's suddenly not enough Chips, make sure you Win anyways.
					if G.GAME.chips < G.GAME.blind.chips then
						--print("fallback")
						G.GAME.chips = G.GAME.blind.chips
					end
					end_round()
				end
				return true
			elseif G.STATE == G.STATES.ROUND_EVAL then
				--print("gave up")
				return true
			end
			return false
		end
	}))
end
