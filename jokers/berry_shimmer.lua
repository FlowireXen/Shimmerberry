SMODS.Joker {
	key = "berry_shimmer",
	name = "SEMBY_berry_shimmer",
	atlas = "SEMBY_jokers",
	pos = { x = 1, y = 0 },
    unlocked = true,
    discovered = true,
    eternal_compat = false,
    perishable_compat = true,
    blueprint_compat = true,
	rarity = 3,
	cost = 6,
	config = {
		activated = false,
		extra = {
			percent = 0.05
		}
	},
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
		local card_one = G.GAME.current_round.SEMBY_berry_rank_one or { rank = 'King' }
		local card_two = G.GAME.current_round.SEMBY_berry_rank_two or { rank = 'Queen' }
		return { vars = {
			localize(card_one.rank, 'ranks'),
			localize(card_two.rank, 'ranks'),
			100 * card.ability.extra.percent
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
					func = function()
						SEMBY_Reduce_Blindsize(card.ability.extra.percent, context.other_card, true)
						return true
					end
				}
			end
		end
		if context.end_of_round and context.cardarea == G.jokers and not context.blueprint then
			if not card.ability.activated then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card:juice_up()
                        play_sound('SEMBY_crunch_'..math.random(1, 2)) --'cancel'
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.3,
                            blockable = false,
                            func = function()
								card:start_dissolve()
                                return true
                            end
                        }))
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
