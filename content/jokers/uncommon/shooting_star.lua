SMODS.Joker {
	key = "shooting_star",
	name = "SEMBY_shooting_star",
	atlas = "SEMBY_jokers",
	pos = { x = 2, y = 3 },
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
	rarity = 2,
	cost = 7,
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
        local amount, _ = SMODS.get_probability_vars(card, 1, 0, 'SEMBY_shooting_star')
		return { vars = {
			number_format(amount)
		} }
	end,
	calculate = function(self, card, context)
		if context.end_of_round and context.main_eval and context.game_over == false and G.GAME.blind.boss then
			-- Actual Code:
			local amount, _ = SMODS.get_probability_vars(card, 1, 0, 'SEMBY_shooting_star')
			for planet, _ in pairs(G.GAME.hands) do level_up_hand(card, planet, true, amount) end
			--SMODS.upgrade_poker_hands({ level_up = amount, instant = true, from = card })
			-- Just Visuals:
			local juice_card = (context.blueprint_card or card)
			--> (99%) Vanilla Balatro Code:
            return {
				func = function()
					update_hand_text(
						{ sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3 },
						{ handname = localize('k_all_hands'), chips = '...', mult = '...', level='' }
					)
					G.E_MANAGER:add_event(Event({
						trigger = 'after',
						delay = 0.2,
						func = function()
							play_sound('tarot1')
							juice_card:juice_up(0.8, 0.5)
							G.TAROT_INTERRUPT_PULSE = true
							return true
						end
					}))
					update_hand_text(
						{delay = 0},
						{mult = '+', StatusText = true}
					)
					G.E_MANAGER:add_event(Event({
						trigger = 'after',
						delay = 0.9,
						func = function()
							play_sound('tarot1')
							juice_card:juice_up(0.8, 0.5)
							return true
						end
					}))
					update_hand_text(
						{delay = 0},
						{chips = '+', StatusText = true}
					)
					G.E_MANAGER:add_event(Event({
						trigger = 'after',
						delay = 0.9,
						func = function()
							play_sound('tarot1')
							juice_card:juice_up(0.8, 0.5)
							G.TAROT_INTERRUPT_PULSE = nil
							return true
						end
					}))
					update_hand_text(
						{sound = 'button', volume = 0.7, pitch = 0.9, delay = 0},
						{level='+'..number_format(amount)} --> Shows Amount
					)
					delay(1.3)
					update_hand_text(
						{sound = 'button', volume = 0.7, pitch = 1.1, delay = 0},
						{mult = 0, chips = 0, handname = '', level = ''}
					)
					return true
				end,
				extra = {
					message = localize('k_upgrade_ex'),
					colour = G.C.SECONDARY_SET.Planet
				}
			}
        end
	end
}
