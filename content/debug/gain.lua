SMODS.Joker {
	key = "debuggain",
	SEMBY_art = "placeholder",
	loc_txt = {
		name = "DEBUG{C:blue}GAIN",
		text = {
			"{C:blue}+5{} Play limit",
			"{C:red}+5{} Discard limit"
		}
	},
	atlas = "SEMBY_debug",
	pos = { x = 3, y = 0 },
	soul_pos = { x = 1, y = 1 },
	rarity = 1,
	cost = 1242,
	discovered = true,
	blueprint_compat = false,
	in_pool = function(self, args)
		return false
	end,
    add_to_deck = function(self, card, from_debuff)
		SMODS.change_play_limit(5)
		SMODS.change_discard_limit(5)
	end,
    remove_from_deck = function(self, card, from_debuff)
		SMODS.change_play_limit(-5)
		SMODS.change_discard_limit(-5)
	end
}
