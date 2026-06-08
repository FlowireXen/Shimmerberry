SMODS.Joker {
	key = "agent_fourty_seven",
	SEMBY_art = "unkokat",
	atlas = "SEMBY_jokers_1",
	pos = { x = 4, y = 4 },
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = false,
	rarity = 2,
	cost = 6,
	config = {
		extra = {
			discard_limit = 3
		}
	},
    attributes = {
		'destroy_card', 'discard'
	},
	loc_vars = function(self, info_queue, card)
		return { vars = {
			card.ability.extra.discard_limit
		} }
	end,
	calculate = function(self, card, context)
		if context.pre_discard and not (context.blueprint) and #context.full_hand == card.ability.extra.discard_limit then
			-- Find Target (Duplicate Safe Code)
			local target_location = pseudorandom('SEMBY_agent_fourty_seven', 1, card.ability.extra.discard_limit)
			for i = 1, card.ability.extra.discard_limit do
				if context.full_hand[target_location].ability.SEMBY_hitman then
					target_location = target_location + 1
					if target_location > card.ability.extra.discard_limit then
						target_location = 1
					end
				else
					context.full_hand[target_location].ability.SEMBY_hitman = card.sort_id
					break
				end
			end
			return nil, true
		end
        if context.discard and not (context.blueprint) and #context.full_hand == card.ability.extra.discard_limit
		and context.other_card.ability.SEMBY_hitman and context.other_card.ability.SEMBY_hitman == card.sort_id then
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				func = function()
					attention_text({
						text = localize('SEMBY_target'),
						scale = 0.8,
						hold = 1.0,
						major = context.other_card,
						colour = G.C.RED,
						align = 'cm',
						offset = { x = 0, y = 0 }
					})
					return true
				end
			}))
			delay(0.5)
			context.other_card.ability.SEMBY_hitman = nil
			context.other_card.SEMBY_removed = true --> Only works due to a Lovely-Patch: "/lovely/fix_discard.toml"
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				func = function()
					SMODS.destroy_cards(context.other_card, nil, true, false)
					return true
				end
			}))
			return {
				message = localize('SEMBY_acquired_ex'),
				colour = G.C.RED
			}
        end
	end
}
