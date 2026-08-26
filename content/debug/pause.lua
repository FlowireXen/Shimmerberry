local PAUSE_TIME = 2.0
SMODS.Joker {
	key = "debugpause",
	SEMBY_art = "debug",
	loc_txt = {
		name = "DEBUG{C:red}PAUSE",
		text = {
			"{C:red}Pause{} for", "{C:attention}"..tostring(PAUSE_TIME).."{} second{C:inactive}(s)",
		}
	},
	atlas = "SEMBY_debug",
	pos = { x = 3, y = 0 },
	soul_pos = { x = 2, y = 1 },
	rarity = 1,
	cost = 1242,
	discovered = true,
	blueprint_compat = true,
	in_pool = function(self, args)
		return false
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				blocking = false,
				func = function()
					card:juice_up()
					--play_sound('gong', 0.5, 0.75)
					attention_text({
						text = 'PAUSE',
						backdrop_colour = HEX('000000'),
						scale = 1.0,
						hold = (PAUSE_TIME-0.1),
						major = card,
						align = 'cm',
						offset = { x = 0, y = 0 }
					})
					return true
				end
			}))
			delay(PAUSE_TIME)
			return nil, true
		end
    end
}
