SMODS.Consumable {
    key = 'daybreak',
    SEMBY_art = "flowire",--"placeholder",
	atlas = "SEMBY_consumables",
    pos = { x = 4, y = 0 },
    set = "Spectral",
    config = {
		extra = {
			mod_conv = 'm_bonus'
		}
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.extra.mod_conv]
		return { vars = {
			localize{ type = 'name_text', set = 'Enhanced', key = card.ability.extra.mod_conv }
		} }
    end,
	set_ability = function(self, card, initial, delay_sprites)
		if card.config.center.discovered and initial then
            card.ability.extra.mod_conv = SMODS.poll_enhancement{guaranteed = true, key = "SEMBY_daybreak"}
		end
	end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3)
                return true
            end
        }))
        for i = 1, #G.hand.cards do
            local percent = 1.15 - (i - 0.999) / (#G.hand.cards - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.cards[i]:flip()
                    play_sound('card1', percent)
                    G.hand.cards[i]:juice_up(0.3)
                    return true
                end
            }))
        end
        for i = 1, #G.hand.cards do
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.hand.cards[i]:set_ability(card.ability.extra.mod_conv)
                    return true
                end
            }))
        end
        for i = 1, #G.hand.cards do
            local percent = 0.85 + (i - 0.999) / (#G.hand.cards - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.cards[i]:flip()
                    play_sound('tarot2', percent, 0.6)
                    G.hand.cards[i]:juice_up(0.3)
                    return true
                end
            }))
        end
        delay(0.5)
        -- Achievement
        if card.ability.extra.mod_conv == 'm_stone' or
            (G.P_CENTERS[card.ability.extra.mod_conv] and G.P_CENTERS[card.ability.extra.mod_conv].no_rank)
        then check_for_unlock({ type = 'SEMBY_check', daybreak = true }) end
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.cards > 0
    end
}
