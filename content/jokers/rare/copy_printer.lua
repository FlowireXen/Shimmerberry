SMODS.Joker {
	key = "copy_printer",
	name = "SEMBY_copy_printer",
	atlas = "SEMBY_jokers",
	pos = { x = 11, y = 4 },
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = false,
	rarity = 3,
	cost = 12,
    loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
		local alt_end
		if SMODS.is_eternal(card, 'SEMBY_copy_printer') then
			alt_end = localize('SEMBY_desc_maintained')
		else alt_end = localize('SEMBY_desc_destroyed') end
        local main_end
        if G.jokers and G.jokers.cards then
            for _, joker in ipairs(G.jokers.cards) do
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
        if context.ending_shop and not context.blueprint then
            local left_joker, right_joker
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then
					left_joker = G.jokers.cards[i - 1]
					right_joker = G.jokers.cards[i + 1]
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
						card:juice_up(0.3, 0.5)
						return true
					end
				}))
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.15,
					func = function()
						left_joker:flip()
						play_sound('card1', 1.15)
						left_joker:juice_up(0.3, 0.3)
						return true
					end
				}))
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.15,
					func = function()
						right_joker:flip()
						play_sound('card1', 1.10)
						right_joker:juice_up(0.3, 0.3)
						return true
					end
				}))
				delay(0.2)
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.15,
					func = function()
						copy_card(right_joker, left_joker, nil, nil, right_joker.edition and right_joker.edition.negative)
						return true
					end
				}))
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.15,
					func = function()
						left_joker:flip()
						play_sound('tarot2', 0.85, 0.6)
						left_joker:juice_up(0.3, 0.3)
						return true
					end
				}))
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.15,
					func = function()
						right_joker:flip()
						play_sound('tarot2', 0.80, 0.6)
						right_joker:juice_up(0.3, 0.3)
						return true
					end
				}))
				delay(0.5)
				-- Finale
				local extra = {}
				if not SMODS.is_eternal(card, 'SEMBY_copy_printer') then
					extra = {
						message = localize('SEMBY_broken_ex'),
						colour = G.C.RED,
						G.E_MANAGER:add_event(Event({
							trigger = 'after',
							func = function()
								play_sound('tarot1')
								card:shatter()
								return true
							end
						}))
					}
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
