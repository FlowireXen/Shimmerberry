SMODS.Joker {
	key = "afterimage",
	name = "SEMBY_afterimage",
	atlas = "SEMBY_jokers",
	pos = { x = 2, y = 6 },
	soul_pos = { x = 2, y = 7 },
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
	rarity = 4,
	cost = 20,
	config = {
		extra = {
			repeats = 3
		}
	},
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
        local main_blueprint_info = nil
		if G.jokers then
			local copy_joker = nil
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == card then
					copy_joker = G.jokers.cards[i - 1]
					break
				end
			end
			local compatible = copy_joker and copy_joker.config.center.blueprint_compat
			main_blueprint_info = { {
				n = G.UIT.C, config = { align = "bm", minh = 0.4 },
				nodes = { {
					n = G.UIT.C, config = { 
						ref_table = card, align = "m",
						colour = compatible and mix_colours(G.C.GREEN, G.C.JOKER_GREY, 0.8) or mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8),
						r = 0.05, padding = 0.06
					},
					nodes = { { 
						n = G.UIT.T, config = {
							text = ' ' .. localize('k_' .. (compatible and 'compatible' or 'incompatible')) .. ' ',
							colour = G.C.UI.TEXT_LIGHT, scale = 0.32 * 0.8
						}
					} }
				} }
			} }
		end
		return {
			vars = { card.ability.extra.repeats },
			main_end = main_blueprint_info
		}
	end,
	calculate = function(self, card, context)
		local copy_joker = nil
		for i = 1, #G.jokers.cards do
			if G.jokers.cards[i] == card then
				copy_joker = G.jokers.cards[i - 1]
				break
			end
		end
		if copy_joker then
			local merged_hell = {}
			for i = 1, card.ability.extra.repeats do
				merged_hell = SMODS.merge_effects( { merged_hell }, { SMODS.blueprint_effect(card, copy_joker, context) } )
			end
			return merged_hell
		else
			return nil
		end
	end
}
