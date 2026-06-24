--Ownership "Red Card"; Global Scaling, +3 -> +2 Mult
SMODS.Joker:take_ownership( 'red_card', {
    config = { extra = 2 },
	set_ability = function(self, card, initial, delay_sprites)
		if card.config.center.discovered and initial then
            card.ability.mult = card.ability.extra * (G.GAME.SEMBY_red_card or 0)
		end
	end,
}, false)
