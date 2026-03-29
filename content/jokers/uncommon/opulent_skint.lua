SMODS.Joker {
	key = "opulent_skint",
	name = "SEMBY_opulent_skint",
	atlas = "SEMBY_jokers",
	pos = { x = 8, y = 4 },
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
	rarity = 2,
	cost = 5,
	config = {
		extra = {
			base_rarity = 1.05,
			rarity_mod = 100,
			legend_limit = 1.15
		}
	},
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
	end,
    remove_from_deck = function(self, card, from_debuff)
		if G.shop and G.shop_jokers and G.shop_jokers.cards then
			G.shop_jokers.T.w = math.min((#G.shop_jokers.cards-1)*1.02*G.CARD_W,4.08*G.CARD_W)
			G.shop:recalculate()
		end
    end,
	calculate = function(self, card, context)
		-- Thank you SMODS for the "starting_shop"-context!
		if context.starting_shop then
			local rarity = math.max(0.00, card.ability.extra.base_rarity - (math.floor(G.GAME.dollars) / card.ability.extra.rarity_mod))
			local legend = (rarity >= card.ability.extra.legend_limit) -- Being in debt generates a Legendary
			return {
				message = localize('k_plus_joker'),
				colour = G.C.MONEY,
				G.E_MANAGER:add_event(Event({
					func = function()
						if G.shop_jokers and G.shop_jokers.cards then
							-- Temporary Shop Spacing
							G.shop_jokers.T.w = math.min((#G.shop_jokers.cards+1)*1.02*G.CARD_W,4.08*G.CARD_W)
							G.shop:recalculate()
							-- Add Item to Shop:
							local shop_card = SMODS.create_card({
								set = 'Joker',
								area = G.shop_jokers,
								legendary = legend,
								rarity = rarity
							})
							create_shop_card_ui(shop_card)
							G.shop_jokers:emplace(shop_card)
							-- Save, otherwise they're gone later...
							G.E_MANAGER:add_event(Event({ func = function() save_run(); return true end}))
						end
						return true
					end
				}))
			}
        end
        if context.reroll_shop and G.GAME.shop.SEMBY_Opulent then
			G.shop_jokers.T.w = math.min(#G.shop_jokers.cards*1.02*G.CARD_W,4.08*G.CARD_W)
			G.shop:recalculate()
		end
	end
}
