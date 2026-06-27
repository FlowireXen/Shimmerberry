SMODS.Joker {
	key = "opulent_skint",
	SEMBY_art = "unkokat",
	atlas = "SEMBY_jokers_1",
	pos = { x = 6, y = 2 },
    eternal_compat = false,
    perishable_compat = true,
    blueprint_compat = false,
	rarity = 2,
	cost = 10,
	config = {
		extra = {
			numerator = 1,
			denominator = 256
		}
	},
    attributes = {
		'generation', 'destroy_card',
		'shop'
	},
	loc_vars = function(self, info_queue, card)
		local numerator, denominator = SMODS.get_probability_vars(card,
			card.ability.extra.numerator, card.ability.extra.denominator, 'SEMBY_opulent_skint')
		return { vars = {
			numerator,
			denominator
		} }
	end,
	calculate = function(self, card, context)
		if not context.blueprint then
			-- Gain a Legendary ..Maybe:
			if context.buying_self then
				delay(0.1)
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.15,
					func = function()
						card:flip()
						play_sound('card1', 1.12 + math.random()*0.06)
						card:juice_up(0.3)
						return true
					end
				}))
				delay(0.2)
				local success = SMODS.pseudorandom_probability(card, 'SEMBY_opulent_skint', card.ability.extra.numerator, card.ability.extra.denominator)
				if success then --> Give Legendary
					G.E_MANAGER:add_event(Event({
						trigger = 'after',
						delay = 0.15,
						func = function()
							local legend = SMODS.create_card({ set = 'Joker', legendary = true })
							if legend.config.center_key == 'j_joker' then
								legend:remove(); legend = SMODS.create_card({ set = 'Joker', legendary = true, allow_duplicates = true })
							end
							copy_card(legend, card)
							legend:remove();
							return true
						end
					}))
				else delay(0.15) end
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.15,
					func = function()
						card:flip()
						play_sound('card1', 1.08 + math.random()*0.04)
						card:juice_up(0.3)
						return true
					end
				}))
				if success then
					G.E_MANAGER:add_event(Event({
						trigger = 'after',
						delay = 0.4,
						func = function()
							play_sound('timpani')
							card:juice_up()
							check_for_unlock { type = 'spawn_legendary' }
							return true
						end
					}))
				end
			end
			-- Replace Shop-Joker:
			if context.selling_self then
				if G.shop_jokers and next(G.shop_jokers.cards) then
					selected_card = pseudorandom_element(G.shop_jokers.cards, 'SEMBY_opulent_skint')
					if selected_card then
            			G.E_MANAGER:add_event(Event({
							trigger = 'after',
							delay = 0.15,
            			    func = function()
								play_sound('generic1', 0.9 + math.random()*0.2)
            			        return true
            			    end
            			}))
						-- Remove "selected_card"
						selected_card.getting_sliced = true
						selected_card.skip_destroy_animation = true
						selected_card.SEMBY_shut_up = true
						selected_card:start_dissolve()
						-- Create Replacement (in Shop)
						local replacement = copy_card(card)
						replacement.states.visible = nil
						G.shop_jokers:emplace(replacement)
            			G.E_MANAGER:add_event(Event({
							trigger = 'after',
							delay = 0.15,
            			    func = function()
								replacement.states.visible = true
								replacement:juice_up(0.3)
								create_shop_card_ui(replacement)
								replacement:set_cost()
            			        return true
            			    end
            			}))
					end
				end
			end
		end
	end
}
