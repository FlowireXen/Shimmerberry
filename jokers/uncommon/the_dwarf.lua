SMODS.Joker {
	key = "the_dwarf",
	name = "SEMBY_the_dwarf",
	atlas = "SEMBY_jokers",
	pos = { x = 11, y = 6 },
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
	rarity = 2,
	cost = 6,
	config = {
		extra = {
			handsize = 5
		}
	},
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
		return { vars = {
			card.ability.extra.handsize
		} }
	end,
	calculate = function(self, card, context)
		if context.setting_blind and not (context.blueprint_card or self).getting_sliced then
			-- Has it's own Event for better Timing and also less
			-- Conflicts with the normal Hand-Size-Change Method.
			local juice_card = (context.blueprint_card or card)
			G.E_MANAGER:add_event(Event({
				func = function()
					local discards = (G.hand.config.card_limit or G.hand.config.real_card_limit) - math.floor(card.ability.extra.handsize)
					-- Only Change if needed:
					if discards ~= 0 then
						-- Figure Out Change (for Temp)
						G.GAME.round_resets.temp_handsize = (G.GAME.round_resets.temp_handsize or 0) - discards
						-- *Set* Handsize
						G.hand.config.real_card_limit = math.floor(card.ability.extra.handsize)
						G.hand.config.card_limit = G.hand.config.real_card_limit
					else
						-- Makes Multiple Copies a lil' more Exciting;
						discards = -(G.GAME.round_resets.temp_handsize or -0)
						--> The moment I realised: You *can* have "-0" in lua!
					end
					-- Add Discards ("Instantly"):
					ease_discard(discards, true)
					-- Replace Return (since I don't have the Ret-Value Otherwise)
					juice_card:juice_up(0.3, 0.0)
					play_sound('generic1', 1.0, 0.8)
					attention_text({
						text = (discards >= 0 and '+'..discards or discards)..' '..localize('SEMBY_smoll'),
						backdrop_colour = discards > 0 and G.C.GREEN or G.C.RED,
						scale = 0.8, hold = 0.8,
						major = juice_card, align = 'bm',
						offset = { x = 0, y = 0 }
					})
					return true
				end
			}))
			delay(0.9)
			return nil, true
        end
	end
}
