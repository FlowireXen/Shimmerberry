-- Sticker Code
SMODS.Sticker {
    key = "degrading",
	SEMBY_art = "flowire",
    badge_colour = G.C.SEMBY_DEGRADING,
	atlas = "SEMBY_stickers",
    pos = { x = 1, y = 0 },
    loc_vars = function(self, info_queue, card)
		-- Sticker Credits; because stickers are ..... Strange. :)
		if card.area and card.area.config.collection and card.ability.set ~= "Joker" then
			info_queue[#info_queue + 1] = { key = "SEMBY_degrading", set = "Other", vars = {
			    card.ability.perishable_rounds or G.GAME.perishable_rounds,
			    card.ability.SEMBY_degrading_tally or G.GAME.perishable_rounds
            } }
			info_queue[#info_queue + 1] = { key = "SEMBY_degrading_playing_card", set = "Other" }
			return { key = "art_flowire", set = "Other" }
		end
		-- Actual Sticker:
		if card.playing_card or (card.ability and (card.ability.set == "Default" or card.ability.set == "Enhanced")) then
			return { key = 'SEMBY_degrading_playing_card' }
        else
		    return { vars = {
		    	card.ability.perishable_rounds or G.GAME.perishable_rounds,
		    	card.ability.SEMBY_degrading_tally or G.GAME.perishable_rounds
		    } }
        end
    end,
    should_apply = function(self, card, center, area, bypass_roll)
		return (bypass_roll or G.GAME.SEMBY_degrading or false)
    end,
    apply = function(self, card, val)
        card.ability[self.key] = val
		card.ability.SEMBY_degrading_tally = (card.ability.SEMBY_degrading_tally or G.GAME.perishable_rounds)
    end,
    calculate = function(self, card, context)
        if context.end_of_round and not context.repetition and not context.individual then
            card:SEMBY_calculate_degrading()
        end
    end
}
-- Re-Implementation...
function Card:SEMBY_calculate_degrading()
    if self.ability.SEMBY_degrading then
        if self.playing_card or self.ability.set == "Default" or self.ability.set == "Enhanced" then
            if self.area and self.area == G.hand then
                card_eval_status_text(self, 'extra', nil, nil, nil, {
		        	message = localize('SEMBY_destroyed_ex'),
		        	colour = G.C.FILTER,
		        	delay = 0.45
		        })
		        SMODS.destroy_cards(self)
            end
        else
            self.ability.SEMBY_degrading_tally = (self.ability.SEMBY_degrading_tally or G.GAME.perishable_rounds) - 1
            if self.ability.SEMBY_degrading_tally == 0 then
                card_eval_status_text(self, 'extra', nil, nil, nil, {
		    		message = localize('SEMBY_destroyed_ex'),
		    		colour = G.C.FILTER,
		    		delay = 0.45
		    	})
		    	SMODS.destroy_cards(self)
            else
                card_eval_status_text(self, 'extra', nil, nil, nil, {
		    		message = localize{type = 'variable', key = 'a_remaining', vars = {self.ability.SEMBY_degrading_tally}},
		    		colour = G.C.FILTER,
		    		delay = 0.45
		    	})
            end
        end
    end
end
