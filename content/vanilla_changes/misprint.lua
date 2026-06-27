--Ownership "Misprint"
SMODS.Joker:take_ownership( 'misprint', {
	--> Allows TMTRAINER in Shop
	set_ability = function(self, card, initial, delay_sprites)
		if card.config.center.discovered and initial then
			card.ability.SEMBY_tmtrainer_sticker = true
			card.ability.SEMBY_tmtrainer_value = '*418'
		end
	end,
    add_to_deck = function(self, card, from_debuff)
		SEMBY_TMTR_Spawn(true)
    end,
    remove_from_deck = function(self, card, from_debuff)
		SEMBY_TMTR_Spawn(false)
    end
}, true)
