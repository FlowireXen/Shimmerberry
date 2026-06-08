SMODS.Joker {
	key = "berry_blue",
	SEMBY_art = "unkokat",
	atlas = "SEMBY_jokers_1",
	pos = { x = 4, y = 0 },
    discovered = true,
    eternal_compat = false,
    perishable_compat = true,
    blueprint_compat = true,
	rarity = 1,
	cost = 4,
	config = {
		activated = false,
		extra = {
			chips = 30
		}
	},
    attributes = {
		'food', 'rank', 'chips',
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
			card.ability.extra.chips
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
				return {
					chips = card.ability.extra.chips
				}
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
