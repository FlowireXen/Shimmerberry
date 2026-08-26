SMODS.Joker {
	key = "vip_ticket",
	SEMBY_art = "unkokat",
	atlas = "SEMBY_jokers_1",
	pos = { x = 4, y = 9 },
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = false,
	rarity = 1,
	cost = 5,
    attributes = {
		'passive'
	},
	enhancement_gate = 'm_bonus',
	loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_bonus
	end,
    add_to_deck = function(self, card, from_debuff)
		G.GAME.SEMBY_bonus_shuffle = (G.GAME.SEMBY_bonus_shuffle or 0) + 1
    end,
    remove_from_deck = function(self, card, from_debuff)
		G.GAME.SEMBY_bonus_shuffle = (G.GAME.SEMBY_bonus_shuffle or 0) - 1
		if G.GAME.SEMBY_bonus_shuffle <= 0 then
			G.GAME.SEMBY_bonus_shuffle = nil
		end
    end
}

local shuffle_ref = CardArea.shuffle
function CardArea:shuffle(_seed)
    local ret_table = shuffle_ref(self, _seed)
    if self == G.deck and G.GAME.SEMBY_bonus_shuffle then
        local vips = {}
        local norms = {}
        for _, playing_card in pairs(self.cards) do
			table.insert(SMODS.has_enhancement(playing_card, 'm_bonus') and vips or norms, playing_card)
        end
        for _, playing_card in ipairs(vips) do
            table.insert(norms, playing_card)
        end
        self.cards = norms
        self:set_ranks()
    end
    return ret_table
end
