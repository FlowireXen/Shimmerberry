SMODS.Blind {
    key = "pencil",
	SEMBY_art = "flowire",
    atlas = "SEMBY_blinds",
    pos = { x = 0, y = 0},
    boss = { min = 0 },
    boss_colour = HEX("4b43a5"),
    calculate = function(self, blind, context)
        if context.press_play and not blind.disabled then
			if G.hand.highlighted then
				blind:wiggle()
				G.hand.highlighted[1]:juice_up()
				G.hand.highlighted[1]:set_debuff(true)
				blind.triggered = true --> Metador
			end
        end
    end
}
