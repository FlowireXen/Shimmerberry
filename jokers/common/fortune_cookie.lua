SMODS.Joker {
	key = "fortune_cookie",
	name = "SEMBY_fortune_cookie",
	atlas = "SEMBY_jokers",
	pos = { x = 6, y = 0 },
    unlocked = true,
    discovered = false,
    eternal_compat = false,
    perishable_compat = true,
    blueprint_compat = false,
	rarity = 1,
	cost = 6,
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
		if card.edition and card.edition.key then
			local loc_key = G.localization.descriptions.Edition[card.edition.key]
			if loc_key and loc_key.name then
				return { vars = {
					loc_key.name
				} }
			end
		end
		return { vars = {
			localize('SEMBY_this_edition')
		} }
	end,
	set_ability = function(self, card, initial, delay_sprites)
		if card.config.center.discovered and initial then
			G.E_MANAGER:add_event(Event({
				func = function()
					card:set_edition(poll_edition(nil, nil, nil, true))
					return true
				end
			}))
		end
	end,
	calculate = function(self, card, context)
		if context.setting_blind and not (self.getting_sliced or context.blueprint) then
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.2,
				func = function()
					card:flip()
					play_sound('card1')
					return true
				end
			}))
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.2,
				func = function()
					card:set_edition(poll_edition(nil, nil, nil, true))
					card:flip()
					play_sound('card1')
					return true
				end
			}))
			delay(0.2)
			return nil, true
        end
		if context.selling_self and not context.blueprint_card then
			if card.edition then
				return {
					G.E_MANAGER:add_event(Event({
						trigger = 'after',
						delay = 0.2,
						func = function()
							if G.jokers and #G.jokers.cards > 1 then
								local valid_pool = {}
								for k, v in pairs(G.jokers.cards) do
									if v.ability.set == 'Joker' and (not v.edition) then
										table.insert(valid_pool, v)
									end
								end
								if valid_pool and #valid_pool > 0 then
									card:juice_up()
									local eligible_card = pseudorandom_element(valid_pool, pseudoseed("fortune_cookie"))
									eligible_card:set_edition(card.edition.key, true)
								end
							end
							return true
						end
					}))
				}
			end
		end
	end
}
