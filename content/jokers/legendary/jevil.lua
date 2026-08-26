SMODS.Joker {
	key = "jevil",
	SEMBY_art = "flowire",
	atlas = "SEMBY_jokers_1",
	pos = { x = 8, y = 8 },
	soul_pos = { x = 8, y = 9 },
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = false,
	rarity = 4,
	cost = 20,
    attributes = {
		'retrigger', 'passive'
	},
    add_to_deck = function(self, card, from_debuff)
		G.GAME.SEMBY_jevil_scoring = (G.GAME.SEMBY_jevil_scoring or 1) * 2
	end,
    remove_from_deck = function(self, card, from_debuff)
		G.GAME.SEMBY_jevil_scoring = (G.GAME.SEMBY_jevil_scoring or 1) / 2
		if G.GAME.SEMBY_jevil_scoring <= 1 then
			G.GAME.SEMBY_jevil_scoring = nil
		end
    end
}

local calculate_main = SMODS.calculate_main_scoring
function SMODS.calculate_main_scoring(context, scoring_hand)
	if G.GAME.SEMBY_jevil_scoring and context and (context.cardarea == G.play or context.cardarea == "unscored") then
		for i = 1, G.GAME.SEMBY_jevil_scoring-1 do
			-- Having an unscoring card in the context, clears the entire context
			-- So I have to copy the table and evaluate that instead, why????
    		local flat_copy = {}
    		for index, value in pairs(context) do
    		    flat_copy[index] = value
    		end
			calculate_main(flat_copy, scoring_hand)
			-- Again!
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				--delay = 0.2,
				func = function()
					play_sound('generic1', 0.9 + math.random()*0.1 + (i-1)/25)
					attention_text({
						text = localize('k_again_ex'),
						backdrop_colour = G.C.IMPORTANT,
						backdrop_scale = 2.0, scale = 1.5,
						hold = 1.2, major = G.play,
						align = 'cm', offset = { x = 0, y = -0.5 }
					})
					G.play:juice_up(0.2, 0.2)
					return true
				end
			}))
			delay(0.9375)--0.8125)
		end
	end
	calculate_main(context, scoring_hand)
end
