SMODS.Joker {
	key = "emergency_button",
	loc_txt = {
		name = "Emergency Button",
        text = {
            "Prevents Death and {C:legendary}Rerolls{}",
			"all {C:attention}Jokers{} and {C:attention}Consumables{}"
        }
	},
	config = {
		old_bones = ""
	},
	atlas = "SEMBY_jokers",
	pos = { x = 2, y = 0 },
	rarity = 2,
	blueprint_compat = false,
    eternal_compat = false,
	cost = 6,
	add_to_deck = function(self, card, from_debuff)
		if not from_debuff then
			card.ability.old_bones = G.localization.misc.dictionary.ph_mr_bones
		end
	end,
	calculate = function(self, card, context)
		if context.game_over and not context.blueprint then
			G.localization.misc.dictionary.ph_mr_bones = "EMERGENCY MEETING"
        	G.E_MANAGER:add_event(Event({
				func = function()
					G.hand_text_area.blind_chips:juice_up()
					G.hand_text_area.game_chips:juice_up()
					play_sound('tarot1')
					return true
				end
			}))
            G.GAME.used_jokers["j_SEMBY_emergency_button"] = nil
            local jokers = G.jokers.cards
            local consumables = G.consumeables.cards
            local num_jokers = #jokers - 1
            local legendaries = 0
            for k, v in pairs(jokers) do
                print(v.config.center.rarity)
                if v.config.center.rarity == 4 then
                    legendaries = legendaries + 1
                    num_jokers = num_jokers - 1
                end
                if (not v.ability.eternal) then
                    v:start_dissolve()
                else
                    num_jokers = num_jokers - 1
                end
            end
            local consumable_types = {}
            for k, v in pairs(consumables) do
                v:start_dissolve()
                consumable_types[v.ability.set] = true
            end
            for i = 1, num_jokers + 1 do
                play_sound('timpani')
                local card = create_card('Joker', G.jokers, nil, nil, nil, nil, nil, 'emergency_meeting')
                card:add_to_deck()
                G.jokers:emplace(card)
            end
            for i = 1, legendaries do
                play_sound('timpani')
                local card = create_card('Joker', G.jokers, true, nil, nil, nil, nil, 'emergency_meeting')
                card:add_to_deck()
                G.jokers:emplace(card)
            end
            for k, v in pairs(consumable_types) do
                print(k)
                local card = create_card(k, G.consumeables, nil, nil, nil, nil, nil, 'emergency_meeting')
                card:add_to_deck()
                G.consumeables:emplace(card)
            end
			return {
				saved = true,
				colour = G.C.RED
			}
		elseif context.ending_shop and not context.blueprint then
			G.localization.misc.dictionary.ph_mr_bones = card.ability.old_bones
        end
	end
}
