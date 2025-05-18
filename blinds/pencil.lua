local blind = {
	key = "pencil",
	name = "SEMBY_pencil",
	boss = {min = 1, max = 10},
    boss_colour = HEX("4b43a5"), --blue/purple... blurple
    atlas = "critterblinds",
    pos = { x = 0, y = 0}
}

blind.press_play = function(self)
	if G.hand.highlighted then
		local card = G.hand.highlighted[1]
		card:juice_up()
        card:set_debuff(true)
        G.GAME.blind:wiggle()
        G.GAME.blind.triggered = true
	end
end

return blind
