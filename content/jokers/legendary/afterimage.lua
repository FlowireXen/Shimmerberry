SMODS.Joker {
	key = "afterimage",
	SEMBY_art = "unkokat",
	atlas = "SEMBY_jokers_2",
	pos = { x = 8, y = 1 },
	soul_pos = { x = 9, y = 1 },
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
    attributes = {
		'copying',-- 'copying', 'copying',
	},
	loc_vars = function(self, info_queue, card)
        local main_blueprint_info = nil
		if card.area and not card.area.config.collection then
			local copy_joker = nil
			for i = 1, #card.area.cards do
				if card.area.cards[i] == card then
					copy_joker = card.area.cards[i - 1]
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
		if card.area then
			local copy_joker = nil
			for i = 1, #card.area.cards do
				if card.area.cards[i] == card then
					copy_joker = card.area.cards[i - 1]
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
	end
}
