SMODS.Consumable {
    key = 'backup',
    SEMBY_art = "placeholder",
	atlas = "SEMBY_consumables",
    pos = { x = 3, y = 0 },
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
