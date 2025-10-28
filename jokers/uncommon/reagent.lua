SMODS.Joker {
	key = "reagent",
	name = "SEMBY_reagent",
	atlas = "SEMBY_jokers",
	pos = { x = 10, y = 4 },
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
	rarity = 2,
	cost = 6,
	config = {
		extra = {
			xmult = 2.5,
			xmult_mod = 0.1
		}
	},
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
		local xmult_ret = card.ability.extra.xmult
        for _, playing_card in ipairs(G.playing_cards or {}) do
			if xmult_ret > 1.0 then
				if next(SMODS.get_enhancements(playing_card)) then
					xmult_ret = xmult_ret - card.ability.extra.xmult_mod
				end
			else break end
        end
		return { vars = {
			xmult_ret,
			card.ability.extra.xmult_mod
		} }
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			local xmult_ret = card.ability.extra.xmult
			for _, playing_card in ipairs(G.playing_cards or {}) do
				if xmult_ret > 1.0 then
					if next(SMODS.get_enhancements(playing_card)) then
						xmult_ret = xmult_ret - card.ability.extra.xmult_mod
					end
				else break end
			end
			if xmult_ret > 1.0 then
				return { xmult = xmult_ret }
			else
				local juice_card = (context.blueprint_card or card)
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.2,
					func = function()
						juice_card:juice_up(0.1, 0.2)
						play_sound('cancel')
						return true
					end
				}))
				delay(0.2)
				return nil, true
			end
        end
	end
}
