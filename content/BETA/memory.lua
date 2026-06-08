SMODS.Enhancement {
    key = 'memory',
	SEMBY_art = "flowire",
	atlas = "SEMBY_enhancements",
	pos = { x = 1, y = 0 },
	replace_base_card = true,
	no_rank = true,
	always_scores = true,
    badge_colour = G.C.SEMBY_MEMORY,
	config = {
		extra = {
			SEMBY_Graphics = { Memory = true }, --> /functions/drawsteps.lua
			memory_gain = 3
		}
	},
	loc_vars = function(self, info_queue, card)
		if card.base then
			return { vars = {
				card.base.suit and localize(card.base.suit, 'suits_plural') or localize('SEMBY_empty_memory'),
				card.base.suit and localize(card.base.suit, 'suits_singular') or localize('SEMBY_empty_memory'),
				G.GAME.SEMBY_memory and G.GAME.SEMBY_memory[card.base.suit or 'Empty'] or '0',
				card.ability.extra.memory_gain,
				colours = { (card.base.suit and G.C.SUITS[card.base.suit] or G.C.BLACK) }
			} }
		else--No Base
			return {
				key = 'm_SEMBY_memory_desc',
				vars = { card.ability.extra.memory_gain }
			}
		end
	end,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
			local gain = card.ability.extra.memory_gain * (G.GAME.SEMBY_memory_mod or 1)
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				blocking = false,
				func = function()
					attention_text({
						text = localize{ type = 'variable', key = 'SEMBY_plus', vars = { gain } },
						backdrop_colour = G.C.CHIPS,
						scale = 1.0, hold = 0.8, major = card,
						align = 'cm', offset = { x = 0, y = 0 }
					})
					return true
				end
			}))
			local ret_val = SEMBY_memory_update(card.base.suit or 'Empty', gain) * (G.GAME.SEMBY_memory_mod or 1)
			if G.GAME.SEMBY_memory_mod then return { score = ret_val } else return { chips = ret_val } end
        end
    end
}

function SEMBY_memory_update(suit, gain)
	G.GAME.SEMBY_memory.Buffer[suit] = (G.GAME.SEMBY_memory.Buffer[suit] or 0) + gain
	G.E_MANAGER:add_event(Event({
		func = function()
			G.GAME.SEMBY_memory.Buffer[suit] = nil
			G.GAME.SEMBY_memory[suit] = (G.GAME.SEMBY_memory[suit] or 0) + gain
			return true
		end
	}))
	return (G.GAME.SEMBY_memory[suit] or 0) + G.GAME.SEMBY_memory.Buffer[suit]
end
