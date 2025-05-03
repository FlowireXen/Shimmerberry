SMODS.Joker {
	key = "shooting_star",
	loc_txt = {
		name = "Shooting Star",
		text = {
			"Upgrade every",
			"{C:legendary,E:1}Poker Hand{}",
			"by {C:green}#1#{} level#2#",
			"when {C:attention}Boss Blind{}",
			"is defeated"
		}
	},
	rarity = 2,
	cost = 9,
	atlas = "SEMBY_jokers",
	pos = { x = 3, y = 0 },
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		local retval = ""
		if G.GAME.probabilities.normal and G.GAME.probabilities.normal > 1 then retval = "s" end
		return { vars = { (G.GAME.probabilities.normal or 1), retval } }
	end,
	calculate = function(self, card, context)
		if context.end_of_round and context.cardarea == G.jokers and G.GAME.blind.boss then
			-- Make sure it will actually Upgrade
			local probability = G.GAME.probabilities.normal
			if probability and probability <= 0 then
				probability = 1
			end
			-- Vanilla Black Hole Card Code
			update_hand_text( { sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3 }, { handname = localize('k_all_hands'), chips = '...', mult = '...', level='' } )
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
				play_sound('tarot1')
				card:juice_up(0.8, 0.5)
				G.TAROT_INTERRUPT_PULSE = true
			return true end }))
			update_hand_text({delay = 0}, {mult = '+', StatusText = true})
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
				play_sound('tarot1')
				card:juice_up(0.8, 0.5)
			return true end }))
			update_hand_text({delay = 0}, {chips = '+', StatusText = true})
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
				play_sound('tarot1')
				card:juice_up(0.8, 0.5)
				G.TAROT_INTERRUPT_PULSE = nil
			return true end }))
			update_hand_text({sound = 'button', volume = 0.7, pitch = 0.9, delay = 0}, {level='+1'})
			delay(1.3)
			-- Upgrade all Hands
			for k, v in pairs(G.GAME.hands) do
				level_up_hand(card, k, true, probability)
			end
			-- More 'nilla Code
			update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
			-- Return (More Feedback!)
            return { message = localize('k_upgrade_ex'), card = card, colour = G.C.PLANET }
        end
	end
}
