SMODS.Joker {
	key = "chaos_jevil",
	loc_txt = {
		name = "JEV][L",
		text = {
			"Generates a random",
			"{C:dark_edition}Negative{} {C:attention}Consumable{}",
			"at beginning of round,",
			"{C:green}#1# in #2#{} to replace it",
			"with a random \"{C:spectral}Joker{}\"",
			"instead {C:inactive}(#3#/#4# Left){}"
		}
	},
	rarity = 4,
	blueprint_compat = true,
	eternal_compat = true,
    atlas = 'SEMBY_jokers',
    pos = { x = 9, y = 0 },
	soul_pos = { x = 9, y = 1 },
	cost = 20,
	config = { extra = { odds = 5, jokers = 3, amount = 3 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds, card.ability.extra.jokers, card.ability.extra.amount } }
	end,
	calculate = function(self, card, context)
		if (context.setting_blind and not (context.blueprint_card or card).getting_sliced) then
			local color = nil
			local msg = nil
			local chaos = nil
			G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
			if pseudorandom("chaos_jevil") < G.GAME.probabilities.normal / card.ability.extra.odds and card.ability.extra.jokers > 0 then
				color = G.C.SPECTRAL
				msg = "A CHAOS, CHAOS!"
				chaos = create_card('Joker', G.consumeables, nil, nil, nil, nil, nil, 'chaos_jevil')
				chaos:set_edition()
				chaos:set_perishable(true)
				chaos.sell_cost = to_big(-3)
				if G.consumeables then
					G.consumeables.config.card_limit = G.consumeables.config.card_limit + 1 -- permanent upgrade...
				end
				card.ability.extra.jokers = card.ability.extra.jokers - 1
			else
				color = G.C.GOLD
				if card.ability.extra.jokers <= 0 then
					msg = "WHAT FUN!! I'M EXHAUSTED!!"
				else
					msg = "I CAN DO ANYTHING!!"
				end
				chaos = create_card('Consumeables', G.consumeables, nil, nil, nil, nil, nil, 'chaos_jevil')
				chaos:set_edition('e_negative', true)
				chaos.sell_cost = to_big(-1)
			end
			G.E_MANAGER:add_event(Event({
				func = function()
					chaos:add_to_deck()
					chaos:start_materialize()
					G.consumeables:emplace(chaos)
					G.GAME.consumeable_buffer = 0
					return true
				end
			}))
			card_eval_status_text(context.blueprint_card or chaos, 'extra', nil, nil, nil, { message = msg, colour = color })
			card:juice_up(0.3, 0.4)
			return --true
        end
	end
}
