SMODS.Joker {
	key = "jevil",
	name = "SEMBY_jevil",
    atlas = 'SEMBY_jokers',
    pos = { x = 1, y = 6 },
	soul_pos = { x = 1, y = 7 },
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = false,
	rarity = 4,
	cost = 20,
	config = {
		card_limit = 1,
		extra = {
			create = 2,
			percent = 0.1
		}
	},
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
        info_queue[#info_queue + 1] = {key = 'SEMBY_possessive', set = 'Other'}
		local area_type
		if card.area and card.area == G.consumeables then
			area_type = localize('SEMBY_jevil_area_c')
		else area_type = localize('SEMBY_jevil_area_j') end
		return { vars = {
			card.ability.card_limit, area_type,
			card.ability.extra.create,
			card.ability.extra.percent * 100
		} }
	end,
	calculate = function(self, card, context)
		if not context.blueprint then
			if context.setting_blind and not self.getting_sliced then
				-- Move Joker to Area: "G.consumeable"
				G.E_MANAGER:add_event(Event({
					func = function()
						if card.area and card.area ~= G.consumeables then
							card.area:remove_card(card)
							card:add_to_deck()
							G.consumeables:emplace(card)
						end
						return true
					end
				}))
				return nil, false
        	end
        	if context.using_consumeable and card.area and card.area == G.consumeables then
				local consument = nil -- Consumen't
				for i = 1, #G.consumeables.cards do
					if G.consumeables.cards[i] == card then
						consument = G.consumeables.cards[i - 1]
						break
					end
				end
				if consument and consument.ability.set ~= "Joker" then
					G.E_MANAGER:add_event(Event({
						trigger = 'after',
						func = function()
							card:juice_up(0.2, 0.1)
							play_sound('tarot1')
							consument:shatter()
							return true
						end
					}))
					delay(0.5)
					G.GAME.consumeable_buffer = (G.GAME.consumeable_buffer or 0) - 1
            		for i = 1, card.ability.extra.create do
						if G.GAME.consumeable_buffer + #G.consumeables.cards <= G.consumeables.config.card_limit then
							G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
							local prosumable = SMODS.add_card({
								set = 'Consumeables',
								area = G.consumeables,
								soulable = true,
								skip_materialize = true,
								key_append = 'SEMBY_jevil'
							})
							prosumable.states.visible = nil
							prosumable:add_sticker('SEMBY_possessive', true)
							G.E_MANAGER:add_event(Event({
								trigger = 'after',
								func = (function()
									prosumable:SEMBY_revive_animation()
									return true
								end)
							}))
							SEMBY_Increase_Blindsize(card.ability.extra.percent, card, true)
						else break end
            		end
					G.E_MANAGER:add_event(Event({
						trigger = 'after',
						func = (function()
							G.GAME.consumeable_buffer = 0
							return true
						end)
					}))
				end
			end
			if context.end_of_round and context.main_eval and context.game_over == false then
				-- Move Joker to Area: "G.jokers"
				--> Update: Allows Joker to gain a Win-Sticker!
				--> "Nerf": Perkeo doesn't Duplicate this Joker
				G.E_MANAGER:add_event(Event({
					func = function()
						if card.area and card.area ~= G.jokers then
							card.area:remove_card(card)
							card:add_to_deck()
							G.jokers:emplace(card)
						end
						return true
					end
				}))
				return nil, false
			end
		end
	end
}
