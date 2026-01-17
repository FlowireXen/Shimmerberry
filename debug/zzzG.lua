SMODS.Joker {
	key = "debuggain",
	name = "SEMBY_debuggain",
	loc_txt = { name = "DEBUG{C:blue}GAIN", text = {
		"{C:blue}+5{} Play limit",
		"{C:red}+5{} Discard limit"
	} },
	atlas = "SEMBY_jokers",
	pos = { x = 0, y = 0 },
	display_size = { w = 35.5, h = 47.5 },
	rarity = 1, cost = 1242,
	unlocked = true,
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
