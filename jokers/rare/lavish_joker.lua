SMODS.Joker {
	key = "lavish_joker",
	name = "SEMBY_lavish_joker",
	atlas = "SEMBY_jokers",
	pos = { x = 10, y = 5 },
    unlocked = true,
    discovered = false,
    eternal_compat = true, --> "true" after Playtest 0.5
    perishable_compat = true,
    blueprint_compat = false,
	rarity = 3,
	cost = 1, --( -1 )--> 0
	config = {
		extra = {
			uses = 20, --> Additionally hardcoded down below(!)
			percent_mod = 0.05,
			percent = 0.0,
			possessive = false,
			lavish_buff = false
		},
		SEMBY_price_mod = -1
	},
	pronouns = "SEMBY_chad",
	pools = {
		["Chad"] = true,
    },
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
		if not card.ability.SEMBY_possessive then
			info_queue[#info_queue + 1] = { key = "SEMBY_possessive", set = "Other" }
		end
		if card.ability.extra.lavish_buff then -- Challenge Modifier:
			info_queue[#info_queue + 1] = { key = "SEMBY_lavish_buff", set = "Other" }
		end
		return { vars = {
			card.ability.extra.uses,
			100 * card.ability.extra.percent_mod,
			100 * card.ability.extra.percent
		} }
	end,
    remove_from_deck = function(self, card, from_debuff)
		-- When Destroyed with Debt: Create "Lavish Debt" Tag
		if not from_debuff and card.ability.extra.percent ~= 0 then
			local lavish_debt = Tag('tag_SEMBY_lavish_debt')
			lavish_debt.ability.lavish_percent = card.ability.extra.percent
            G.E_MANAGER:add_event(Event({
                func = (function()
                    play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
					attention_text({
						text = localize('SEMBY_lavish_debt'),
						scale = 1.0, hold = 1.5, major = card,
						backdrop_colour = G.C.MONEY,
						align = 'cm', offset = 0
					})
                    add_tag(lavish_debt)
                    play_sound('highlight1', 1.2 + math.random() * 0.1, 0.5)
                    return true
                end)
            }))
		end
	end,
	calculate = function(self, card, context)
		if context.money_altered and not context.blueprint then
			if context.amount < 0 then
				local amount = math.floor((-context.amount) + 0.5)
				-- Change:
				local change = amount * card.ability.extra.percent_mod
				card.ability.extra.percent = card.ability.extra.percent + change
				-- P2W Support:
				if G.GAME.SEMBY_p2w and G.GAME.SEMBY_p2w > 0 then
					G.GAME.SEMBY_p2w = G.GAME.SEMBY_p2w - amount
				end
				-- Quick Feedback:
				ease_dollars(-context.amount)
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					blocking = false,
					func = function()
						card:juice_up(0.1, (math.random() < 0.5) and 0.2 or -0.2)
						play_sound('generic1', 1.1, 0.8)
						attention_text({
							text = localize{ type = 'variable', key = 'SEMBY_up_blind_size', vars = { change*100 } },
							backdrop_colour = G.C.SEMBY_PERCENT, scale = 0.8, hold = 1.2, major = card, align = 'bm', offset = { x = 0, y = 0 }
						})
						return true
					end
				}))
				-- Possessive
				if not card.ability.extra.possessive then
					card.ability.extra.uses = (card.ability.extra.uses or 20) - amount
					if card.ability.extra.uses > 0 then
						-- Additional Quick Feedback:
						G.E_MANAGER:add_event(Event({
							trigger = 'after',
							blocking = false,
							func = function()
								attention_text({
									text = localize{ type = 'variable', key = 'SEMBY_money_left', vars = { card.ability.extra.uses } },
									backdrop_colour = G.C.MONEY, scale = 0.8, hold = 1.2, major = card, align = 'bm', offset = { x = 0, y = 1.0 }
								})
								return true
							end
						}))
					else -- Turn Possessive
						card.ability.extra.possessive = true
						card.ability.extra.uses = 0
						-- Animate
						G.E_MANAGER:add_event(Event({
							trigger = 'after',
							delay = 0.4,
							func = function()
								card:juice_up(0.2, 0.3)
								play_sound('tarot1', 1.1, 1.0)
								return true
							end
						}))
						G.E_MANAGER:add_event(Event({
							trigger = 'after',
							delay = 0.4,
							func = function()
								card:juice_up(0.2, -0.3)
								play_sound('tarot1', 1.2, 1.0)
								return true
							end
						}))
						delay(0.4)
						G.E_MANAGER:add_event(Event({
							func = function()
								play_sound('whoosh2', 1.2, 0.8)
								-- Add Sticker
								card:add_sticker('SEMBY_possessive', true)
								return true
							end
						}))
						return {
							message = localize('SEMBY_possessed_ex'),
							colour = HEX('BE3740')
						}
					end
				end
				-- Lavish Exit
				return nil, true
			end
		end
		if context.setting_blind and not self.getting_sliced and not context.blueprint then
			if card.ability.extra.percent and card.ability.extra.percent ~= 0.0 then
				SEMBY_Increase_Blindsize(card.ability.extra.percent, card, true)
				card.ability.extra.percent = 0.0
				return { message = localize('k_reset') }
			end
        end
	end
}
