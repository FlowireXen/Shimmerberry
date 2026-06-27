local function get_texture(state)
	if state then
		if state <= 0 then return { x = 7, y = 1 } end
		if state <= 1 then return { x = 6, y = 1 } end
	end
	return { x = 5, y = 1 }
end
SMODS.Joker {
	key = "watching_forest",
	SEMBY_art = "unkokat",
	atlas = "SEMBY_jokers_2",
	pos = get_texture(),
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = false,
	rarity = 3,
	cost = 6,
	config = {
		extra = {
			every = 2,
			remaining = 2,
			order = "desc" -- "asc"
		}
	},
    attributes = {
		'scaling', 'reset', 'full_deck',
		'nature',
	},
	loc_vars = function(self, info_queue, card)
		return { vars = {
			localize('SEMBY_sort_'..card.ability.extra.order),
			card.ability.extra.every + 1,
			localize{
				type = 'variable',
				key = (card.ability.extra.remaining == 0 and 'loyalty_active' or 'loyalty_inactive'),
				vars = { card.ability.extra.remaining }
			}
		} }
	end,
	load = function(self, card, card_table, other_card)
		G.E_MANAGER:add_event(Event({
			func = function()
				card.children.center:set_sprite_pos(get_texture(card.ability.extra.remaining))
				return true
			end
		}))
	end,
    add_to_deck = function(self, card, from_debuff)
		if not from_debuff then
			card.children.center:set_sprite_pos(get_texture(card.ability.extra.remaining))
		end
    end,
	calculate = function(self, card, context)
		if context.first_hand_drawn and G.deck then
			G.deck:sort(card.ability.extra.order)
			G.E_MANAGER:add_event(Event({
				func = function()
					card:juice_up()
					return true
				end
			}))
			return {
				message = localize('SEMBY_sorted_ex'),
				colour = G.C.RED,
				message_card = #G.deck.cards ~= 0 and G.deck.cards[1] or G.deck
			}
		end
        if context.joker_main and not context.blueprint then
            card.ability.extra.remaining = (card.ability.extra.every - 1 - (G.GAME.hands_played - card.ability.hands_played_at_create)) % math.max(1, card.ability.extra.every + 1)
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
					card:juice_up(0.2, 0.2)
					if card.ability.extra.remaining == card.ability.extra.every then
						play_sound('gong', 1.2, 0.8)
					else play_sound('tarot1', 1.0, 0.8) end
					-- Texture!
					card.children.center:set_sprite_pos(get_texture(card.ability.extra.remaining))
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
				card.ability.extra.order = card.ability.extra.order == 'desc' and 'asc' or 'desc'
				return {
					message = localize('SEMBY_switch_ex'),
					colour = G.C.RED
				}
            end
			return nil, true
        end
	end
}
