SMODS.Joker {
	key = "tempered_glass",
	name = "SEMBY_tempered_glass",
	atlas = "SEMBY_jokers",
	pos = { x = 5, y = 4 },
    draw = function(self, card, layer)
        if card.config.center.discovered or card.bypass_discovery_center then
            card.children.center:draw_shader('voucher', nil, card.ARGS.send_to_shader)
        end
    end,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = false,
    blueprint_compat = false,
	rarity = 1,
	cost = 4,
	config = {
		extra = {
			odds = 12
		}
	},
	enhancement_gate = 'm_glass',
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
		local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'SEMBY_tempered_glass')
        info_queue[#info_queue + 1] = G.P_CENTERS.m_glass
		return { vars = {
			numerator,
			denominator
		} }
	end,
	load = function(self, card, card_table, other_card)
		G.E_MANAGER:add_event(Event({
			func = function()
				if G.GAME.SEMBY_glass then
					G.P_CENTERS.m_glass.config.SEMBY_extra = G.P_CENTERS.m_glass.config.extra
					G.P_CENTERS.m_glass.config.extra = card.ability.extra.odds
				end
				return true
			end
		}))
	end,
	add_to_deck = function(self, card, from_debuff)
		G.GAME.SEMBY_glass = (G.GAME.SEMBY_glass or 0) + 1
		if G.GAME.SEMBY_glass == 1 then
			G.P_CENTERS.m_glass.config.SEMBY_extra = G.P_CENTERS.m_glass.config.extra
			G.P_CENTERS.m_glass.config.extra = card.ability.extra.odds
			-- Only needs to be done once:
			for _, playing_card in ipairs(G.playing_cards) do
				if SMODS.has_enhancement(playing_card, 'm_glass') then
					playing_card.ability.extra = G.P_CENTERS.m_glass.config.extra
				end
			end
		end
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.GAME.SEMBY_glass = (G.GAME.SEMBY_glass or 1) - 1
		if G.GAME.SEMBY_glass == 0 then
			G.P_CENTERS.m_glass.config.extra = G.P_CENTERS.m_glass.config.SEMBY_extra
			G.P_CENTERS.m_glass.config.SEMBY_extra = nil
			-- Only needs to be done once:
			for _, playing_card in ipairs(G.playing_cards) do
				if SMODS.has_enhancement(playing_card, 'm_glass') then
					playing_card.ability.extra = G.P_CENTERS.m_glass.config.extra
					if playing_card.ability.SEMBY_extra then
						playing_card.ability.SEMBY_extra = nil
					end
				end
			end
		end
	end
}
