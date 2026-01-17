SMODS.Joker {
	key = "watching_forest",
	name = "SEMBY_watching_forest",
	atlas = "SEMBY_jokers",
	pos = { x = 5, y = 8 },
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = false,
	rarity = 2,
	cost = 5,
	config = {
		extra = {
			every = 2,
			remaining = 2,
			pos_valid = { base = 5 }, -- 6, 7
			pos_overwrite = { x = 5, y = 8 }
		}
	},
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
		return { vars = {
			card.ability.extra.every + 1,
			localize{
				type = 'variable',
				-- hijacking loyalty:
				key = (card.ability.extra.remaining == 0 and 'loyalty_active' or 'loyalty_inactive'),
				vars = {
					card.ability.extra.remaining
				}
			}
		} }
	end,
	load = function(self, card, card_table, other_card)
		G.E_MANAGER:add_event(Event({
			func = function()
				card.children.center:set_sprite_pos(card.ability.extra.pos_overwrite)
				return true
			end
		}))
	end,
    add_to_deck = function(self, card, from_debuff)
		if not from_debuff then
			card.children.center:set_sprite_pos(card.ability.extra.pos_overwrite)
		end
    end,
	calculate = function(self, card, context)
        if context.joker_main and not context.blueprint then
            card.ability.extra.remaining = (card.ability.extra.every - 1 - (G.GAME.hands_played - card.ability.hands_played_at_create)) % (card.ability.extra.every + 1)
			-- Texture.
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				func = function()
					card:flip()
					play_sound('card1', math.random()*0.2 + 0.85, 0.5)
					return true
				end
			}))
			-- Texture.
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.2,
				func = function()
					-- Juice!
					card:juice_up(0.2, 0.5)
					if card.ability.extra.remaining == card.ability.extra.every then
						play_sound('gong', 1.2, 0.8)
					else play_sound('tarot1', 1.0, 0.8) end
					-- Texture!
					card.ability.extra.pos_overwrite.x = card.ability.extra.pos_valid.base + card.ability.extra.every - card.ability.extra.remaining
					card.children.center:set_sprite_pos(card.ability.extra.pos_overwrite)
					return true
				end
			}))
			-- Wiggle?
			if card.ability.extra.remaining == 0 then
				-- Only start Wiggling when truly needed:
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					func = function()
						local eval = function(card)
							return card.ability.extra.remaining == 0 and not G.RESET_JIGGLES
						end
						juice_card_until(card, eval, true)
						return true
					end
				}))
			end
			-- Texture.
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.2,
				func = function()
					card:flip()
					play_sound('card1', math.random()*0.2 + 1.05, 0.5)
					return true
				end
			}))
			-- Effect!
            if card.ability.extra.remaining == card.ability.extra.every then
				return {
					func = function()
						G.deck:sort('desc')
						card_eval_status_text(G.deck, 'extra', nil, nil, nil, { message = localize('SEMBY_sorted_ex'), colour = G.C.RED })
						--> Better target would be: G.deck.cards[#G.deck.cards]
					end
				}
            end
			return nil, true
        end
	end
}
