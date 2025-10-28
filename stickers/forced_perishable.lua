SMODS.Sticker {
    key = "forced_perishable",
	name = "SEMBY_forced_perishable",
    badge_colour = HEX('B659C7'),
	atlas = "SEMBY_stickers",
    pos = { x = 1, y = 0 },
    loc_vars = function(self, info_queue, card)
		-- No Artist Credits, I just Modified a Balatro Texture.
		return { vars = {
			card.ability.perishable_rounds or G.GAME.perishable_rounds,
			card.ability.SEMBY_forced_perish_tally or G.GAME.perishable_rounds
		}}
    end,
    should_apply = function(self, card, center, area, bypass_roll)
		return (bypass_roll or G.GAME.SEMBY_forced_perishable or false)
    end,
    apply = function(self, card, val)
        card.ability[self.key] = val
		card.ability.SEMBY_forced_perish_tally = (card.ability.SEMBY_forced_perish_tally or G.GAME.perishable_rounds)
    end,
    calculate = function(self, card, context)
        if context.end_of_round and not context.repetition and not context.individual then
            card:calculate_forced_perishable()
        end
    end
}

-- Re-Implementation...
function Card:calculate_forced_perishable()
    if self.ability.SEMBY_forced_perishable then
        self.ability.SEMBY_forced_perish_tally = (self.ability.SEMBY_forced_perish_tally or G.GAME.perishable_rounds) - 1
        if self.ability.SEMBY_forced_perish_tally == 0 then
            card_eval_status_text(self, 'extra', nil, nil, nil, {
				message = localize('SEMBY_destroyed_ex'),
				colour = G.C.FILTER,
				delay = 0.45
			})
			--SMODS.debuff_card(self, true, 'SEMBY_forced_perishable')
			SMODS.destroy_cards(self)
        else
            card_eval_status_text(self, 'extra', nil, nil, nil, {
				message = localize{type = 'variable', key = 'a_remaining', vars = {self.ability.SEMBY_forced_perish_tally}},
				colour = G.C.FILTER,
				delay = 0.45
			})
        end
    end
end
