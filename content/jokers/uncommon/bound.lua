local function ApplyStickers(amount)
	local unbound_jokers = {}
	for _, area in ipairs(SMODS.get_card_areas('jokers')) do
		for _, card in ipairs(area.cards) do
			if card.ability.set == 'Joker' and not card.ability.SEMBY_bound then
				unbound_jokers[#unbound_jokers+1] = card
			end
		end
	end
	if #unbound_jokers ~= 0 then
		stop_use()
		pseudoshuffle(unbound_jokers, 'SEMBY_bound')
		amount = math.min(#unbound_jokers, amount)
		for i = 1, amount do
            local percent = 1.15 - (i - 0.999) / (#unbound_jokers - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    unbound_jokers[i]:flip()
                    play_sound('card1', percent)
                    unbound_jokers[i]:juice_up(0.3)
                    return true
                end
            }))
            G.E_MANAGER:add_event(Event({
                func = function()
                    unbound_jokers[i]:add_sticker('SEMBY_bound', true)
                    return true
                end
            }))
		end
        delay(0.15)
        for i = 1, amount do
            local percent = 0.85 + (i - 0.999) / (#unbound_jokers - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    unbound_jokers[i]:flip()
                    play_sound('tarot2', percent, 0.6)
                    unbound_jokers[i]:juice_up(0.3)
                    return true
                end
            }))
        end
        delay(0.5)
	end
end
SMODS.Joker{
	key = "bound",
	SEMBY_art = "flowire",
    atlas = 'SEMBY_jokers_1',
    pos = { x = 2, y = 4 },
    eternal_compat = false,
    perishable_compat = true,
    blueprint_compat = false,
    rarity = 2,
    cost = 6,
	config = {
		extra = {
			count = 2,
			reward = true
		}
	},
    attributes = {
		'destroy_card', 'joker', 'joker_slot',
		'debuff_card'
	},
	loc_vars = function(self, info_queue, card)
        return { vars = {
			card.ability.extra.count
		} }
    end,
	set_ability = function(self, card, initial, delay_sprites)
		if card.config.center.discovered and initial then
			card:add_sticker('SEMBY_bound', true)
		end
	end,
    add_to_deck = function(self, card, from_debuff)
		if not from_debuff then
			ApplyStickers(math.floor(card.ability.extra.count + 0.5))
		end
    end,
    remove_from_deck = function(self, card, from_debuff)
		if not from_debuff and card.ability.extra.reward then
			ApplyStickers(math.floor(card.ability.extra.count + 0.5))
		end
	end,
	calculate = function(self, card, context)
		if context.selling_self and not context.blueprint then
			card.ability.extra.reward = false
		end
	end
}
