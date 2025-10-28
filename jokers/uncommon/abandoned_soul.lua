SMODS.Joker {
	key = "abandoned_soul",
	name = "SEMBY_abandoned_soul",
	atlas = "SEMBY_jokers",
	pos = { x = 3, y = 3 },
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = false,
    blueprint_compat = true,
	rarity = 2,
	cost = 6,
	config = {
		extra = {
			xchips_mod = 0.1,
			xchips = 1.0
		}
	},
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
		return { vars = {
			card.ability.extra.xchips_mod,
			card.ability.extra.xchips
		} }
	end,
	calculate = function(self, card, context)
        if context.remove_playing_cards and not context.blueprint then
            local face_cards = 0
            for _, removed_card in ipairs(context.removed) do
                if removed_card:is_face() then face_cards = face_cards + 1 end
            end
            if face_cards > 0 then
                card.ability.extra.xchips = card.ability.extra.xchips + (face_cards * card.ability.extra.xchips_mod)
                return { 
					message = localize{ type = 'variable', key = 'a_xchips', vars = { card.ability.extra.xchips } },
					colour = G.C.CHIPS
				}
            end
        end
		if context.joker_main then
			return {
				xchips = card.ability.extra.xchips
			}
		end
	end,
    in_pool = function(self, args)
		if G.playing_cards then
			for _, playing_card in ipairs(G.playing_cards) do
				if playing_card:is_face() then return true end
			end
		end
		return false
	end
}
