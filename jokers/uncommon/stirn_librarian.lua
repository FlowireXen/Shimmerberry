SMODS.Joker {
	key = "stirn_librarian",
	name = "SEMBY_stirn_librarian",
	atlas = "SEMBY_jokers",
	pos = { x = 8, y = 5 },
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
	rarity = 2,
	cost = 5,
	config = {
		extra = {
			mult = 25
		}
	},
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
		local debuffed = 0
		if G.jokers then
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i].debuff then
					debuffed = debuffed + 1
				end
            end
		end
		info_queue[#info_queue + 1] = { key = "debuffed_default", set = "Other" }
		return { vars = {
			card.ability.extra.mult,
			card.ability.extra.mult * debuffed,
			colours = { G.C.PERISHABLE }
		} }
	end,
    remove_from_deck = function(self, card, from_debuff)
        for i = 1, #G.jokers.cards do
			SMODS.debuff_card(G.jokers.cards[i], false, card.sort_id)
        end
    end,
    calculate = function(self, card, context)
		if context.setting_blind and not (self.getting_sliced or context.blueprint) then
			-- Select other Jokers
            local left_joker
			local right_joker
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then
					left_joker = G.jokers.cards[i - 1]
					right_joker = G.jokers.cards[i + 1]
					break
				end
            end
			-- This has to happen for it to work properly
			if right_joker then right_joker.getting_sliced = true end
			-- Return + Debuff
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				func = function()
					if left_joker then
						left_joker:juice_up()
						left_joker:flip()
					end
					if right_joker then
						right_joker:juice_up()
						right_joker:flip()
					end
					return true
				end
			}))
			delay(0.2)
            return {
				message = localize('k_debuffed'),
				colour = G.C.PERISHABLE,
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					func = function()
						if left_joker then
							SMODS.debuff_card(left_joker, true, card.sort_id)
							left_joker:flip()
						end
						if right_joker then
							SMODS.debuff_card(right_joker, true, card.sort_id)
							right_joker:flip()
							-- Reset/Undo [Threatens to murder you, just kiddin'!)
							right_joker.getting_sliced = false
						end
						return true
					end
				}))
			}
		end
		if context.joker_main then
			local debuffed = 0
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i].debuff then
					debuffed = debuffed + 1
				end
			end
			return {
				mult = card.ability.extra.mult * debuffed
			}
        end
        if context.end_of_round and context.main_eval and context.game_over == false and not context.blueprint then
            return {
                message = localize('k_reset'),
				colour = G.C.PERISHABLE,
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					func = function()
						for i = 1, #G.jokers.cards do
							--	if G.jokers.cards[i].ability.debuff_sources and G.jokers.cards[i].ability.debuff_sources[card.sort_id] then
							--  	G.jokers.cards[i]:juice_up()
							--	end
							SMODS.debuff_card(G.jokers.cards[i], false, card.sort_id)
						end
						return true
					end
				}))
            }
        end
	end
}
