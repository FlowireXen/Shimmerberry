SMODS.Joker {
	key = "chrono_break",
	name = "SEMBY_chrono_break",
	atlas = "SEMBY_jokers",
	pos = { x = 0, y = 1 },
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
	rarity = 3,
	cost = 7,
	pools = {
		["Music"] = true,
		["Numetal_Special"] = true,
    },
	loc_vars = function(self, info_queue, card)
		if Shimmerberry.compat.buffoonery and Buffoonery.config.show_info then
			info_queue[#info_queue+1] = {set = 'Other', key = 'nu_metal_info'}
		end
		SEMBY_Queue_Artist(card, info_queue)
	end,
    calculate = function(self, card, context)
		--## Revive Logic
        if context.remove_playing_cards and not context.blueprint then
            for _, removed_card in ipairs(context.removed) do
                if removed_card.glass_trigger or removed_card.shattered
				-- Manually Added "Shatter"-Editions
				or SMODS.has_enhancement(removed_card, 'm_glass')
				-- SMODS Fallback:
				or SMODS.shatters(removed_card)
				then removed_card:SEMBY_revive_copy(card) end
            end
			return nil, true -- For retrigger purposes
        end
		--## Shatter Logic
		if context.before then
			local temporal = {}
			for _, playing_card in ipairs(context.scoring_hand) do
				if not playing_card.SEMBY_chrono_break then
					temporal[#temporal + 1] = playing_card
				end
			end
			if #temporal ~= 0 then
				pseudoshuffle(temporal)
				temporal[1].SEMBY_chrono_break = true
				-- Visual Flair
				local juice_card = (context.blueprint_card or card)
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					func = function()
						temporal[1]:SEMBY_set_dissolve({{1, 1, 1, 1}, {0.8, 0.8, 0.8, 0.8}}, 0.0, 0.1, 1.0)
						juice_card:juice_up(0.1, 0.1)
						return true
					end
				}))
			end
		end
        if context.destroy_card and context.cardarea == G.play then
            if context.destroy_card.SEMBY_chrono_break then
				context.destroy_card.shattered = true
                return {
                    remove = true
                }
            end
        end
    end
}
