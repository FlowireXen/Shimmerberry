--## Shader
SMODS.Shader {
	key = "shiny",
	path = "shiny.fs"
}

--## Edition
SMODS.Edition {
    key = "shiny",
	name = "SEMBY_shiny",
    shader = "shiny",
    config = {
		base_value = 3.0,
		card_value = 1.0
	},
    in_shop = true,
    weight = 6,
    extra_cost = 0,
    sound = { sound = "SEMBY_shiny", per = 1.2 * 1.58, vol = 0.4 },
    loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
		if card.playing_card or (card.ability and (card.ability.set == "Default" or card.ability.set == "Enhanced")) then
			return {
				key = 'e_SEMBY_shiny_playing_card',
				vars = { (card.edition or {}).card_value or self.config.card_value }
			}
		end
		return {
			vars = { (card.edition or {}).base_value or self.config.base_value }
		}
    end,
    get_weight = function(self)
		if G.GAME.SEMBY_OHH_SHINY then
			return G.GAME.edition_rate * (self.weight * 75)
		end
		return G.GAME.edition_rate * self.weight
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            card.ability.extra_value = card.ability.extra_value + card.edition.base_value
            card:set_cost()
            return {
                message = localize('k_val_up'),
                colour = G.C.MONEY
            }
        end
		if context.main_scoring and context.cardarea == G.play then
			local shiny_card = pseudorandom_element(G.jokers.cards, 'shiny')
			if shiny_card then
				shiny_card.ability.extra_value = shiny_card.ability.extra_value + card.edition.card_value
				shiny_card:set_cost()
				--card_eval_status_text(shiny_card, 'extra', nil, nil, nil, { message = localize('k_val_up'), colour = G.C.MONEY })
				return {
					message = localize('k_val_up'),
					colour = G.C.MONEY,
					G.E_MANAGER:add_event(Event({
						trigger = 'after',
						func = function()
							shiny_card:juice_up()
							return true
						end
					}))
				}
			end
		end
    end
}
