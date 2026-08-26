SMODS.Joker{
	key = "echoing_joker",
	SEMBY_art = "flowire",
    atlas = 'SEMBY_jokers_1',
    pos = { x = 1, y = 7 },
    eternal_compat = false,
    perishable_compat = true,
    blueprint_compat = false,
    rarity = 3,
    cost = 7,
	config = {
		extra = {
			amount = 2.0
		}
	},
    attributes = {
		'generation',
		'consumable'
	},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { key = 'e_negative_consumable', set = 'Edition', config = { extra = 1 } }
		return { vars = {
			card.ability.extra.amount
		} }
	end,
    calculate = function(self, card, context)
        if context.using_consumeable and not context.blueprint then
			card_eval_status_text(card, 'extra', nil, nil, nil, {
				message = localize('SEMBY_echoed_ex')
			})
			delay(0.2)
			local consumeable = context.consumeable
			for i = 1, math.max(card.ability.extra.amount, 1) do
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.2,
					func = function()
						local echo = copy_card(consumeable, nil, nil, nil, nil)
						echo:set_edition('e_negative', true, true)
						echo:add_to_deck()
						echo:start_materialize({{1, 1, 1, 1}, {0.8, 0.8, 0.8, 0.8}}, true, 0.5)
						G.consumeables:emplace(echo)
						card:juice_up(0.2, 0.2)
						play_sound('tarot'..math.random(1, 2), math.random() + 0.8, 0.5)
						return true;
					end
				}))
			end
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.2,
				func = function()
					card.shattered = true
                	SMODS.destroy_cards(card, nil, true)
					return true
				end
			}))
        end
    end,
    in_pool = function(self, args)
		return true, { allow_duplicates = true }
	end
}
