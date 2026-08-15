SMODS.Blind {
    key = "ghost",
    SEMBY_art = "flowire",
    atlas = "SEMBY_blinds",
    pos = { x = 0, y = 3},
    dollars = 5,
    mult = 1.5,
    boss = { min = 2 },
    boss_colour = HEX("4d1575"),
    set_blind = function(self)
        G.GAME.blind.SEMBY_ghost_chips = G.GAME.blind.chips
		delay(0.5)
        for key, joker in ipairs(G.jokers.cards) do
			SEMBY_Increase_Blindsize(0.25, joker, true)
        end
		self.triggered = true --> Metador
	end,
	disable = function(self)
		G.GAME.blind.chips = G.GAME.blind.SEMBY_ghost_chips
            or (get_blind_amount(G.GAME.round_resets.ante)*G.GAME.starting_params.ante_scaling)
	end
}
