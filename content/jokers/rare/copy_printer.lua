SMODS.Joker {
	key = "copy_printer",
	SEMBY_art = "unkokat",
	atlas = "SEMBY_jokers_1",
	pos = { x = 6, y = 1 },
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = false,
	rarity = 3,
	cost = 12,
    attributes = {
		'generation', 'destroy_card'
	},
    loc_vars = function(self, info_queue, card)
		local alt_end
		if SMODS.is_eternal(card, 'SEMBY_copy_printer') then
			alt_end = localize('SEMBY_desc_maintained')
		else alt_end = localize('SEMBY_desc_destroyed') end
        local main_end
        if card.area and card.area.cards then
            for _, joker in ipairs(card.area.cards) do
                if joker.edition and joker.edition.negative then
                    main_end = {}
                    localize { type = 'other', key = 'remove_negative', nodes = main_end, vars = {} }
                    break
                end
            end
        end
        return {
			vars = { alt_end },
			main_end = main_end and main_end[1]
		}
    end,
	calculate = function(self, card, context)
        if context.ending_shop and not context.blueprint and card.area then
            local left_joker, right_joker
            for i = 1, #card.area.cards do
                if card.area.cards[i] == card then
					left_joker = card.area.cards[i - 1]
					right_joker = card.area.cards[i + 1]
					break
				end
            end
			if left_joker and right_joker then
				-- Convert Stuff
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.4,
					func = function()
						play_sound('tarot1')
						card:juice_up(0.3)
						return true
					end
				}))
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.15,
					func = function()
						left_joker:flip()
						play_sound('card1', 1.15)
						left_joker:juice_up(0.3)
						return true
					end
				}))
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.15,
					func = function()
						right_joker:flip()
						play_sound('card1', 1.10)
						right_joker:juice_up(0.3)
						return true
					end
				}))
				delay(0.2)
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.15,
					func = function()
						if left_joker.ability.SEMBY_shimmer_immune then
							left_joker:juice_up(0.2, 0.2)
							play_sound('gong', 2.0, 0.7)
							attention_text({
								text = localize('SEMBY_immune_ex'),
								backdrop_colour = G.C.RED,
								scale = 1.0, hold = 0.8,
								major = left_joker,
								align = 'cm', offset = { x = 0, y = 0 }
							})
						else
							copy_card(right_joker, left_joker, nil, nil, right_joker.edition and right_joker.edition.negative)
						end
						return true
					end
				}))
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.15,
					func = function()
						left_joker:flip()
						play_sound('tarot2', 0.85, 0.6)
						left_joker:juice_up(0.3)
						return true
					end
				}))
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.15,
					func = function()
						right_joker:flip()
						play_sound('tarot2', 0.80, 0.6)
						right_joker:juice_up(0.3)
						return true
					end
				}))
				delay(0.5)
				-- Finale
				local extra = {}
				if not SMODS.is_eternal(card, 'SEMBY_copy_printer') then
					if left_joker.ability.SEMBY_shimmer_immune then
						extra = {
							message = localize('k_saved_ex'),
							colour = G.C.GREEN
						}
					else
						extra = {
							message = localize('SEMBY_broken_ex'),
							colour = G.C.RED,
							G.E_MANAGER:add_event(Event({
								trigger = 'after',
								func = function()
									play_sound('tarot1')
									card.shattered = true
                        			SMODS.destroy_cards(card, nil, true)
									return true
								end
							}))
						}
					end
				end
				return {
					message = localize('SEMBY_printed_ex'),
					colour = G.C.WHITE,
					extra = extra
				}
			end
		end
	end
}
