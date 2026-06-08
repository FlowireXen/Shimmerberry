SMODS.Joker {
	key = "coupon_booklet",
	SEMBY_art = "unkokat",
	atlas = "SEMBY_jokers_1",
	pos = { x = 6, y = 6 },
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
    attributes = {
		'economy', 'reroll',
		'shop'
	},
	loc_vars = function(self, info_queue, card)
		local shop_mod = math.floor(card.ability.extra.shop_mod * 100 + 0.5)
		return { vars = { shop_mod * card.ability.extra.state, shop_mod } }
	end,
    add_to_deck = function(self, card, from_debuff)
		G.E_MANAGER:add_event(Event({
			func = function()
				local shop_mod = card.ability.extra.shop_mod * card.ability.extra.state
				SEMBY_Global_ShopMod_Set('coupon_booklet'..card.sort_id, 1.0 - shop_mod)
				return true
			end
		}))
    end,
    remove_from_deck = function(self, card, from_debuff)
		G.E_MANAGER:add_event(Event({
			func = function()
				SEMBY_Global_ShopMod_Remove('coupon_booklet'..card.sort_id)
				return true
			end
		}))
    end,
	calculate = function(self, card, context)
		if context.reroll_shop and not context.blueprint then
			card.ability.extra.state = card.ability.extra.state - 1
			local extra = {}
			if card.ability.extra.state <= 0 then
				extra = {
					message = localize('SEMBY_durability_destroy'),
					colour = G.C.RED,
					G.E_MANAGER:add_event(Event({
						trigger = 'after',
						func = function()
    		        		card:juice_up()
							play_sound('cancel')
							card:start_dissolve()
							return true
						end
					}))
				}
			else
				G.E_MANAGER:add_event(Event({
					func = function()
						local shop_mod = card.ability.extra.shop_mod * card.ability.extra.state
						SEMBY_Global_ShopMod_Set('coupon_booklet'..card.sort_id, 1.0 - shop_mod)
						return true
					end
				}))
			end
			return {
				message = localize{ type = 'variable', key = 'SEMBY_percentage', vars = { math.floor(card.ability.extra.shop_mod * 100 + 0.5) } },
				colour = G.C.RED,
				extra = extra
			}
		end
	end
}
