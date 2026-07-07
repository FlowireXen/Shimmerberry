local function get_texture(state)
	if state and state ~= 0 then
		return state > 0 and { x = 7, y = 3 } or { x = 5, y = 3 }
	end
	return { x = 6, y = 3 }
end
SMODS.Joker {
	key = "scaffolding",
	SEMBY_art = "unkokat",
	atlas = "SEMBY_jokers_2",
	pos = get_texture(),
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = false,
	rarity = 2,
	cost = 5,
	config = {
		extra = {
			hand_size = 0,
			hand_max = 5,
			gain = 1,
			each = 1,
			loss = 2
		}
	},
    attributes = {
		'joker', 'scaling', 'hand_size', 'hands'
	},
	loc_vars = function(self, info_queue, card)
		local color = G.C.IMPORTANT
		if card.ability.extra.hand_size > 0 then
			color = G.C.GREEN
		elseif card.ability.extra.hand_size ~= 0 then
			color = G.C.RED
		end
		return { vars = {
			(card.ability.extra.hand_size > 0 and '+' or '')..card.ability.extra.hand_size,
			card.ability.extra.hand_max,
			card.ability.extra.gain,
			card.ability.extra.each,
			card.ability.extra.loss,
			colours = { color }
		} }
	end,
	load = function(self, card, card_table, other_card)
		G.E_MANAGER:add_event(Event({
			func = function()
				card.children.center:set_sprite_pos(get_texture(card.ability.extra.hand_size))
				return true
			end
		}))
	end,
    add_to_deck = function(self, card, from_debuff)
		if card.ability.extra.hand_size and card.ability.extra.hand_size ~= 0 then
			local change = math.min(math.abs(card.ability.extra.hand_size), card.ability.extra.hand_max)
			if card.ability.extra.hand_size < 0 then change = -change end
			G.hand:change_size(change)
			G.E_MANAGER:add_event(Event({
				func = function()
					card.children.center:set_sprite_pos(get_texture(card.ability.extra.hand_size))
					return true
				end
			}))
		end
    end,
    remove_from_deck = function(self, card, from_debuff)
		if card.ability.extra.hand_size and card.ability.extra.hand_size ~= 0 then
			local change = math.min(math.abs(card.ability.extra.hand_size), card.ability.extra.hand_max)
			if card.ability.extra.hand_size < 0 then change = -change end
			G.hand:change_size(-change)
		end
    end,
	calculate = function(self, card, context)
		if not context.blueprint then
			local calc_size = false
        	if context.selling_card and context.card.ability.set == "Joker" then
				if context.selling_self or context.card == card then return end
				calc_size = context.card.sell_cost / card.ability.extra.each * card.ability.extra.gain
			end
			if context.joker_main then
				calc_size = -card.ability.extra.loss
			end
			if calc_size then
				local hand_size = math.floor(calc_size + 0.5)
				local next_size = card.ability.extra.hand_size + hand_size
				if math.abs(next_size) > card.ability.extra.hand_max then
					next_size = next_size > 0 and card.ability.extra.hand_max or -card.ability.extra.hand_max
				end
				hand_size = next_size - card.ability.extra.hand_size
				card.ability.extra.hand_size = next_size
				if hand_size and hand_size ~= 0 then
					G.hand:change_size(hand_size)
					G.E_MANAGER:add_event(Event({
						func = function()
							card.children.center:set_sprite_pos(get_texture(card.ability.extra.hand_size))
							return true
						end
					}))
					if hand_size >= 0 then
						return {
							message = localize{type = 'variable', key = 'a_handsize', vars = { math.abs(hand_size) }},
							colour = G.C.GREEN
						}
					else
						return {
							message = localize{type = 'variable', key = 'a_handsize_minus', vars = { math.abs(hand_size) }},
							colour = G.C.RED
						}
					end
				end
			end
		end
	end
}
