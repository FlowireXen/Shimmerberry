local function get_texture(state)
	return { x = state and 4 or 3, y = 2 }
end
SMODS.Joker {
	key = "obscure_ritual",
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
			percent = 0.666,
			active = false
		}
	},
    attributes = {
		'xblindsize', 'full_deck',
		'magic'
	},
	loc_vars = function(self, info_queue, card)
		return { vars = {
			card.ability.extra.percent * 100
		} }
	end,
	set_sprites = function(self, card, front)
		if card.ability and card.ability.extra then
			card.children.center:set_sprite_pos(get_texture(card.ability.extra.active))
		end
	end,
    add_to_deck = function(self, card, from_debuff)
		if not from_debuff then
			card.children.center:set_sprite_pos(get_texture(card.ability.extra.active))
		end
    end,
	calculate = function(self, card, context)
		if not context.blueprint then
			if context.hand_drawn then
				if not card.ability.extra.active and G.deck and #G.deck.cards <= 0 then
					card.ability.extra.active = true
					G.E_MANAGER:add_event(Event({
						func = function()
							card.children.center:set_sprite_pos(get_texture(card.ability.extra.active))
							return true
						end
					}))
					SEMBY_Reduce_Blindsize(card.ability.extra.percent, nil, true)
					return {
						message = localize('SEMBY_ritual_complete'),
						colour = HEX('CC0000'),
						func = function()
							SEMBY_Blind_Check(card)
						end
					}
				end
			end
			if context.end_of_round and context.main_eval then
				if card.ability.extra.active then
					card.ability.extra.active = false
					G.E_MANAGER:add_event(Event({
						func = function()
							card.children.center:set_sprite_pos(get_texture(card.ability.extra.active))
							return true
						end
					}))
					return {
						message = localize('SEMBY_ritual_inactive'),
						colour = HEX('666666')
					}
				end
			end
		end
	end
}
