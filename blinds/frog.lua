local blind = {
	key = "frog",
	name = "SEMBY_frog",
	boss = {min = 2, max = 10},
    boss_colour = HEX("8ed132"), --frog
    atlas = "critterblinds",
    pos = { x = 0, y = 1}
}

blind.set_blind = function(self, reset, silent)
    if not G.GAME.blind.disabled then
        G.GAME.blind.hands_sub = 0
        self.discards_sub = 0
    end
end

blind.disable = function(self)
	-- Reset Hand
    G.hand:change_size(G.GAME.blind.hands_sub)
    --G.FUNCS.draw_from_deck_to_hand(blind.hands_sub)
    G.GAME.blind.hands_sub = 0
	-- "Reset" Discards
    ease_discard(-self.discards_sub)
	if G.GAME.current_round.discards_left < 0 then G.GAME.current_round.discards_left = 0 end
    self.discards_sub = 0
end

blind.defeat = function(self, silent)
	-- Reset Hand
    G.hand:change_size(G.GAME.blind.hands_sub)
end

blind.press_play = function(self)
    if G.hand.config.card_limit > 1 then
        G.hand:change_size(-1)
        G.GAME.blind.hands_sub = G.GAME.blind.hands_sub + 1
		ease_discard(1)
		self.discards_sub = self.discards_sub + 1
        G.GAME.blind:wiggle()
		G.GAME.blind.triggered = true
    end
end

return blind
