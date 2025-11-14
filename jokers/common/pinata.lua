SMODS.Joker {
	key = "pinata",
	name = "SEMBY_pinata",
	atlas = "SEMBY_jokers",
	pos = { x = 5, y = 2 },
    unlocked = true,
    discovered = false,
    eternal_compat = false,
    perishable_compat = true,
    blueprint_compat = false,
	rarity = 1,
	cost = 6,
	config = {
		extra = {
			chance = 5,
			slots = 1,
			reward = true,
			breaks = false
		}
	},
	pools = {
        Food = true,
    },
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
		local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.chance, 'SEMBY_pinata')
		return { vars = {
			numerator,
			denominator,
			card.ability.extra.slots
		} }
	end,
    remove_from_deck = function(self, card, from_debuff)
		if card.ability.extra.reward and not from_debuff then
			G.consumeables.config.card_limit = G.consumeables.config.card_limit + card.ability.extra.slots
            for i = 1, G.consumeables.config.card_limit do
				if G.GAME.consumeable_buffer + #G.consumeables.cards < G.consumeables.config.card_limit then
					G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
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
				if SMODS.pseudorandom_probability(card, 'SEMBY_pinata', 1, card.ability.extra.chance) then
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
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					func = function()
						card:shatter()
						return true
					end
				}))
			end
		end
	end,
--> Potential nerf for V3.0:
--	in_pool = function(self, args)
--		if G.consumeables then
--			return (G.consumeables.config.card_limit <= 5)
--		end
--	end
}
