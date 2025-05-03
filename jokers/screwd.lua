SMODS.Joker {
	key = "screwd",
	loc_txt = {
		name = "Screw'd",
		-- Changing Text with Formatting;
		text = { "{C:inactive,s:0.75}#1#{}#2#{C:legendary}#3#{}#4#" }
	},
	rarity = 1,
	cost = 2,
	atlas = "SEMBY_jokers",
	pos = { x = 7, y = 0 }, -- texture resets each reload.... /shrug :3
	blueprint_compat = false,
	eternal_compat = false,
    config = { stage = 0, bionicles_four_ever = 4, extra = { odds = 100 } }, -- Stoopid me made it 4+1 accidentally /shrug
	loc_vars = function(self, _info, card)
		if card.ability.stage then
			if card.ability.stage <= 0 then
				return { vars = { "Does nothing!", '', '', '' } }
			elseif card.ability.stage == 1 then
				return { vars = { "Does nothing...?", '', '', '' } }
			elseif card.ability.stage == 2 then
				return { vars = { "Does nothing, right?", '', '', '' } }
			elseif card.ability.stage == 3 then
				return { vars = { '', "Does... ", "Something", "?" } }
			elseif card.ability.stage == 4 then
				return { vars = { '', 'Is it ', "Transforming", "?" } }
			else -- only visible while transforming
				return { vars = { '', '', "Transforming", "!" } }
			end
		else -- stage == nil == 0
			return { vars = { "Does nothing!", '', '', '' } }
		end
    end,
	calculate = function(self, card, context)
		if context.setting_blind and not context.blueprint and not self.getting_sliced then
			if card.ability.stage then
				if card.ability.stage >= card.ability.bionicles_four_ever then
					G.GAME.joker_buffer = G.GAME.joker_buffer + 1
					G.E_MANAGER:add_event(Event({
						func = function()
							local screwd = nil
							if pseudorandom("screwd") < G.GAME.probabilities.normal / card.ability.extra.odds then
								screwd = create_card('Joker', G.jokers, true, nil, nil, nil, nil, 'screwd') -- legendary
							else
								screwd = create_card('Joker', G.jokers, nil, nil, nil, nil, nil, 'screwd') -- set 4th between 0.0 and 1.0 for rarity
							end
							screwd:set_edition('e_negative', true)
							screwd.sell_cost = to_big(0)
							screwd:add_to_deck()
							G.jokers:emplace(screwd)
							screwd:start_materialize()
							G.GAME.joker_buffer = G.GAME.joker_buffer - 1
							return true
						end
					}))
					G.E_MANAGER:add_event(Event({
						func = function()
							play_sound('tarot1')
							card:juice_up(0.3, 0.4)
							G.E_MANAGER:add_event(Event({
								trigger = 'after',
								blockable = false,
								func = function()
									G.jokers:remove_card(card)
									card:remove()
									card = nil
									return true;
								end
							}))
							return true
						end
					}))
					--card.config.center.pos.y = 0
					card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Screw'd!", colour = G.C.WHITE})
					return -- return early...
				elseif card.ability.stage < 0 then -- stage was negative? just set to stage 1.
					card.ability.stage = 1
				else
					card.ability.stage = card.ability.stage + 1
				end
			else -- stage was nil? just set to stage 1.
				card.ability.stage = 1
			end
			-- a lil' scuffed, but it works :>
			if card.config.center.pos.y == 0 then
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					func = function()
						-- JUICE
						card:juice_up()
						-- Change Card Texture (from 0 to...) [for the session]
						card.config.center.pos.y = 1
						-- Fitting Sound
						play_sound('gold_seal')
						return true
					end
				}))
			end
			local retval = "?" -- order: ??, ???, ????, ?????
			for i = 1, card.ability.stage do retval = retval .. "?" end
			card_eval_status_text(card, 'extra', nil, nil, nil, {message = retval, colour = G.C.WHITE})
			return true -- wiggle :)   --note: only safe bcs, no blueprint
		end
	end
}
