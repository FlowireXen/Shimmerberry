SMODS.Joker {
	key = "boosterpack_joker",
	name = "SEMBY_boosterpack_joker",
	atlas = "SEMBY_jokers",
	pos = { x = 0, y = 3 },
    draw = function(self, card, layer)
        if card.config.center.discovered or card.bypass_discovery_center then
            card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
        end
    end,
    unlocked = true,
    discovered = false,
    eternal_compat = false,
    perishable_compat = false,
    blueprint_compat = false,
	rarity = 1,
	cost = 5,
	config = {
		SEMBY_degrading = true,
		extra = {
			slots = 3
		}
	},
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
		return { vars = {
			card.ability.extra.slots
		} }
	end,
    add_to_deck = function(self, card, from_debuff)
        SMODS.change_booster_limit(card.ability.extra.slots)
    end,
    remove_from_deck = function(self, card, from_debuff)
        SMODS.change_booster_limit(-card.ability.extra.slots)
    end,
	calculate = function(self, card, context)
		if context.starting_shop and not context.blueprint then
			-- Purely Cosmetic
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				blocking = false,
				func = function()
					card:juice_up(0.3, 0.0)
					play_sound('generic1', 1.0, 0.8)
					attention_text({
						text = localize{ type = 'variable', key = 'SEMBY_plus', vars = { card.ability.extra.slots } },
						backdrop_colour = G.C.IMPORTANT,
						scale = 0.8,
						hold = 1.0,
						major = card,
						align = 'bm',
						offset = { x = 0, y = 0 }
					})
					return true
				end
			}))
			return nil, false
		end
	end
}
