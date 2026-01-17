-- Reworked Vanilla:
function SEMBY_change_shop_size(mod)
    if not G.GAME.shop then return end
    G.GAME.shop.joker_max = G.GAME.shop.joker_max + mod
    if G.shop_jokers and G.shop_jokers.cards then
        -- Don't remove jokers in shop.
        G.shop_jokers.config.card_limit = G.GAME.shop.joker_max
        G.shop_jokers.T.w = math.min(G.GAME.shop.joker_max*1.02*G.CARD_W,4.08*G.CARD_W)
        G.shop:recalculate()
        for i = 1, G.GAME.shop.joker_max - #G.shop_jokers.cards do
            G.shop_jokers:emplace(create_card_for_shop(G.shop_jokers))
        end
    end
end
-- Joker:
SMODS.Joker {
	key = "stocked_shelves",
	name = "SEMBY_stocked_shelves",
	atlas = "SEMBY_jokers",
	pos = { x = 4, y = 5 },
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = false,
	rarity = 1,
	cost = 4,
	config = {
		extra = {
			slots = 1
		}
	},
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
		return { vars = {
			card.ability.extra.slots,
		} }
	end,
    add_to_deck = function(self, card, from_debuff)
		SMODS.change_voucher_limit(card.ability.extra.slots)
        SMODS.change_booster_limit(card.ability.extra.slots)
        G.E_MANAGER:add_event(Event({func = function()
            SEMBY_change_shop_size(card.ability.extra.slots)
			return true
        end}))
    end,
    remove_from_deck = function(self, card, from_debuff)
		SMODS.change_voucher_limit(-card.ability.extra.slots)
        SMODS.change_booster_limit(-card.ability.extra.slots)
        G.E_MANAGER:add_event(Event({func = function()
            SEMBY_change_shop_size(-card.ability.extra.slots)
			return true
        end}))
    end
}
