SMODS.Joker {
	key = "doomsday_device",
	loc_txt = {
		name = "{C:inactive}doomsday_device",
		text = {
			"{X:SEMBY_percent,C:white}X#1#{} {C:enhanced}Memory Card{} values,",
			"{C:enhanced}Memory Cards{} directly",
			"add to the {C:attention}round score{}",
		}
	},
	SEMBY_art = "placeholder",
	atlas = "SEMBY_jokers_1",
	pos = { x = 7, y = 8 },
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = false,
	rarity = 3,
	cost = 6,
	config = {
		extra = {
			SEMBY_memory_mod = 5
		}
	},
    attributes = {
		'enhancements', 'score', 'passive', 'modify_card'
	},
	enhancement_gate = 'm_SEMBY_memory',
	loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_SEMBY_memory
		local ret_val = card.ability.extra.SEMBY_memory_mod
		if G.GAME.SEMBY_memory_mods then
			for i = 1, #G.GAME.SEMBY_memory_mods do
				if G.GAME.SEMBY_memory_mods[i].id == card.sort_id then
					ret_val = G.GAME.SEMBY_memory_mods[i].mod
					break
				end
			end
		end
		return { vars = { ret_val } }
	end,
    add_to_deck = function(self, card, from_debuff)
		if not G.GAME.SEMBY_memory_mods then G.GAME.SEMBY_memory_mods = {} end
		G.GAME.SEMBY_memory_mods[#G.GAME.SEMBY_memory_mods + 1] = { id = card.sort_id, mod = card.ability.extra.SEMBY_memory_mod }
		G.GAME.SEMBY_memory_mod = (G.GAME.SEMBY_memory_mod or 1) * card.ability.extra.SEMBY_memory_mod
    end,
    remove_from_deck = function(self, card, from_debuff)
		if G.GAME.SEMBY_memory_mods then
			for i = 1, #G.GAME.SEMBY_memory_mods do
				if G.GAME.SEMBY_memory_mods[i].id == card.sort_id then
					G.GAME.SEMBY_memory_mod = G.GAME.SEMBY_memory_mod / G.GAME.SEMBY_memory_mods[i].mod
					table.remove(G.GAME.SEMBY_memory_mods, index)
					break
				end
			end
			if #G.GAME.SEMBY_memory_mods == 0 then
				G.GAME.SEMBY_memory_mods = nil
				G.GAME.SEMBY_memory_mod = nil
			end
		end
    end
}
