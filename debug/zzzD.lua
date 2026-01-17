SMODS.Joker {
	key = "debugjoker",
	name = "SEMBY_debugjoker",
	loc_txt = {
		name = "DEBUG{C:attention}JOKER",
		text = {
			"{B:1,C:white}X0.0{} Chips and Mult",
			"Regain {C:blue}Hands{} played",
			"Regain {C:red}Discards{} used",
			"{C:green}Rerolls{} are free",
		}
	},
	loc_vars = function(self, info_queue, card) return {vars={colours={HEX('000000')}}} end,
	atlas = "SEMBY_jokers", pos = { x = 0, y = 0 }, rarity = 1, cost = 1242,
	unlocked = true, discovered = true, blueprint_compat = true,
    in_pool = function(self, args) return false end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				message = 'X0.0',
				colour = HEX('000000'),
				xmult = 0.0, xchips = 0.0
			}
		end
		if context.after and context.cardarea == G.jokers then
			ease_hands_played(1)
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				blocking = false,
				func = function()
					(context.blueprint_card or card):juice_up(0.1, (math.random() < 0.5) and 0.2 or -0.2)
					attention_text({
						text = 'Hand', backdrop_colour = G.C.BLUE, scale = 0.8, hold = 1.0,
						major = (context.blueprint_card or card), align = 'bm', offset = { x = 0, y = 0 }
					})
					return true
				end
			}))
			return nil, true
		end
		if context.discard and context.other_card == context.full_hand[#context.full_hand] then
			ease_discard(1)
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				blocking = false,
				func = function()
					(context.blueprint_card or card):juice_up(0.1, (math.random() < 0.5) and 0.2 or -0.2)
					attention_text({
						text = 'Discard', backdrop_colour = G.C.RED, scale = 0.8, hold = 1.0,
						major = (context.blueprint_card or card), align = 'bm', offset = { x = 0, y = 0 }
					})
					return true
				end
			}))
			return nil, true
		end
		if context.starting_shop or context.reroll_shop then
			SMODS.change_free_rerolls(2)
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				blocking = false,
				func = function()
					(context.blueprint_card or card):juice_up(0.1, (math.random() < 0.5) and 0.2 or -0.2)
					play_sound('generic1', 1.2, 0.5)
					attention_text({
						text = 'Reroll', backdrop_colour = G.C.GREEN, scale = 0.8, hold = 1.0,
						major = (context.blueprint_card or card), align = 'bm', offset = { x = 0, y = 0 }
					})
					return true
				end
			}))
			return nil, true
		end
    end
}
