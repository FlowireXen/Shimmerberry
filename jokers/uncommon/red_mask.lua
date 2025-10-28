SMODS.Joker {
	key = "red_mask",
	name = "SEMBY_red_mask",
	atlas = "SEMBY_jokers",
	pos = { x = 9, y = 1 },
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
	rarity = 2,
	cost = 6,
	config = {
		extra = {
			chips = 0,
			chip_mod = 8
		}
	},
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
		return { vars = {
			card.ability.extra.chip_mod,
			card.ability.extra.chips
		} }
	end,
	calculate = function(self, card, context)
		if not context.blueprint and not self.getting_sliced then
			if context.playing_card_added
			--or context.cards_destroyed
			or context.remove_playing_cards
			then
				local chip_mod = 0
				-- Adding Cards
				if context.cards and #context.cards > 0 then
					chip_mod = chip_mod + (#context.cards * card.ability.extra.chip_mod)
				end
				-- Removing Cards
				if context.removed and #context.removed > 0 then
					chip_mod = chip_mod + (#context.removed * card.ability.extra.chip_mod)
				elseif context.glass_shattered and #context.glass_shattered > 0 then
					chip_mod = chip_mod + (#context.glass_shattered * card.ability.extra.chip_mod)
				end
				-- Update Stuffs
				if chip_mod > 0 then
					card.ability.extra.chips = card.ability.extra.chips + chip_mod
					return {
						message = localize('k_upgrade_ex'),
						colour = G.C.CHIPS
					}
				end
			end
		end
		if context.joker_main then
        	return {
        		chips = card.ability.extra.chips
        	}
        end
	end
}
