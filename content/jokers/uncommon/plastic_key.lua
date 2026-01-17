SMODS.Joker {
	key = "plastic_key",
	name = "SEMBY_plastic_key",
	atlas = "SEMBY_jokers",
	pos = { x = 3, y = 7 },
    unlocked = true,
    discovered = false,
    eternal_compat = false,
    perishable_compat = true,
    blueprint_compat = false,
	rarity = 2,
	cost = 6,
	config = {
		extra = {
			spectrals = 2,
			delayed = false,
			pos_valid = { min = 3, max = 7 },
			pos_overwrite = { x = 3, y = 7 },
		}
	},
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
		return { vars = {
			card.ability.extra.spectrals
		} }
	end,
	set_ability = function(self, card, initial, delay_sprites)
		if card.config.center.discovered and initial then
			card.ability.extra.pos_overwrite.x = math.random(card.ability.extra.pos_valid.min, card.ability.extra.pos_valid.max)
			card.children.center:set_sprite_pos(card.ability.extra.pos_overwrite)
		end
	end,
	load = function(self, card, card_table, other_card)
		G.E_MANAGER:add_event(Event({
			func = function()
				card.children.center:set_sprite_pos(card.ability.extra.pos_overwrite)
				return true
			end
		}))
	end,
    add_to_deck = function(self, card, from_debuff)
		if not from_debuff then
			card.children.center:set_sprite_pos(card.ability.extra.pos_overwrite)
		end
    end,
	calculate = function(self, card, context)
		if context.end_of_round and context.main_eval and context.game_over == false
		and G.GAME.blind.boss and not context.blueprint then
            for i = 1, card.ability.extra.spectrals do
				if G.GAME.consumeable_buffer + #G.consumeables.cards < G.consumeables.config.card_limit then
					G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
					G.E_MANAGER:add_event(Event({
						func = (function()
							card:juice_up()
							play_sound('generic1')
							SMODS.add_card{ set = 'Spectral', key_append = 'SEMBY_plastic_key' }
							G.GAME.consumeable_buffer = G.GAME.consumeable_buffer - 1
							return true
						end)
					}))
					delay(0.2)
				else break end
            end
			-- Makes sure, you can actually get "Winning Stickers" on the Joker! :3
			if G.GAME.blind.config.blind.boss.showdown then
				card.ability.extra.delayed = true
				card.ability.SEMBY_price_mod = -1000000
				card:set_cost()
			end
            G.E_MANAGER:add_event(Event({
                func = function()
                    card:juice_up()
                    play_sound('cancel') --tarot1
					if not card.ability.extra.delayed then
						G.E_MANAGER:add_event(Event({
							trigger = 'after',
							delay = 0.3,
							blockable = false,
							func = function()
								card:start_dissolve()
								return true
							end
						}))
					end
                    return true
                end
            }))
            return {
				message = localize{ type = 'variable', key = 'SEMBY_spectrals', vars = { card.ability.extra.spectrals } },
                colour = G.C.SECONDARY_SET.Spectral
			}
		end
	end,
    calc_dollar_bonus = function(self, card)
		if card.ability.extra.delayed then
			card:start_dissolve()
		end
    end
}
