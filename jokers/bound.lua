SMODS.Joker{
	key = "bound",
	loc_txt = {
		name = "Bound Joker",
		text = {
			"{C:attention}+#1#{} Joker slots",
			"{C:red}Disable{} and {C:red}Destroy{}",
			"{C:attention}leftmost{} joker at",
			"beginning of round"
		}
	},
    atlas = 'SEMBY_jokers',
    pos = { x = 1, y = 1 },
    rarity = 2,
    cost = 9,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = false,
    blueprint_compat = false,
	config = {
		extra = { slots = 4 }
	},
	loc_vars = function(self, info_queue, card)
        return {
            vars = {card.ability.extra.slots}
        }
    end,
    add_to_deck = function(self, card, from_debuff)
        if G.jokers then
			G.jokers.config.card_limit = G.jokers.config.card_limit + card.ability.extra.slots  -- Adds joker slots when added
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        if G.jokers then
            G.jokers.config.card_limit = G.jokers.config.card_limit - card.ability.extra.slots  -- Removes the slots when removed
        end
    end,
	calculate = function(self, card, context)
        if context.setting_blind and G and G.jokers and G.jokers.cards and not context.blueprint then
			if #G.jokers.cards > 0 then
				if G.jokers.cards[1] == self then
					self:set_debuff(true)
					self:start_dissolve()
				else
					G.jokers.cards[1]:set_debuff(true)
					G.jokers.cards[1]:start_dissolve()
				end
			end
			return --true
        end
	end
}
