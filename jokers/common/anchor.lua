SMODS.Joker {
	key = "anchor",
	name = "SEMBY_anchor",
    atlas = 'SEMBY_jokers',
    pos = { x = 8, y = 3 },
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = false,
    blueprint_compat = true,
	rarity = 1,
	cost = 4,
	config = {
		extra = {
			xchips = 2.0,
			selectable = false
		}
	},
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
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
		--[MINOR][Won't Fix]: Copies of a Debuffed "Anchor" can always be Highlighted, even after the Debuff runs out.
		if from_debuff then card.ability.extra.selectable = false end
		card.states.click.can = card.ability.extra.selectable
	end,
    remove_from_deck = function(self, card, from_debuff)
		if from_debuff then card.ability.extra.selectable = true end
		card.states.click.can = card.ability.extra.selectable
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return { xchips = card.ability.extra.xchips }
		end
	end
}
