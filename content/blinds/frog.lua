SMODS.Blind {
    key = "frog",
	SEMBY_art = "flowire",
    atlas = "SEMBY_blinds", pos = { x = 0, y = 1},
    boss = { min = 2 },
    boss_colour = HEX("8ed132"),
    calculate = function(self, blind, context)
        if context.press_play and not blind.disabled then
			if G.hand.config.card_limit > 1 then
				blind:wiggle()
				G.hand:change_size(-1)
				blind.hands_mod = (blind.hands_mod or 0) + 1
				ease_discard(1)
				blind.triggered = true --> Metador
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
