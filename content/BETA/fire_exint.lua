SMODS.Joker {
	key = "fire_exint", -- was "fire sale" from COD:Zombies
	loc_txt = {
		name = "Fire Exin't",
		text = {
			"Reduce Shop prices",
			"by {C:money}#1#%{} every played",
			"and {C:attention}unscored{} card,",
			"resets when {C:attention}Boss{}",
			"{C:attention}Blind{} is selected",
			"{C:inactive}(Currently {C:money}#2#%{C:inactive}){}",
		}
	},
	SEMBY_art = "placeholder",
	atlas = "SEMBY_jokers_1",
	pos = { x = 1, y = 8 },
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = false,
	rarity = 2,
	cost = 6,
	config = {
		extra = {
			shop_mod = 0.0,
			value_mod = 0.02
		}
	},
    attributes = {
		'economy', 'boss_blind',
		'shop'
	},
	loc_vars = function(self, info_queue, card)
		return { vars = {
			card.ability.extra.value_mod*100,
			card.ability.extra.shop_mod*100
		} }
	end,
    add_to_deck = function(self, card, from_debuff)
		G.E_MANAGER:add_event(Event({
			func = function()
				SEMBY_Global_ShopMod_Set('fire_exint'..card.sort_id, 1.0-card.ability.extra.shop_mod)
				return true
			end
		}))
    end,
    remove_from_deck = function(self, card, from_debuff)
		G.E_MANAGER:add_event(Event({
			func = function()
				SEMBY_Global_ShopMod_Remove('fire_exint'..card.sort_id)
				return true
			end
		}))
    end,
	calculate = function(self, card, context)
		if not context.blueprint then
			if context.setting_blind and G.GAME.blind.boss and not self.getting_sliced then
        	    if card.ability.extra.shop_mod ~= 0 then
					card.ability.extra.shop_mod = 0
					SEMBY_Global_ShopMod_Set('fire_exint'..card.sort_id, 1.0-card.ability.extra.shop_mod)
        	        return {
        	            message = localize('k_reset'),
        	            colour = G.C.RED
        	        }
				end
			end
			if context.individual and context.cardarea == "unscored" then
				card.ability.extra.shop_mod = card.ability.extra.shop_mod + card.ability.extra.value_mod
				return {
					message = localize{type = 'variable', key = 'SEMBY_percentage', vars = { math.floor(card.ability.extra.value_mod*100) }},
					colour = G.C.MONEY
				}
			end
			if context.after then
				SEMBY_Global_ShopMod_Set('fire_exint'..card.sort_id, 1.0-card.ability.extra.shop_mod)
			end
		end
	end,
    in_pool = function(self, args)
		return G.GAME and G.GAME.SEMBY_any_hand_oneshot
	end
}
