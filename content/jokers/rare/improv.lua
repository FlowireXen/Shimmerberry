SMODS.Joker {
	key = "improv",
	SEMBY_art = "unkokat",
	atlas = "SEMBY_jokers_1",
	pos = { x = 2, y = 6 },
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = false,
	rarity = 3,
	cost = 8,
	config = {
		extra = {
			hand_mod = 1,
			points = 0,
			point_next = 0.00
		}
	},
    attributes = {
		'hands'
	},
	loc_vars = function(self, info_queue, card)
		return { vars = {
			'1', --point_mod,
			card.ability.extra.hand_mod,
			card.ability.extra.points,
			math.floor(card.ability.extra.point_next*1000)/10
		} }
	end,
	calculate = function(self, card, context)
		if not context.blueprint then -- Why so blue? o3o
			if G.GAME.current_round.hands_left == 0 and context.after then
				G.E_MANAGER:add_event(Event({
				    trigger = 'after',
					delay = 0.5,
					func = function()
						if G.GAME.chips < G.GAME.blind.chips and card.ability.extra.points >= 1 then -->= point_mod then
							card.ability.extra.points = card.ability.extra.points - 1 --point_mod
							ease_hands_played(math.floor(card.ability.extra.hand_mod + 0.5), true)
							-- Animate:
							card:juice_up()
							play_sound('generic1')
							attention_text({
								text = localize{ type = 'variable', key = 'a_hands', vars = { card.ability.extra.hand_mod } },
								backdrop_colour = G.C.BLUE,
								scale = 1.0, hold = 1.0,
								major = card, align = 'bm',
								offset = { x = 0, y = 0 }
							})
						else
							card:juice_up()
							play_sound('tarot2', 1.2, 0.8)
						end
						return true
					end
				}))
				return nil, true
			end
			if context.end_of_round and context.main_eval and context.game_over == false and G.GAME.current_round.hands_left > 0 then
				-- Technical
				local amount = G.GAME.current_round.hands_left
				local percent = card.ability.extra.point_next
				card.ability.extra.points = math.max(0, card.ability.extra.points)
				local divider = (card.ability.extra.points - (card.ability.extra.points%2) + 2) / 2 --> ( X - (X % 2) + 2) / 2
				-- Visual
				local added_points = 0
				-- Points Code
				for i = 1, amount do
					percent = percent + (1 / divider)
					if percent >= 1.0 then
						percent = percent - 1.0
						added_points = added_points + 1
						card.ability.extra.points = card.ability.extra.points + 1
						divider = (card.ability.extra.points - (card.ability.extra.points%2) + 2) / 2
					end
				end
				-- Remove all Hands
				G.E_MANAGER:add_event(Event({
					func = function()
						if G.GAME.current_round.hands_left > 0 then
							ease_hands_played(-G.GAME.current_round.hands_left, true)
						end
						return true
					end
				}))
				-- Feedback
				if added_points ~= 0 then
					card.ability.extra.point_next = percent
					return {
						message = localize{type = 'variable', key = 'SEMBY_points', vars = { added_points }},
						colour = G.C.GREEN
					}
				else
					amount = percent - card.ability.extra.point_next
					card.ability.extra.point_next = percent
					return {
						message = localize{type = 'variable', key = 'SEMBY_percentage', vars = { math.floor(amount*1000)/10 }},
						colour = G.C.IMPORTANT
					}
				end
			end
		end
    end
}
