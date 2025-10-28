SMODS.Blind {
    key = "frog",
	name = "SEMBY_frog",
    atlas = "SEMBY_blinds",
    pos = { x = 0, y = 1},
    --dollars = 5,
    --mult = 2,
    boss = {
		min = 2
	},
    boss_colour = HEX("8ed132"), --frog
    --loc_vars = function(self) SEMBY_Queue_Artist(self, info_queue) end,
    calculate = function(self, blind, context)
        if context.press_play and not blind.disabled then
			if G.hand.config.card_limit > 1 then
				blind:wiggle()
				-- Hand
				G.hand:change_size(-1)
				blind.hands_mod = (blind.hands_mod or 0) + 1
				-- Discard
				ease_discard(1)
				--blind.discards_mod = (blind.discards_mod or 0) + 1
				-- Just in case someone fixes the Metador-Triggers:
				blind.triggered = true
			end
        end
    end,
    disable = function(self)
		G.hand:change_size((G.GAME.blind.hands_mod or 0))
		G.GAME.blind.hands_mod = 0
    end,
    defeat = function(self)
		G.hand:change_size((G.GAME.blind.hands_mod or 0))
    end
}
