CardSleeves.Sleeve {
    key = "strange_sl",
	SEMBY_art = "flowire",
    atlas = "SEMBY_sleeves",
    pos = { x = 1, y = 0 },
	config = {
		extra = {
			suits = 6,			-- starting deck: "possible suits"
			ranks = 20,			-- starting deck: "possible ranks"
			desc_min = -2,		-- desc. precentage min.
			desc_max = 102,		-- desc. precentage max.
			chips_min = 2,		-- combo. chips min
			chips_max = 11,		-- combo. chips max
			mult_min = -12,		-- combo. mult min
			mult_max = 24,		-- combo. mult max
			muld_mod = 10,		-- combo. mult mod
		}
	},
    loc_vars = function(self)
		local ret_key = nil
        if self.get_current_deck_key() == "b_SEMBY_strange" then
			ret_key = "sleeve_SEMBY_strange_sl_alt"
        end
		return { key = ret_key,
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
    end,
    apply = function(self)
		-- Deck Function
		SMODS.Back.obj_table["b_SEMBY_strange"].apply(self)
		-- Deck + Sleeve
		if (self.get_current_deck_key() == "b_SEMBY_strange") then
        	G.E_MANAGER:add_event(Event({
        	    func = function()
					-- Change Deck-Stats
					for i = #G.playing_cards, 1, -1 do
						-- Chips
						G.playing_cards[i].ability.SEMBY_bonus =
							pseudorandom("SEMBY_strange", self.config.extra.chips_min, self.config.extra.chips_max)
							- G.playing_cards[i].base.nominal
						G.playing_cards[i].ability.perma_bonus =
							(G.playing_cards[i].ability.perma_bonus or 0)
							+ G.playing_cards[i].ability.SEMBY_bonus
						-- Mult
						G.playing_cards[i].ability.SEMBY_mult = math.floor(
							pseudorandom("SEMBY_strange", self.config.extra.mult_min, self.config.extra.mult_max)
							/ self.config.extra.muld_mod )
						G.playing_cards[i].ability.perma_mult =
							(G.playing_cards[i].ability.perma_mult or 0)
							+ G.playing_cards[i].ability.SEMBY_mult
					end
        	        return true
        	    end
        	}))
		end
    end,
    calculate = function(self, sleeve, context)
		if (self.get_current_deck_key() == "b_SEMBY_strange") then
			local ret_val = SMODS.Back.obj_table["b_SEMBY_strange"].calculate(self, sleeve, context)
			if context.individual and context.cardarea == G.play then
				local strange_card = context.other_card
				-- Randomize Card-Stats
				G.E_MANAGER:add_event(Event({
					func = function()
						-- Reset Previous Chips
						if strange_card.ability.SEMBY_bonus then
							strange_card.ability.perma_bonus =
								(strange_card.ability.perma_bonus or 0)
								- strange_card.ability.SEMBY_bonus
						end
						-- Apply New Chips
						strange_card.ability.SEMBY_bonus =
							pseudorandom("SEMBY_strange", self.config.extra.chips_min, self.config.extra.chips_max)
							- strange_card.base.nominal
						strange_card.ability.perma_bonus =
							(strange_card.ability.perma_bonus or 0)
							+ strange_card.ability.SEMBY_bonus
						-- Reset Previous Mult
						if strange_card.ability.SEMBY_mult then
							strange_card.ability.perma_mult =
								(strange_card.ability.perma_mult or 0)
								- strange_card.ability.SEMBY_mult
						end
						-- Apply New Mult
						strange_card.ability.SEMBY_mult = math.floor(
							pseudorandom("SEMBY_strange", self.config.extra.mult_min, self.config.extra.mult_max)
							/ self.config.extra.muld_mod )
						strange_card.ability.perma_mult =
							(strange_card.ability.perma_mult or 0)
							+ strange_card.ability.SEMBY_mult
						return true
					end
				}))
			end
			return ret_val
		else
			return SMODS.Back.obj_table["b_SEMBY_strange"].calculate(self, sleeve, context)
		end
    end,
    unlocked = false,
    unlock_condition = { deck = "b_SEMBY_strange", stake = "stake_black" },
}
