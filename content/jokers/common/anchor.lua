SMODS.Joker {
	key = "anchor",
	SEMBY_art = "unkokat",
    atlas = 'SEMBY_jokers_1',
    pos = { x = 9, y = 1 },
    eternal_compat = true,
    perishable_compat = false,
    blueprint_compat = true,
	rarity = 1,
	cost = 4,
	config = {
		extra = {
			xchips = 2.0,
			selectable = true
		}
	},
    attributes = {
		'xchips',
		'ocean',
	},
	loc_vars = function(self, info_queue, card)
		return { vars = {
			card.ability.extra.xchips
		} }
	end,
	load = function(self, card, card_table, other_card)
		card.states.click.can = false
		G.E_MANAGER:add_event(Event({
			func = function()
				card.states.click.can = card.ability.extra.selectable
				return true
			end
		}))
	end,
    add_to_deck = function(self, card, from_debuff)
		if from_debuff then card.ability.extra.selectable = false
		else card.ability.extra.selectable = card.debuff end
		card.states.click.can = card.ability.extra.selectable
	end,
    remove_from_deck = function(self, card, from_debuff)
		card.ability.extra.selectable = true
		card.states.click.can = card.ability.extra.selectable
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return { xchips = card.ability.extra.xchips }
		end
	end
}
