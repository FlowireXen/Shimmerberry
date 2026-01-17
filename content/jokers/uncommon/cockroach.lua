SMODS.Joker {
	key = "cockroach", --> The Roach that Kills you
	name = "SEMBY_cockroach",
	atlas = "SEMBY_jokers",
	pos = { x = 2, y = 5 },
    unlocked = true,
    discovered = false,
    eternal_compat = false,
    perishable_compat = false,
    blueprint_compat = true,
	rarity = 2,
	cost = 6,
	config = {
		SEMBY_possessive = true,
		extra = {
			ante_mod = 1.0,
			check_win = true
		}
	},
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
		return { vars = {
			card.ability.extra.ante_mod
		} }
	end,
    add_to_deck = function(self, card, from_debuff)
		if not from_debuff then
			-- Important if something else skipped the Win-Ante,
			-- so this Joker doesn't suddenly give you the Win.
			if G.GAME.round_resets.ante > G.GAME.win_ante then
				card.ability.extra.check_win = false
			end
		end
    end,
	calculate = function(self, card, context)
		if context.modify_ante and context.ante_end and context.cardarea == G.jokers then
			-- Quick-Message
			local juice_card = (context.blueprint_card or card)
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				blocking = false,
				func = function()
					juice_card:juice_up(0.1, (math.random() < 0.5) and 0.2 or -0.2)
					play_sound('generic1', 1.2, 0.5)
					attention_text({
						text = localize('SEMBY_eval_cockroach'),
						backdrop_colour = HEX('BE3740'),
						scale = 0.8, hold = 0.5,
						major = juice_card, align = 'bm',
						offset = { x = 0, y = 0 }
					})
					return true
				end
			}))
			return {
				--message = localize('SEMBY_eval_cockroach'),
				--colour = HEX('BE3740'),
				modify = context.modify_ante + math.floor(card.ability.extra.ante_mod)
			}
		end
		if context.ante_change and context.ante_end and card.ability.extra.check_win and context.cardarea == G.jokers then
			-- Win when skipping the Win-Ante
			if (G.GAME.round_resets.ante + context.ante_change) > G.GAME.win_ante then
				card.ability.extra.check_win = false
				if not G.GAME.won then
					-- Delay TWICE to end up in the right context after a reload
					G.E_MANAGER:add_event(Event({
						func = function()
							G.E_MANAGER:add_event(Event({
								func = function()
									win_game()
									return true
								end
							}))
							return true
						end
					}))
					G.GAME.won = true
				end
			end
		end
	end
}
