SMODS.Joker {
	key = "pinata",
	SEMBY_art = "unkokat",
	atlas = "SEMBY_jokers_1",
	pos = { x = 0, y = 7 },
    eternal_compat = false,
    perishable_compat = true,
    blueprint_compat = false,
	rarity = 1,
	cost = 6,
	config = {
		extra = {
			numerator = 1,
			denominator = 5,
			slots = 1,
			reward = true,
			breaks = false
		}
	},
    attributes = {
		'hands', 'generation', 'food', 'chance',
		'animal'
	},
	pools = {
        ["Food"] = true,
		["Music"] = true,
		["Numetal"] = true,
    },
	loc_vars = function(self, info_queue, card)
		if Shimmerberry.compat.buffoonery and Buffoonery.config.show_info then
			info_queue[#info_queue+1] = {set = 'Other', key = 'nu_metal_info'}
		end
		local numerator, denominator = SMODS.get_probability_vars(card,
			card.ability.extra.numerator, card.ability.extra.denominator, 'SEMBY_pinata')
		return { vars = {
			numerator,
			denominator,
			card.ability.extra.slots
		} }
	end,
    remove_from_deck = function(self, card, from_debuff)
		if card.ability.extra.reward and not from_debuff then
			G.consumeables.config.card_limit = G.consumeables.config.card_limit + card.ability.extra.slots
			G.GAME.SEMBY_eden_bonus = (G.GAME.SEMBY_eden_bonus or 0) +1
            for i = 0, G.consumeables.config.card_limit do
				if (G.GAME.consumeable_buffer or 0) + #G.consumeables.cards <= G.consumeables.config.card_limit then
					G.GAME.consumeable_buffer = (G.GAME.consumeable_buffer or 0) + 1
					G.E_MANAGER:add_event(Event({
						trigger = 'after',
						delay = 0.2,
						func = (function()
							SMODS.add_card({ set = 'Consumeables', area = G.consumeables, soulable = true, key_append = 'SEMBY_pinata' })
							G.GAME.consumeable_buffer = G.GAME.consumeable_buffer - 1
							return true
						end)
					}))
				else break end
            end
		end
    end,
	calculate = function(self, card, context)
		if not context.blueprint then
			if context.selling_self then
				card.ability.extra.reward = false
			end
			if context.joker_main then
				if SMODS.pseudorandom_probability(card, 'SEMBY_pinata',
					card.ability.extra.numerator, card.ability.extra.denominator)
				then
					card.ability.extra.breaks = true
					return {
						message = localize('SEMBY_hit_ex'),
						colour = G.C.GREEN,
						sound = 'SEMBY_explode',
						volume = 0.8
					}
				else
					return {
						message = localize('SEMBY_miss_ex'),
						colour = G.C.RED,
						sound = 'cancel',
						volume = 0.8
					}
				end
			end
			if context.after and card.ability.extra.breaks then
        		G.GAME.SEMBY_used_pinata = (G.GAME.SEMBY_used_pinata or 0) + 1
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					func = function()
						card.shattered = true
                        SMODS.destroy_cards(card, nil, true)
						return true
					end
				}))
			end
		end
	end,
	in_pool = function(self, args)
		return not G.GAME.SEMBY_used_pinata
	end
}
