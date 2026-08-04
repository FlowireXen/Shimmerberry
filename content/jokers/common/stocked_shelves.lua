SMODS.Joker {
	key = "stocked_shelves",
	SEMBY_art = "unkokat",
	atlas = "SEMBY_jokers_1",
	pos = { x = 5, y = 6 },
    eternal_compat = false,
    perishable_compat = true,
    blueprint_compat = false,
	rarity = 1,
	cost = 4,
	config = {
		extra = {
			-- Durability
			durability = 10,
			durability_max = 10,
			durability_other = { refill = true },
			-- Joker
			durability_diff = 4
		}
	},
    attributes = {
		'passive',
		'shop', 'durability'
	},
	pools = {
        ["Durability"] = true,
    },
	loc_vars = function(self, info_queue, card)
		return { vars = {
			card:SEMBY_durability_amount(),
			card.ability.extra.durability_diff,
			colours = { card:SEMBY_durability_color() }
		} }
	end,
	calculate = function(self, card, context)
        if not context.blueprint then
            local ret_state, ret_uses
            if context.buying_card and not context.buying_self then
                ret_state = context.card == card and 1 or 0
                if context.card.ability.set == "Voucher" then
					if card.ability.extra.durability - card.ability.extra.durability_diff > 0 then
						ret_uses = card.ability.extra.durability_diff
			        	G.E_MANAGER:add_event(Event({
			        		func = function()
			        			SMODS.add_voucher_to_shop()--(nil, true)
			        			return true
			        		end
			        	}))
					else return end
                else
			        G.E_MANAGER:add_event(Event({
			        	func = function()
			        		G.shop_jokers:emplace(create_card_for_shop(G.shop_jokers))
			        		return true
			        	end
			        }))
                end
            end
            if context.open_booster and context.card.SEMBY_origin and context.card.SEMBY_origin == 'shop' then
                ret_state = 0
			    G.E_MANAGER:add_event(Event({
			    	func = function()
			    		SMODS.add_booster_to_shop()
			    		return true
			    	end
			    }))
            end
            if ret_state then
                return {
                    message = localize('SEMBY_restocked_ex'),
                    colour = G.C.GREEN,
					func = function()
                        if ret_state == 0 then
                            card:SEMBY_durability_use(ret_uses)
		    	            card:SEMBY_durability_check()
                        end
						return true
					end
                }
            end
        end
    end
}
