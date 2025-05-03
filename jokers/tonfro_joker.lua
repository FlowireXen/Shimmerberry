SMODS.Joker {
	key = "tonfro_joker",
	loc_txt = {
		name = "To n' Fro",
		text = {
			"Played cards swap",
			"{C:chips}Chips{} and {C:mult}Mult{} when scored",
			"Earn {C:gold}$#1#{} every {C:attention}#2#{} swaps",
			"{C:inactive}(#3# Left){}"
		}
	},
	cost = 5,
	rarity = 1,
	blueprint_compat = true,
	atlas = "SEMBY_jokers",
	pos = { x = 8, y = 0 },
    config = { extra = { gold = 1, swaps = 11, swap_count = 11 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.gold, card.ability.extra.swaps, card.ability.extra.swap_count } }
	end,
	calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
			-- Actual Swapping Code
            local currMult = mult
			mult = hand_chips
			hand_chips = currMult
			-- Visual Feedback
        	G.E_MANAGER:add_event(Event({
				trigger = 'before',
				delay = 0.1,
				func = function()
					-- JUICE
					G.hand_text_area.blind_chips:juice_up()
					G.hand_text_area.game_chips:juice_up()
					-- Change Card Texture
					if not context.blueprint then
						if card.config.center.pos.y > 0 then
							card.config.center.pos.y = 0
						else
							card.config.center.pos.y = 1
						end
					end
					card:juice_up()
					play_sound('tarot1')
					return true
				end
			}))
            update_hand_text({ delay = 0 }, { chips = hand_chips, mult = mult })
			-- Additional Money Code
			card.ability.extra.swap_count = card.ability.extra.swap_count - 1
			if card.ability.extra.swap_count and card.ability.extra.swap_count <= 0 then
				card.ability.extra.swap_count = card.ability.extra.swaps
				ease_dollars(card.ability.extra.gold)
                --return { dollars = card.ability.extra.gold, card = card }
			end
			-- Finally, GTFO (the game)!
			return
        end
    end
}
