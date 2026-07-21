SMODS.Joker {
	key = "replicator",
	SEMBY_art = "unkokat",
	atlas = "SEMBY_jokers_1",
	pos = { x = 3, y = 8 },
    eternal_compat = false,
    perishable_compat = true,
    blueprint_compat = false,
	rarity = 3,
	cost = 6,
	config = {
		extra = {
			max_amount = 10,
			amount = 0
		}
	},
    attributes = {
		'generation', 'destroy_card'
	},
	loc_vars = function(self, info_queue, card)
        local main_end = {}
        if G.jokers and G.jokers.cards then
            for _, joker in ipairs(G.jokers.cards) do
                if joker.edition and joker.edition.negative then
                    localize { type = 'other', key = 'SEMBY_keep_info', nodes = main_end, vars = {} }
                    break
                end
            end
        end
		return { vars = {
			card.ability.extra.max_amount,
			card.ability.extra.amount
		}, main_end = main_end[1] }
	end,
	add_to_deck = function(self, card, from_debuff)
		if not from_debuff and card.ability.extra.amount >= card.ability.extra.max_amount then
			card.ability.extra.amount = 0
		end
	end,
	calculate = function(self, card, context)
		if not context.blueprint_card then
			-- Destroy
			if context.individual and (context.cardarea == G.play or context.cardarea == "unscored")
			and card.ability.extra.amount < card.ability.extra.max_amount then
				context.other_card.ability.SEMBY_replicated = true
				card.ability.extra.amount = card.ability.extra.amount + 1
				return { message = localize { type = 'variable', key = 'SEMBY_out_of', vars = {
					card.ability.extra.amount, card.ability.extra.max_amount
				} } }
			end
			if context.destroy_card and (context.cardarea == G.play or context.cardarea == 'unscored')
			and context.destroy_card.ability.SEMBY_replicated then
				context.destroy_card.ability.SEMBY_replicated = nil
				return { remove = true }
			end
			-- Copy
			if context.after and card.ability.extra.amount >= card.ability.extra.max_amount then
        		G.GAME.SEMBY_used_replicator = (G.GAME.SEMBY_used_replicator or 0) + 1
				-- Create & Add Copy
                local replicated_joker = copy_card(G.jokers.cards[#G.jokers.cards])
                replicated_joker:add_to_deck()
				replicated_joker.states.visible = nil
                G.jokers:emplace(replicated_joker)
            	G.E_MANAGER:add_event(Event({
            	    func = function()
						replicated_joker:SEMBY_revive_animation()
            	        return true
            	    end
            	}))
				-- Destroy Replicator
                G.E_MANAGER:add_event(Event({
                    func = function()
						card.shattered = true
                        SMODS.destroy_cards(card, nil, true)
                        return true
                    end
                }))
                return { message = localize('k_duplicated_ex') }
			end
		end
	end,
	in_pool = function(self, args)
		return not G.GAME.SEMBY_used_replicator
	end
}
