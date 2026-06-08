SMODS.Joker {
	key = "melon",
	SEMBY_art = "unkokat",
	atlas = "SEMBY_jokers_1",
	pos = { x = 5, y = 0 },
    eternal_compat = false,
    perishable_compat = true,
    blueprint_compat = true,
	rarity = 2,
	cost = 6,
	config = {
		extra = {
			percent = 0.5
		}
	},
    attributes = {
		'food', 'boss_blind', 'xblindsize'
	},
	pools = {
        ["Food"] = true,
    },
	loc_vars = function(self, info_queue, card)
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
			-- Delay Destruction until Payout; Allows "Winning Stickers"! :3
			card.ability.extra.delayed = not G.GAME.won and G.GAME.round_resets.ante >= G.GAME.win_ante
    		G.E_MANAGER:add_event(Event({
				trigger = 'after',
    		    func = function()
    		        card:juice_up()
    		        play_sound('SEMBY_crunch_'..math.random(1, 2), 1.0, 0.8)
					if card.ability.extra.delayed then
						card:add_sticker('SEMBY_possessive', true)
					else card:start_dissolve() end
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
		if card.ability.extra.delayed then card:start_dissolve() end
    end
}
