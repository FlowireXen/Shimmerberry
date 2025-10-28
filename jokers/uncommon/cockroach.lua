--## KNOWN BUG: Blueprint and Multiple Copies don't work:
-- > Bugreport: https://github.com/Steamodded/smods/issues/976
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
			card.ability.extra.ante_mod,
			colours = { HEX('BE3740') }
		} }
	end,
    add_to_deck = function(self, card, from_debuff)
		if not from_debuff then
			-- Important if another Effect skipped the Winning Ante,
			-- so this Jokers doesn't suddenly give you the Win.
			if G.GAME.round_resets.ante > G.GAME.win_ante then
				card.ability.extra.check_win = false
			end
		end
    end,
	calculate = function(self, card, context)
		if context.modify_ante and context.ante_end and context.cardarea == G.jokers then
			return {
				message = localize('SEMBY_eval_cockroach'),
				colour = HEX('BE3740'),
				modify = math.floor(card.ability.extra.ante_mod)
			}
		end
		if context.ante_change and context.ante_end and card.ability.extra.check_win and context.cardarea == G.jokers then
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
