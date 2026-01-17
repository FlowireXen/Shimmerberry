SMODS.Joker {
	key = "coupon_booklet",
	name = "SEMBY_coupon_booklet",
	atlas = "SEMBY_jokers",
	pos = { x = 5, y = 5 },
    unlocked = true,
    discovered = false,
    eternal_compat = false,
    perishable_compat = true,
    blueprint_compat = false,
	rarity = 2,
	cost = 6,
	config = {
		extra = {
			shop_mod = 0.1,
			state = 5
		}
	},
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
		local shop_mod = math.floor(card.ability.extra.shop_mod * 100 + 0.5)
		return { vars = { shop_mod * card.ability.extra.state, shop_mod } }
	end,
    add_to_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({func = function()
			G.GAME.SEMBY_shop_mod = (G.GAME.SEMBY_shop_mod or 1.0) - (card.ability.extra.shop_mod * card.ability.extra.state)
			for k, v in pairs(G.I.CARD) do
				if v.set_cost then v:set_cost() end
			end
		return true end }))
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({func = function()
			G.GAME.SEMBY_shop_mod = G.GAME.SEMBY_shop_mod + (card.ability.extra.shop_mod * card.ability.extra.state)
			for k, v in pairs(G.I.CARD) do
				if v.set_cost then v:set_cost() end
			end
		return true end }))
    end,
	calculate = function(self, card, context)
		--if context.buying_card and context.cardarea == G.jokers and not context.blueprint then
		if context.reroll_shop and context.cardarea == G.jokers and not context.blueprint then
			card.ability.extra.state = card.ability.extra.state - 1
			local extra = {}
			if card.ability.extra.state <= 0 then
				extra = {
					message = localize('SEMBY_durability_destroy'),
					colour = G.C.RED,
					G.E_MANAGER:add_event(Event({
						trigger = 'after',
						func = function()
							play_sound('cancel')
							card:start_dissolve()
							return true
						end
					}))
				}
			end
        	G.E_MANAGER:add_event(Event({func = function()
				G.GAME.SEMBY_shop_mod = G.GAME.SEMBY_shop_mod + card.ability.extra.shop_mod
				for k, v in pairs(G.I.CARD) do
					if v.set_cost then v:set_cost() end
				end
			return true end }))
			return {
				message = localize{ type = 'variable', key = 'SEMBY_percentage', vars = { card.ability.extra.shop_mod * 100 } },
				colour = G.C.RED,
				extra = extra
			}
		end
	end
}
