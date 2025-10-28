SMODS.Consumable {
    key = "soul_gem",
	name = "SEMBY_soul_gem",
    set = "Spectral",
	atlas = "SEMBY_spectrals",
    pos = { x = 1, y = 0 },
	soul_pos = { x = 0, y = 1 },
    unlocked = true,
    discovered = false,
	config = {
		extra = {
			captured = 0,
			soul_pos_valid = { base = 0 },
			soul_pos_overwrite = { x = 0, y = 1 }
		}
	},
    loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
		-- Maybe preview what Soul you would Capture:
		local soul_type = card.ability.extra.captured
		if soul_type == 0 then
			return { key = 'c_SEMBY_soul_gem_empty' }
		elseif soul_type == 1 then
			return { vars = {
				localize('k_common'),
				colours = { G.C.RARITY.Common }
			} }
		elseif soul_type == 2 then
			return { vars = {
				localize('k_uncommon'),
				colours = { G.C.RARITY.Uncommon }
			} }
		elseif soul_type == 3 then
			return { vars = {
				localize('k_rare'),
				colours = { G.C.RARITY.Rare }
			} }
		elseif soul_type == 4 then
			return { vars = {
				localize('k_legendary'),
				colours = { G.C.RARITY.Legendary }
			} }
		else -- Fallback:
			--print("fallback")
			return { vars = {
				localize('k_uncommon'),
				colours = { G.C.RARITY.Uncommon }
			} }
		end
    end,
	set_ability = function(self, card, initial, delay_sprites)
		-- Pre-Capture in Booster-Packs
		if card.config.center.discovered then
			G.E_MANAGER:add_event(Event({
				func = function()
					if card.area == G.pack_cards then
						local pre_captured = pseudorandom("SEMBY_soul_gem")
						if pre_captured > 0.5 then
							card.ability.extra.captured = 1
						elseif pre_captured > 0.20 then
							card.ability.extra.captured = 2
						elseif pre_captured > 0.005 then
							card.ability.extra.captured = 3
						else
							card.ability.extra.captured = 4
						end
						card.ability.extra.soul_pos_overwrite.x = card.ability.extra.soul_pos_valid.base + card.ability.extra.captured
						card:flip()
						card:set_soul_pos('SEMBY_spectrals', card.ability.extra.soul_pos_overwrite)
						card:flip()
						play_sound('tarot1')
					end
					return true
				end
			}))
		end
	end,
	load = function(self, card, card_table, other_card)
		G.E_MANAGER:add_event(Event({
			func = function()
				if card.ability.extra.captured ~= 0 then
					card:set_soul_pos('SEMBY_spectrals', card.ability.extra.soul_pos_overwrite)
				end
				return true
			end
		}))
	end,
    add_to_deck = function(self, card, from_debuff)
		G.E_MANAGER:add_event(Event({
			func = function()
				if card.ability.extra.captured ~= 0 then
					card:set_soul_pos('SEMBY_spectrals', card.ability.extra.soul_pos_overwrite)
				end
				return true
			end
		}))
    end,
	calculate = function(self, card, context)
		if context.end_of_round and context.game_over == false and context.main_eval and card.ability.extra.captured == 0 and not context.blueprint then
			-- What got Defeated?
			if G.GAME.blind.boss then
				if G.GAME.blind.config.blind.boss.showdown then
					card.ability.extra.captured = 4
				else
					card.ability.extra.captured = 3
				end
			else
				if G.GAME.blind:get_type() == 'Small' then
					card.ability.extra.captured = 1
				else -- 'Big', Default
					card.ability.extra.captured = 2
				end
			end
			card.ability.extra.soul_pos_overwrite.x = card.ability.extra.soul_pos_valid.base + card.ability.extra.captured
			-- Visual Feedback
			return {
				message = 'Captured!', --localize('k_common'),
				colour = G.C.SECONDARY_SET.Spectral,
				G.E_MANAGER:add_event(Event({
					func = function()
						card:flip()
						card:set_soul_pos('SEMBY_spectrals', card.ability.extra.soul_pos_overwrite)
						card:flip()
						play_sound('tarot1')
						return true
					end
				}))
			}
		end
	end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
				local ret_message
				local ret_color
				local ret_sound
				if card.ability.extra.captured == 1 then
					SMODS.add_card({ set = 'Joker', rarity = 0.6, no_edition = true })
					ret_message = 'k_common'
					ret_color = G.C.RARITY.Common
					ret_sound = 'tarot2'
				elseif card.ability.extra.captured == 3 then
					SMODS.add_card({ set = 'Joker', rarity = 1.0, no_edition = true })
					ret_message = 'k_rare'
					ret_color = G.C.RARITY.Rare
					ret_sound = 'foil1'
				elseif card.ability.extra.captured == 4 then
					SMODS.add_card({ set = 'Joker', legendary = true, no_edition = true })
					check_for_unlock { type = 'spawn_legendary' }
					ret_message = 'k_legendary'
					ret_color = G.C.RARITY.Legendary
					ret_sound = 'timpani'
				else -- Default "2"
					SMODS.add_card({ set = 'Joker', rarity = 0.8, no_edition = true })
					ret_message = 'k_uncommon'
					ret_color = G.C.RARITY.Uncommon
					ret_sound = 'tarot1'
				end
                attention_text({
                    text = localize(ret_message),
                    scale = 1.3,
                    hold = 1.4,
                    major = card,
                    backdrop_colour = ret_color,
                    align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and 'tm' or 'cm',
                    offset = { x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and -0.2 or 0 }
                })
				play_sound(ret_sound, 1.05, 0.8)
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
    end,
    can_use = function(self, card)
        return card.ability.extra.captured ~= 0 and G.jokers and #G.jokers.cards < G.jokers.config.card_limit
    end
}
