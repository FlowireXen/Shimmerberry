
-- Texture: Computer in Tarot Colors

SMODS.Consumable {
    key = 'memory_tarot',
	loc_txt = {
		name = "{C:inactive}memory_tarot",
		text = {
            "Enhances {C:attention}#1#{}",
            "selected cards to",
            "{C:attention}Memory Cards{}",
		}
	},
    SEMBY_art = "placeholder",
	atlas = "SEMBY_consumables",
    pos = { x = 4, y = 0 },
    set = "Tarot",
    config = {
        max_highlighted = 2,
        mod_conv = 'm_SEMBY_memory'
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
        return { vars = {
            card.ability.max_highlighted
        } }
    end
}

-- text = {
--   "Enhances {C:attention}#1#{}",
--   "selected cards of",
--   "different suits to",
--   "{C:attention}Memory Cards{}",
-- }
-- can_use = function(self, card)
--   return G.hand and #G.hand.highlighted > 0
--     and #G.hand.highlighted <= card.ability.max_highlighted
--     and SEMBY_count_suits(G.hand.highlighted) == #G.hand.highlighted
-- end
