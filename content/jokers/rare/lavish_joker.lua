SMODS.Joker {
	key = "lavish_joker",
	SEMBY_art = "unkokat",
	atlas = "SEMBY_jokers_1",
	pos = { x = 0, y = 2 },
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = false,
	rarity = 3,
	cost = 1,
	config = {
		extra = {
			money_saved = 0,
			money_mod = 1,
			percent_mod = 0.05,
			lavish_buff = false
		},
		SEMBY_price_mod = -1
	},
    attributes = {
		'economy', 'xblindsize', 'tag'
	},
	pools = {
		["Chad"] = true,
    },
	loc_vars = function(self, info_queue, card)
		if card.ability.extra.lavish_buff then -- Challenge Modifier:
			info_queue[#info_queue + 1] = { key = "SEMBY_lavish_buff", set = "Other" }
		end
		return { vars = {
			card.ability.extra.money_saved,
			card.ability.extra.money_mod,
			card.ability.extra.percent_mod * 100,
			card.ability.extra.money_saved / card.ability.extra.money_mod * card.ability.extra.percent_mod * 100
		} }
	end,
	calculate = function(self, card, context)
		if not context.blueprint then
			if context.money_altered then
				if context.amount < 0 then
					card.ability.extra.money_saved = card.ability.extra.money_saved + (-context.amount)
					-- Feedback
					local ret_amount = math.floor((-context.amount) + 0.5)
					G.E_MANAGER:add_event(Event({
						trigger = 'after',
						blocking = false,
						func = function()
							card:juice_up(0.2)
							play_sound('generic1', 0.9 + math.random()*0.2, 0.8)
							attention_text({
								text = localize{ type = 'variable', key = 'SEMBY_money_plus', vars = { ret_amount } },
								backdrop_colour = G.C.MONEY, scale = 0.8, hold = 0.8,
								major = card, align = 'bm', offset = { x = 0, y = 0 }
							})
							return true
						end
					}))
				end
				return nil, false
			end
    		if context.starting_shop and card.ability.extra.money_saved ~= 0 then
				local ret_val = card.ability.extra.money_saved
				card.ability.extra.money_saved = 0
				local lavish_debt = Tag('tag_SEMBY_ngt_lavish')
				lavish_debt.ability.lavish_percent = ret_val / card.ability.extra.money_mod * card.ability.extra.percent_mod
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					func = function()
        		        add_tag(lavish_debt)
        		        play_sound('highlight1', 1.2 + math.random() * 0.1, 0.5)
						return true
					end
				}))
				return {
					message = localize('SEMBY_lavish_debt'),
					colour = G.C.MONEY,
					extra = { dollars = ret_val }
				}
			end
		end
	end
}
