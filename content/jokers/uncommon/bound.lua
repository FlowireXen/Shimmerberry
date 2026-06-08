SMODS.Joker{
	key = "bound",
	SEMBY_art = "flowire",
    atlas = 'SEMBY_jokers_1',
    pos = { x = 2, y = 4 },
    eternal_compat = true,
    perishable_compat = false,
    blueprint_compat = false,
    rarity = 2,
    cost = 8,
	config = {
		card_limit = 3
	},
    attributes = {
		'destroy_card', 'joker', 'joker_slot',
		'debuff_card'
	},
	loc_vars = function(self, info_queue, card)
        return { vars = {
			card.ability.card_limit
		} }
    end,
	calculate = function(self, card, context)
		if context.setting_blind and not (self.getting_sliced or context.blueprint) then
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				func = function()
					card:juice_up(0.2)
					play_sound('tarot1')
					if #G.jokers.cards > 0 then
						local local_jokers = G.jokers.cards
						for index, joker in pairs(local_jokers) do
							if not (joker.debuff or joker.getting_sliced) then
								joker:set_debuff(true)
								if not SMODS.is_eternal(joker, card) then
									joker.getting_sliced = true
									joker:start_dissolve()
								end
            					joker:juice_up()
								attention_text({
									text = localize('SEMBY_bound_ex'),
									backdrop_colour = G.C.RED, hold = 0.8,
									major = joker, align = 'bm'
								})
								break
							end
						end
					end
					return true
				end
			}))
			delay(1.0)
			return
        end
	end
}
