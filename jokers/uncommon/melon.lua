SMODS.Joker {
	key = "melon",
	name = "SEMBY_melon",
	atlas = "SEMBY_jokers",
	pos = { x = 5, y = 0 },
    unlocked = true,
    discovered = false,
    eternal_compat = false,
    perishable_compat = true,
    blueprint_compat = true,
	rarity = 2,
	cost = 6,
	config = {
		extra = {
			percent = 0.5,
			delayed = false
		}
	},
	pools = {
        Food = true,
    },
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
		return { vars = {
			100 * card.ability.extra.percent
		} }
	end,
	calculate = function(self, card, context)
		if context.setting_blind and not (context.blueprint_card or self).getting_sliced then
			SEMBY_Reduce_Blindsize(card.ability.extra.percent, (context.blueprint_card or card), true)
			return nil, true
        end
		if context.end_of_round and context.main_eval and context.game_over == false
		and G.GAME.blind.boss and not context.blueprint then
			-- Makes sure, you can actually get "Winning Stickers" on the Joker! :3
			if G.GAME.blind.config.blind.boss.showdown then
				card.ability.extra.delayed = true
				card.ability.SEMBY_price_mod = -1000000
				card:set_cost()
			end
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
            return {
				message = localize('k_eaten_ex'),
				colour = G.C.GREEN
			}
		end
	end,
    calc_dollar_bonus = function(self, card)
		if card.ability.extra.delayed then
			card:start_dissolve()
		end
    end
}
