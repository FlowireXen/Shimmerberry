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
			handsize = 1,
			penalty = 3,
			current = 0
		}
	},
    attributes = {
		'joker', 'scaling', 'hand_size', 'hands'
	},
	loc_vars = function(self, info_queue, card)
		local color = G.C.IMPORTANT
		if card.ability.extra.current > 0 then
			color = G.C.GREEN
		elseif card.ability.extra.current ~= 0 then
			color = G.C.RED
		end
		return { vars = {
			card.ability.extra.handsize,
			card.ability.extra.penalty,
			(card.ability.extra.current >= 0 and '+' or '')..card.ability.extra.current,
			colours = { color }
		} }
	end,
	load = function(self, card, card_table, other_card)
		G.E_MANAGER:add_event(Event({
			func = function()
				card.children.center:set_sprite_pos(get_texture(card.ability.extra.current))
				return true
			end
		}))
	end,
    add_to_deck = function(self, card, from_debuff)
		G.hand:change_size(card.ability.extra.current)
		G.E_MANAGER:add_event(Event({
			func = function()
				-- Handle Mismatch (from minus to plus):
				if G.hand.config.true_card_limit ~= G.hand.config.card_limit and G.hand.config.card_limit >= 0 then
					G.hand.config.true_card_limit = G.hand.config.card_limit
				end
				return true
			end
		}))
		if not from_debuff then
			card.children.center:set_sprite_pos(get_texture(card.ability.extra.current))
		end
    end,
    remove_from_deck = function(self, card, from_debuff)
		G.hand:change_size(-card.ability.extra.current)
		G.E_MANAGER:add_event(Event({
			func = function()
				-- Handle Mismatch (from minus to plus):
				if G.hand.config.true_card_limit ~= G.hand.config.card_limit and G.hand.config.card_limit >= 0 then
					G.hand.config.true_card_limit = G.hand.config.card_limit
				end
				return true
			end
		}))
    end,
	calculate = function(self, card, context)
		if not context.blueprint then
			if context.setting_blind and not self.getting_sliced then
				local adding = (#G.jokers.cards - 1) * card.ability.extra.handsize
				card.ability.extra.current = (card.ability.extra.current or 0) + adding
				G.hand:change_size(adding)
				return {
					message = localize{type = 'variable', key = 'a_handsize', vars = { adding }},
					colour = G.C.GREEN,
					G.E_MANAGER:add_event(Event({
						func = function()
							-- Handle Mismatch (from minus to plus):
							if G.hand.config.true_card_limit ~= G.hand.config.card_limit and G.hand.config.card_limit >= 0 then
								G.hand.config.true_card_limit = G.hand.config.card_limit
							end
							-- Texture
							card.children.center:set_sprite_pos(get_texture(card.ability.extra.current))
							return true
						end
					}))
				}
			end
			if context.joker_main then
				card.ability.extra.current = (card.ability.extra.current or 0) - card.ability.extra.penalty
				G.hand:change_size(-card.ability.extra.penalty)
				return {
					message = localize{type = 'variable', key = 'a_handsize_minus', vars = { card.ability.extra.penalty }},
					colour = G.C.RED,
					G.E_MANAGER:add_event(Event({
						func = function()
							-- Handle Mismatch (from minus to plus):
							if G.hand.config.true_card_limit ~= G.hand.config.card_limit and G.hand.config.card_limit >= 0 then
								G.hand.config.true_card_limit = G.hand.config.card_limit
							end
							-- Texture
							card.children.center:set_sprite_pos(get_texture(card.ability.extra.current))
							return true
						end
					}))
				}
			end
		end
	end
}
