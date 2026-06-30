SMODS.Joker {
	key = "arcoex",
	SEMBY_art = "placeholder",
	atlas = "SEMBY_jokers_1",
	pos = { x = 8, y = 7 },
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
	rarity = 3,
	cost = 7,
	config = {
		extra = {
			min = 1,
			max = 5
		}
	},
    attributes = {
		'passive'
	},
	loc_vars = function(self, info_queue, card)
		return { vars = {
			card.ability.extra.min,
			card.ability.extra.max
		} }
	end,
	calculate = function(self, card, context)
		if context.press_play and G.deck then
			if not G.GAME.SEMBY_acexc_mod then G.GAME.SEMBY_acexc_mod = 0 end
			-- Keeps '1' Card in Deck for various Joker-Effects
			if #G.deck.cards - G.GAME.SEMBY_acexc_mod > 1 then
				-- Get "Draw"
				local ace_draw = math.floor(pseudorandom("SEMBY_acexc", card.ability.extra.min, card.ability.extra.max))
				if #G.deck.cards - G.GAME.SEMBY_acexc_mod - ace_draw <= 1 then
					local correction = (#G.deck.cards - G.GAME.SEMBY_acexc_mod - ace_draw) * -1 + 1
					ace_draw = math.max(0, ace_draw - correction)
				end
				if ace_draw ~= 0 then
					-- Response
					local juice_card = (context.blueprint_card or card)
					G.E_MANAGER:add_event(Event({
						trigger = 'after',
						delay = 0.2,
						func = function()
							juice_card:juice_up()
							play_sound('generic1')
							attention_text({
								text = localize{ type = 'variable', key = 'SEMBY_plus', vars = { ace_draw } },
								backdrop_colour = G.C.GREEN,
								scale = 0.8, hold = 0.8, major = juice_card, align = 'bm',
								offset = { x = 0, y = 0 }
							})
							return true
						end
					}))
					-- "Draw"
					for i = G.GAME.SEMBY_acexc_mod, G.GAME.SEMBY_acexc_mod + ace_draw - 1 do
						--draw_card(G.deck, G.play, i*100/(#G.play.cards+1), 'up', nil, G.deck.cards[i])
						draw_card(G.deck, G.play, i*100/(#G.play.cards+1), 'up', nil, G.deck.cards[#G.deck.cards-i])
        				G.E_MANAGER:add_event(Event({
        				    func = function()
								juice_card:juice_up(0.1, 0.2)
        				        return true
        				    end
        				}))
					end
					-- Buffer
					G.GAME.SEMBY_acexc_mod = G.GAME.SEMBY_acexc_mod + ace_draw
				end
			end
		end
    	if context.before and G.GAME.SEMBY_acexc_mod then
			G.GAME.SEMBY_acexc_mod = nil
		end
	end
}
