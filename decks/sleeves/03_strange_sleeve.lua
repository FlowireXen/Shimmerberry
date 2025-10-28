CardSleeves.Sleeve {
    key = "strange_sl",
	name = "SEMBY_strange_sl",
    atlas = "SEMBY_sleeves",
    pos = { x = 1, y = 0 },
	config = {
		extra = {
			suits = 6,			-- starting deck: "possible suits"
			ranks = 20,			-- starting deck: "possible ranks"
			desc_min = -2,		-- desc. precentage min.
			desc_max = 102,		-- desc. precentage max.
			bonus_size = 100,	-- blind-size mod.
			bonus_price = 50	-- shop-price mod.
		}
	},
    loc_vars = function(self)
		--SEMBY_Queue_Artist(self, info_queue)
        if self.get_current_deck_key() == "b_SEMBY_strange" then
			return { key = "sleeve_SEMBY_strange_sl_alt" }
        else
			return {
				-- TODO: Have a changing Value like "Misprint" in V3.0
				vars = { 
					math.random(self.config.extra.desc_min, self.config.extra.desc_max),
					math.random(1, 5) == 1 and '#' or '%',
					colours = {
						math.random(1, 6) == 1 and G.C.BLUE or math.random(1, 6) == 1 and G.C.RED or G.C.ORANGE,
						math.random(1, 6) == 1 and G.C.BLUE or math.random(1, 6) == 1 and G.C.ORANGE or G.C.L_BLACK
					}
				}
			}
        end
    end,
    apply = function(self)
		if (self.get_current_deck_key() == "b_SEMBY_strange") then
			-- Random Blind-Size Modifier:
			G.GAME.SEMBY_strange_blind_mod = pseudorandom("SEMBY_strange_sl", -self.config.extra.bonus_size, self.config.extra.bonus_size) / 100
			G.GAME.SEMBY_blind_mod = (G.GAME.SEMBY_blind_mod or 1.0) + G.GAME.SEMBY_strange_blind_mod
			-- Random Shop-Price Modifier:
			G.GAME.SEMBY_strange_shop_mod = pseudorandom("SEMBY_strange_sl", -self.config.extra.bonus_price, self.config.extra.bonus_price) / 100
			G.GAME.SEMBY_shop_mod = (G.GAME.SEMBY_shop_mod or 1.0) + G.GAME.SEMBY_strange_shop_mod
			for k, v in pairs(G.I.CARD) do
				if v.set_cost then v:set_cost() end
			end
		else -- Any other Deck:
			SMODS.Back.obj_table["b_SEMBY_strange"].apply(self)
		end
    end,
    calculate = function(self, sleeve, context)
		if (self.get_current_deck_key() == "b_SEMBY_strange") then
			if context.end_of_round and context.main_eval and context.game_over == false then
				-- New Random Blind-Size Modifier:
				G.GAME.SEMBY_blind_mod = (G.GAME.SEMBY_blind_mod or 1.0) - (G.GAME.SEMBY_strange_mod or 0.0)
				G.GAME.SEMBY_strange_mod = pseudorandom("SEMBY_strange_sl", -self.config.extra.bonus_size, self.config.extra.bonus_size) / 100
				G.GAME.SEMBY_blind_mod = G.GAME.SEMBY_blind_mod + G.GAME.SEMBY_strange_mod
				-- New Random Shop-Price Modifier:
				G.GAME.SEMBY_shop_mod = (G.GAME.SEMBY_shop_mod or 1.0) - (G.GAME.SEMBY_strange_shop_mod or 0.0)
				G.GAME.SEMBY_strange_shop_mod = pseudorandom("SEMBY_strange_sl", -self.config.extra.bonus_price, self.config.extra.bonus_price) / 100
				G.GAME.SEMBY_shop_mod = (G.GAME.SEMBY_shop_mod or 1.0) + G.GAME.SEMBY_strange_shop_mod
				for k, v in pairs(G.I.CARD) do
					if v.set_cost then v:set_cost() end
				end
			end
		else -- Any other Deck:
			return SMODS.Back.obj_table["b_SEMBY_strange"].calculate(self, sleeve, context)
		end
    end,
    unlocked = false,
    unlock_condition = { deck = "b_SEMBY_strange", stake = "stake_black" },
}
