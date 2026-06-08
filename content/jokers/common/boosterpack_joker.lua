SMODS.Joker {
	key = "boosterpack_joker",
	SEMBY_art = "flowire",
	atlas = "SEMBY_jokers_1",
	pos = { x = 9, y = 6 },
    draw = function(self, card, layer)
        if card.config.center.discovered or card.bypass_discovery_center then
            card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
        end
    end,
    eternal_compat = false,
    perishable_compat = true,
    blueprint_compat = false,
	rarity = 1,
	cost = 5,
	config = {
		extra = {
			-- Durability
			durability = 3,
			durability_max = 3,
			-- Joker
			slots = 3
		}
	},
    attributes = {
		'passive',
		'shop'
	},
	pools = {
        ["Repairable"] = true,
    },
	loc_vars = function(self, info_queue, card)
		return { vars = {
			card.ability.extra.slots,
			card:SEMBY_durability_amount(),
			colours = { card:SEMBY_durability_color() }
		} }
	end,
    add_to_deck = function(self, card, from_debuff)
        SMODS.change_booster_limit(card.ability.extra.slots)
    end,
    remove_from_deck = function(self, card, from_debuff)
        SMODS.change_booster_limit(-card.ability.extra.slots)
    end,
	calculate = function(self, card, context)
		if (context.starting_shop or context.buying_self) and not context.blueprint then
			return {
                message = localize{ type = 'variable', key = 'SEMBY_plus', vars = { card.ability.extra.slots } },
                colour = G.C.IMPORTANT,
				func = function()
                    card:SEMBY_durability_use()
		    	    card:SEMBY_durability_check()
					return true
				end
			}
		end
	end
}
