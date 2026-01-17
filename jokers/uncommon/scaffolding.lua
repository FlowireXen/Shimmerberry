SMODS.Joker {
	key = "scaffolding",
	name = "SEMBY_scaffolding",
	atlas = "SEMBY_jokers",
	pos = { x = 6, y = 9 },
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = false,
	rarity = 2,
	cost = 5,
	config = {
		extra = {
			handsize = 1,
			penalty = 3,
			current = 0,
			texture = {
				overwrite = { x = 6, y = 9 },
				-- States
				positive = { x = 7, y = 9 },
				neutral =  { x = 6, y = 9 },
				negative = { x = 5, y = 9 }
			}
		}
	},
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
		local color = G.C.IMPORTANT
		if card.ability.extra.current then
			if card.ability.extra.current > 0 then
				color = G.C.GREEN
			elseif card.ability.extra.current ~= 0 then
				color = G.C.RED
			end
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
				card.children.center:set_sprite_pos(card.ability.extra.texture.overwrite)
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
			card.children.center:set_sprite_pos(card.ability.extra.texture.overwrite)
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
							if card.ability.extra.current > 0 then
								card.ability.extra.texture.overwrite = card.ability.extra.texture.positive
							elseif card.ability.extra.current == 0 then
								card.ability.extra.texture.overwrite = card.ability.extra.texture.neutral
							else card.ability.extra.texture.overwrite = card.ability.extra.texture.negative end
							card.children.center:set_sprite_pos(card.ability.extra.texture.overwrite)
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
							if card.ability.extra.current > 0 then
								card.ability.extra.texture.overwrite = card.ability.extra.texture.positive
							elseif card.ability.extra.current == 0 then
								card.ability.extra.texture.overwrite = card.ability.extra.texture.neutral
							else card.ability.extra.texture.overwrite = card.ability.extra.texture.negative end
							card.children.center:set_sprite_pos(card.ability.extra.texture.overwrite)
							return true
						end
					}))
				}
			end
		end
	end
}
