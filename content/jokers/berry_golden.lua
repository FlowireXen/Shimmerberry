SMODS.Joker {
	key = "berry_golden",
	SEMBY_art = "unkokat",
	atlas = "SEMBY_jokers_1",
	pos = { x = 3, y = 0 },
    discovered = true,
    eternal_compat = false,
    perishable_compat = true,
    blueprint_compat = true,
	rarity = 2,
	cost = 5,
	config = {
		activated = false,
		extra = {
			dollars = 2
		}
	},
    attributes = {
		'food', 'rank', 'economy'
	},
	pools = {
        ["Food"] = true,
		["Berry"] = true,
    },
	loc_vars = function(self, info_queue, card)
		local card_one = G.GAME.current_round.SEMBY_berry_rank_one or { rank = 'King' }
		local card_two = G.GAME.current_round.SEMBY_berry_rank_two or { rank = 'Queen' }
		return { vars = {
			localize(card_one.rank, 'ranks'),
			localize(card_two.rank, 'ranks'),
			card.ability.extra.dollars
		} }
	end,
	calculate = function(self, card, context)
		if context.setting_blind and not (self.getting_sliced or context.blueprint) then
			card.ability.activated = false
		end
		if context.individual and context.cardarea == G.play then
			if context.other_card:get_id() == G.GAME.current_round.SEMBY_berry_rank_one.id
			or context.other_card:get_id() == G.GAME.current_round.SEMBY_berry_rank_two.id then
				card.ability.activated = true
				--> This is too slow: Card scores, and when the NEXT card scores you get the Money.
				return { dollars = card.ability.extra.dollars }
			end
		end
		if context.end_of_round and context.main_eval and not context.blueprint then
			if not card.ability.activated then
                G.E_MANAGER:add_event(Event({
                    func = function()
    			        card:juice_up()
    			        play_sound('SEMBY_crunch_'..math.random(1, 2), 1.0, 0.8)
						card:start_dissolve()
                        return true
                    end
                }))
                return { message = localize('k_eaten_ex') }
			else
				return { message = localize('k_safe_ex') } 
			end
		end
	end
}
