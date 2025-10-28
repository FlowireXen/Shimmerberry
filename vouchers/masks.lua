SMODS.Voucher {
	key = "mask_comedy", --> Texture technically doesn't match
	name = "SEMBY_mask_comedy",
	atlas = "SEMBY_vouchers",
    pos = { x = 0, y = 0 },
	config = {
		extra = {
			percent = 0.1,
			hand_size = 1
		}
	},
    loc_vars = function(self, info_queue, card)
		local percent = 100 * card.ability.extra.percent
		SEMBY_Queue_Artist(card, info_queue)
        return { vars = {
			percent,
			card.ability.extra.hand_size
		} }
    end,
    redeem = function(self, card)
		G.GAME.SEMBY_blind_mod = (G.GAME.SEMBY_blind_mod or 1.0) - card.ability.extra.percent
        G.hand:change_size(-card.ability.extra.hand_size)
    end
}

SMODS.Voucher {
    key = "mask_tragedy",
	name = "SEMBY_mask_tragedy",
	atlas = "SEMBY_vouchers",
    pos = { x = 0, y = 1 },
    requires = { 'v_SEMBY_mask_comedy' },
	config = {
		extra = {
			percent = 0.15,
			hand_size = 1
		}
	},
    loc_vars = function(self, info_queue, card)
		local percent = 100 * card.ability.extra.percent
		SEMBY_Queue_Artist(card, info_queue)
        return { vars = {
			percent,
			card.ability.extra.hand_size
		} }
    end,
    redeem = function(self, card)
		G.GAME.SEMBY_blind_mod = (G.GAME.SEMBY_blind_mod or 0.9) - card.ability.extra.percent
        G.hand:change_size(-card.ability.extra.hand_size)
    end,
    unlocked = false,
    locked_loc_vars = function(self, info_queue, card)
        return { vars = { 10 } }
    end,
    check_for_unlock = function(self, args)
        if args.type == 'blind_discoveries' then
            local discovered_blinds = 0
            for k, v in pairs(G.P_BLINDS) do
                if v.discovered then
                    discovered_blinds = discovered_blinds + 1
                end
            end
            return discovered_blinds >= 10
        end
        return false
    end
}
