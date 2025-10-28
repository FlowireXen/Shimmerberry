SMODS.Joker {
	key = "adblocker",
	name = "SEMBY_adblocker",
	atlas = "SEMBY_jokers",
	pos = { x = 10, y = 2 },
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
	rarity = 3,
	cost = 8,
	config = {
		extra = {
			debuffed = false,
			dollars = 2
		}
	},
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
		local ret_val
		local ret_col
		if card.ability.extra.debuffed then
			ret_val = localize(card.ability.extra.debuffed, 'suits_plural')
			ret_col = G.C.SUITS[card.ability.extra.debuffed]
		else
			ret_val = localize('SEMBY_nothing')
			ret_col = G.C.UI.TEXT_INACTIVE
		end
		return { vars = {
			ret_val,
			card.ability.extra.dollars,
			colours = { ret_col }
		} }
	end,
    add_to_deck = function(self, card, from_debuff)
		if not from_debuff then
			card.ability.extra.debuffed = false
		end
    end,
    remove_from_deck = function(self, card, from_debuff)
		card.ability.extra.debuffed = false
		for _, playing_card in ipairs(G.playing_cards) do
			SMODS.debuff_card(playing_card, false, card.sort_id)
		end
    end,
	calculate = function(self, card, context)
		if context.setting_blind and not (self.getting_sliced or context.blueprint) then
			local suit = pseudorandom_element(SMODS.Suits, pseudoseed('SEMBY_adblocker'))
			card.ability.extra.debuffed = suit.key
			G.E_MANAGER:add_event(Event({
				func = function()
					for _, playing_card in ipairs(G.playing_cards) do
						if playing_card:is_suit(suit.key) then
							SMODS.debuff_card(playing_card, true, card.sort_id)
						end
					end
					return true
				end
			}))
			return {
				message = localize('k_debuffed'),
				colour = G.C.BLACK
			}
        end
		if context.before then
			local continue = false
			for _, playing_card in ipairs(context.full_hand) do
				if playing_card.debuff then continue = true break end
			end
			if continue then
				local juice_card = (context.blueprint_card or card)
				return {
					message = localize('SEMBY_blocked_ex'),
					colour = G.C.BLACK,
					func = function()
						delay(0.4)
						for _, playing_card in ipairs(context.full_hand) do
							if playing_card.debuff then
								ease_dollars(card.ability.extra.dollars)
								G.E_MANAGER:add_event(Event({ func = function() juice_card:juice_up() return true end }))
								card_eval_status_text(playing_card, 'extra', nil, nil, nil, {
									message = localize{type = 'variable', key = 'SEMBY_money', vars = { card.ability.extra.dollars }},
									colour = G.C.MONEY
								})
							end
						end
					end
				}
			end
		end
		if context.end_of_round and context.main_eval and context.game_over == false and not context.blueprint then
			if card.ability.extra.debuffed then
				card.ability.extra.debuffed = false
				return {
					message = localize('k_reset'),
					colour = G.C.ATTENTION,
					func = function()
						for _, playing_card in ipairs(G.playing_cards) do
							SMODS.debuff_card(playing_card, false, card.sort_id)
						end
					end
				}
			end
		end
	end
}
