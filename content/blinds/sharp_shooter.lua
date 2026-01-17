SMODS.Blind {
    key = "sharp_shooter",
	name = "SEMBY_sharp_shooter",
    atlas = "SEMBY_blinds",
    pos = { x = 0, y = 2},
    dollars = 8,
    mult = 2,
    boss = {
		showdown = true
	},
    boss_colour = HEX("FFD61D"),
    --loc_vars = function(self) SEMBY_Queue_Artist(self, info_queue) end,
    calculate = function(self, blind, context)
		-- Just in case someone fixes the Metador-Triggers:
        if context.press_play and not blind.disabled then
			blind.prepped = true
            blind.triggered = true
        end
    end,
	drawn_to_hand = function(self)
		-- I could also use "recalc_debuff()".. But this works:
		if G.GAME.blind.prepped then
			G.GAME.blind.prepped = false
			local conf_amount = 5
			local temp_hand = {}
			for _, playing_card in ipairs(G.hand.cards) do
				playing_card.ability.SEMBY_sharp_shot = nil
				SMODS.debuff_card(playing_card, false, "SEMBY_sharp_shooter")
				if not playing_card.debuff then
					temp_hand[#temp_hand + 1] = playing_card
				end
			end
			G.GAME.blind:wiggle()
			if #temp_hand > conf_amount then
				pseudoshuffle(temp_hand, "SEMBY_sharp_shooter")
			end
			for i = 1, math.min(#temp_hand, conf_amount) do
				temp_hand[i].ability.SEMBY_sharp_shot = true
				SMODS.debuff_card(temp_hand[i], true, "SEMBY_sharp_shooter")
				temp_hand[i]:juice_up()
			end
		end
	end,
    disable = function(self)
        for _, playing_card in ipairs(G.playing_cards) do
            playing_card.ability.SEMBY_sharp_shot = nil
			SMODS.debuff_card(playing_card, false, "SEMBY_sharp_shooter")
        end
    end,
    defeat = function(self)
        for _, playing_card in ipairs(G.playing_cards) do
            playing_card.ability.SEMBY_sharp_shot = nil
			SMODS.debuff_card(playing_card, false, "SEMBY_sharp_shooter")
        end
    end
}
