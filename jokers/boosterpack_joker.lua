SMODS.Joker {
	key = "boosterpack_joker",
	loc_txt = {
		name = "Booster Pack",
        text = {
			"{C:attention}#1#{} additional",
			"{C:attention}Booster Packs{}",
			"in each {C:gold}Shop{}"
        },
	},
	rarity = 1,
	cost = 8,
	atlas = "SEMBY_jokers",
	pos = { x = 5, y = 1 },
	blueprint_compat = false,
    config = { extra = { boosterpacks = 2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.boosterpacks } }
    end,
    add_to_deck = function(self, card, from_debuff)
        SMODS.change_booster_limit(card.ability.extra.boosterpacks)
    end,
    remove_from_deck = function(self, card, from_debuff)
        SMODS.change_booster_limit(-card.ability.extra.boosterpacks)
    end
}
