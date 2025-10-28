SMODS.Voucher {
	key = "urn_old",
	name = "SEMBY_urn_old",
	atlas = "SEMBY_vouchers",
    pos = { x = 1, y = 0 },
	config = {
		extra = {
			limit = 1
		}
	},
    loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
        return { vars = {
			card.ability.extra.limit
		} }
    end,
    redeem = function(self, card)
		SMODS.change_discard_limit(card.ability.extra.limit)
    end
}

SMODS.Voucher {
    key = "urn_cursed",
	name = "SEMBY_urn_cursed",
	atlas = "SEMBY_vouchers",
    pos = { x = 1, y = 1 },
    requires = { 'v_SEMBY_urn_old' },
	config = {
		extra = {
			limit = 2,
			curse = 1
		}
	},
    loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
        return { vars = {
			card.ability.extra.limit,
			card.ability.extra.curse
		} }
    end,
    redeem = function(self, card)
		SMODS.change_discard_limit(card.ability.extra.limit)
        G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.curse
        ease_discard(-card.ability.extra.curse)
    end,
    unlocked = false,
    locked_loc_vars = function(self, info_queue, card)
        return { vars = { 1250, G.PROFILES[G.SETTINGS.profile].career_stats.c_cards_discarded } }
    end,
    check_for_unlock = function(self, args)
        return args.type == 'c_cards_discarded' and G.PROFILES[G.SETTINGS.profile].career_stats[args.statname] >= 1250
    end
}
