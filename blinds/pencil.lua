SMODS.Blind {
    key = "pencil",
	name = "SEMBY_pencil",
    atlas = "SEMBY_blinds",
    pos = { x = 0, y = 0},
    --dollars = 5,
    --mult = 2,
    boss = {
		min = 0
	},
    boss_colour = HEX("4b43a5"), --blue/purple... blurple
    --loc_vars = function(self) SEMBY_Queue_Artist(self, info_queue) end,
    calculate = function(self, blind, context)
        if context.press_play and not blind.disabled then
			if G.hand.highlighted then
				blind:wiggle()
				-- Simple Card Debuff
				G.hand.highlighted[1]:juice_up()
				G.hand.highlighted[1]:set_debuff(true)
				-- Just in case someone fixes the Metador-Triggers:
				blind.triggered = true
			end
        end
    end
}
