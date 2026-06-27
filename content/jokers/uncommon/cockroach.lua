SMODS.Joker {
	key = "cockroach", --> The Roach that Kills you
	SEMBY_art = "unkokat",
	atlas = "SEMBY_jokers_1",
	pos = { x = 7, y = 2 },
    eternal_compat = false,
    perishable_compat = false,
    blueprint_compat = true,
	rarity = 2,
	cost = 6,
	config = {
		extra = {
			ante_mod = 1.0
		}
	},
    attributes = {
		'boss_blind',
		'ante', 'animal'
	},
	loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "SEMBY_skip_info", set = "Other" }
		return { vars = {
			card.ability.extra.ante_mod
		} }
	end,
	set_ability = function(self, card, initial, delay_sprites)
		if card.config.center.discovered and initial then
			card:add_sticker('SEMBY_possessive', true)
		end
	end,
	calculate = function(self, card, context)
		if context.modify_ante and context.ante_end then
			-- Quick-Message
			local juice_card = (context.blueprint_card or card)
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				blocking = false,
				func = function()
					juice_card:juice_up(0.2, 0.2)
					play_sound('generic1', 1.2, 0.5)
					attention_text({
						text = localize('SEMBY_eval_cockroach'),
						backdrop_colour = HEX('BE3740'),
						scale = 0.8, hold = 0.5,
						major = juice_card, align = 'bm',
						offset = { x = 0, y = 0 }
					})
					return true
				end
			}))
			return {
				modify = context.modify_ante + math.floor(card.ability.extra.ante_mod)
			}
		end
	end
}
