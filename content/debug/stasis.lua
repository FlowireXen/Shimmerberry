SMODS.Joker {
	key = "debugstasis",
	SEMBY_art = "placeholder",
	loc_txt = {
		name = "DEBUG{C:green}STASIS",
		text = {
			"{C:blue}Freezes {C:attention}Ante",
			"and {C:attention}Money",
		}
	},
	atlas = "SEMBY_debug",
	pos = { x = 3, y = 0 },
	soul_pos = { x = 3, y = 1 },
	rarity = 1,
	cost = 1242,
	discovered = true,
	blueprint_compat = true,
	in_pool = function(self, args)
		return false
	end,
	calculate = function(self, card, context)
		if context.money_altered then
			local stasis = G.GAME.dollars
			G.E_MANAGER:add_event(Event({
				func = function()
					G.GAME.dollars = stasis
					return true
				end
			}))
		end
		if context.modify_ante then
			return { modify = 0 }
		end
    end
}
