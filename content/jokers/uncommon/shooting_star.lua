SMODS.Joker {
	key = "shooting_star",
	SEMBY_art = "unkokat",
	atlas = "SEMBY_jokers_1",
	pos = { x = 8, y = 5 },
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
	rarity = 2,
	cost = 7,
	config = {
		extra = {
			amount = 1
		}
	},
    attributes = {
		'space', 'boss_blind', 'chance'
	},
	loc_vars = function(self, info_queue, card)
        local amount, _ = SMODS.get_probability_vars(card, card.ability.extra.amount, 1, 'SEMBY_shooting_star')
		return { vars = {
			number_format(amount)
		} }
	end,
    add_to_deck = function(self, card, from_debuff)
		if not from_debuff then G.GAME.SEMBY_eden_bonus = (G.GAME.SEMBY_eden_bonus or 0) +1 end
    end,
    remove_from_deck = function(self, card, from_debuff)
		if not from_debuff then G.GAME.SEMBY_eden_bonus = (G.GAME.SEMBY_eden_bonus or 0) -1 end
    end,
	calculate = function(self, card, context)
		if context.end_of_round and context.main_eval and context.game_over == false and G.GAME.blind.boss then
			-- Actual Code:
			local amount, _ = math.floor(SMODS.get_probability_vars(card, card.ability.extra.amount, 1, 'SEMBY_shooting_star') + 0.5)
			SMODS.upgrade_poker_hands({ level_up = amount, from = (context.blueprint_card or card), instant = true })
			-- Upgrade Visuals:
			local juice_card = (context.blueprint_card or card) --> Blueprint Compat.
			-- Like "Black Hole":
        	update_hand_text(
				{ sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3 },
        	    { handname = localize('k_all_hands'), chips = '...', mult = '...', level = '' }
			)
        	G.E_MANAGER:add_event(Event({
        	    trigger = 'after',
        	    delay = 0.2,
        	    func = function()
        	        play_sound('tarot1')
        	        juice_card:juice_up(0.8)
        	        G.TAROT_INTERRUPT_PULSE = true
        	        return true
        	    end
        	}))
        	update_hand_text(
				{ delay = 0 },
				{ mult = '+', StatusText = true }
			)
        	G.E_MANAGER:add_event(Event({
        	    trigger = 'after',
        	    delay = 0.9,
        	    func = function()
        	        play_sound('tarot1')
        	        juice_card:juice_up(0.8)
        	        return true
        	    end
        	}))
        	update_hand_text(
				{ delay = 0 },
				{ chips = '+', StatusText = true }
			)
        	G.E_MANAGER:add_event(Event({
        	    trigger = 'after',
        	    delay = 0.9,
        	    func = function()
        	        play_sound('tarot1')
        	        juice_card:juice_up(0.8)
        	        G.TAROT_INTERRUPT_PULSE = nil
        	        return true
        	    end
        	}))
        	update_hand_text(
				{ sound = 'button', volume = 0.7, pitch = 0.9, delay = 0 },
				{ level = '+'..number_format(amount) } --> Shows Amount
			)
        	delay(1.3)
        	update_hand_text(
				{ sound = 'button', volume = 0.7, pitch = 1.1, delay = 0 },
        	    { mult = 0, chips = 0, handname = '', level = '' }
			)
            return {
				message = localize('k_upgrade_ex'),
				colour = G.C.SECONDARY_SET.Planet
			}, true
        end
	end
}
