local function get_texture()
	return { x = math.random(0, 9) == 0 and 9 or 8, y = 4 }
end
SMODS.Joker {
	key = "scav_prototype", -- "Casualties Unknown" Reference
	SEMBY_art = "placeholder",
	atlas = "SEMBY_jokers_2",
	pos = get_texture(), --> Changes each Game-Session
    eternal_compat = false,
    perishable_compat = true,
    blueprint_compat = false,
	rarity = 2,
	cost = 5,
	config = {
		extra = {
			numerator = 1,
			denominator = 4
		}
	},
    attributes = {
		'destroy_card', 'tag',
		'animal'
	},
	loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = 'tag_SEMBY_adt_duplitage', set = 'Tag' }
		local numerator, denominator = SMODS.get_probability_vars(card,
			card.ability.extra.numerator, card.ability.extra.denominator, 'SEMBY_scav_prototype')
		return { vars = {
			numerator,
			denominator
		} }
	end,
	calculate = function(self, card, context)
        if context.setting_blind and not (self.getting_sliced or context.blueprint) and card.area then
			-- Find Cards
            local scav_cards = {}
			local safe_pos = false
            for i = 1, #card.area.cards do
                if card.area.cards[i] == card then
					if safe_pos then scav_cards[#scav_cards+1] = card.area.cards[safe_pos] end
					safe_pos = i + 1
					break
				elseif not card.area.cards[i].getting_sliced then
					safe_pos = i
				end
            end
			if safe_pos then
				for i = safe_pos, #card.area.cards do
                	if not card.area.cards[i].getting_sliced then
						scav_cards[#scav_cards+1] = card.area.cards[i]
						break
					end
            	end
			end
			-- Main Logic
			if #scav_cards ~= 0 then
				local duplitages = 0
				-- Destroy Cards
				for i = 1, #scav_cards do
					if scav_cards[i] and not SMODS.is_eternal(scav_cards[i], card) and not scav_cards[i].getting_sliced then
						if SMODS.pseudorandom_probability(card, 'SEMBY_scav_prototype',
							card.ability.extra.numerator, card.ability.extra.denominator)
						then duplitages = duplitages + 1 end
						G.GAME.joker_buffer = G.GAME.joker_buffer - 1
						scav_cards[i].getting_sliced = true
						scav_cards[i].skip_destroy_animation = true
						scav_cards[i].SEMBY_shut_up = true
            		    G.E_MANAGER:add_event(Event({
            		        func = function()
            		            G.GAME.joker_buffer = 0
								scav_cards[i]:SEMBY_set_dissolve({{1, 1, 1, 0}, {1, 1, 1, 0}}, 0.0, 1.0, 0.3)
								scav_cards[i]:start_dissolve()
            		            return true
            		        end
            		    }))
					end
				end
				-- Duplitage(s)
				if duplitages ~= 0 then
					G.E_MANAGER:add_event(Event({
						func = function()
							for i = 1, duplitages do
								add_tag(Tag('tag_SEMBY_adt_duplitage'))
							end
							play_sound('highlight1', 1.2 + math.random() * 0.1, 0.5)
							return true
						end
					}))
				end
				-- Feedback
				return {
					message = duplitages == 0 and localize('k_nope_ex') or localize{ type = 'variable', key = 'SEMBY_plus', vars = { duplitages } },
					colour = duplitages == 0 and G.C.RED or G.C.GREEN,
					sound = 'SEMBY_magic_snap', pitch = 0.75 + math.random() * 0.5, volume = 1.2
				}
			end
		end
	end
}
