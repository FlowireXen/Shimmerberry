local STATES = 6
local function get_texture(state)
	if state then
		if state == 0 or state == 5 then return { x = 5, y = 1 } end
		if state == 1 or state == 4 then return { x = 6, y = 1 } end
		if state == 2 or state == 3 then return { x = 7, y = 1 } end
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
			mistakes = 0
		}
	},
    attributes = {
		'full_deck',
		'nature',
	},
	load = function(self, card, card_table, other_card)
		G.E_MANAGER:add_event(Event({
			func = function()
				card.children.center:set_sprite_pos(get_texture(math.floor(card.ability.extra.mistakes % STATES)))
				return true
			end
		}))
	end,
    add_to_deck = function(self, card, from_debuff)
		if not from_debuff then
			card.ability.extra.mistakes = 0
			card.children.center:set_sprite_pos(get_texture(math.floor(card.ability.extra.mistakes % STATES)))
		end
    end,
	calculate = function(self, card, context)
		if not context.blueprint and G.deck then
			if context.first_hand_drawn then
				-- Sort
				G.deck:sort("desc") -- "asc"
				-- Announce
				G.E_MANAGER:add_event(Event({
					func = function()
						card:juice_up()
						return true
					end
				}))
				return {
					message = localize('SEMBY_sorted_ex'),
					colour = G.C.DARK_EDITION,
					message_card = #G.deck.cards ~= 0 and G.deck.cards[1] or G.deck
				}
			end
			if context.pre_discard and not context.hook then
				-- Shuffle
				card.ability.extra.mistakes = math.floor(card.ability.extra.mistakes + 1)
				G.deck:shuffle('watching_forest'..(G.GAME.round_resets.ante + card.ability.extra.mistakes))
				-- Announce
				G.E_MANAGER:add_event(Event({
					func = function()
						card:juice_up()
						-- Texture
						local state = math.floor(card.ability.extra.mistakes % STATES)
						if not (state == 0 or state == 3) then
							G.E_MANAGER:add_event(Event({
								trigger = 'after',
								delay = 0.2,
								func = function()
									card:flip()
									play_sound('card1', math.random()*0.2 + 0.85, 0.5)
									return true
								end
							}), 'other')
							G.E_MANAGER:add_event(Event({
								trigger = 'after',
								delay = 0.2,
								func = function()
									card.children.center:set_sprite_pos(get_texture(state))
									return true
								end
							}), 'other')
							G.E_MANAGER:add_event(Event({
								trigger = 'after',
								delay = 0.2,
								func = function()
									card:flip()
									play_sound('card1', math.random()*0.2 + 1.05, 0.5)
									return true
								end
							}), 'other')
						end
						return true
					end
				}))
				return {
					message = localize('SEMBY_shuffled_ex'),
					colour = G.C.RED,
					message_card = #G.deck.cards ~= 0 and G.deck.cards[1] or G.deck
				}
			end
		end
	end
}
