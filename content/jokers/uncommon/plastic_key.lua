local AMOUNT = 5
local function get_texture(state)
	if not state or state > AMOUNT or state < 1 then
		state = math.random(1, AMOUNT)
	end
	return { x = math.floor(state)-1, y = 1 }
end
SMODS.Joker {
	key = "plastic_key",
	SEMBY_art = "unkokat",
	atlas = "SEMBY_jokers_2",
	pos = get_texture(),
    eternal_compat = false,
    perishable_compat = true,
    blueprint_compat = false,
	rarity = 2,
	cost = 6,
	config = {
		extra = {
			spectrals = 2,
			state = nil
		}
	},
    attributes = {
		'generation', 'boss_blind', 'spectral'
	},
	loc_vars = function(self, info_queue, card)
		return { vars = {
			card.ability.extra.spectrals
		} }
	end,
	set_ability = function(self, card, initial, delay_sprites)
		if card.config.center.discovered and initial then
			card.ability.extra.state = math.random(1, AMOUNT)
			card.children.center:set_sprite_pos(get_texture(card.ability.extra.state))
		end
	end,
	set_sprites = function(self, card, front)
		if card.ability and card.ability.extra then
			card.children.center:set_sprite_pos(get_texture(card.ability.extra.state))
		end
	end,
    add_to_deck = function(self, card, from_debuff)
		if not from_debuff then
			card.children.center:set_sprite_pos(get_texture(card.ability.extra.state))
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
			-- Delay Destruction until Payout; Allows "Winning Stickers"! :3
			card.ability.extra.delayed = not G.GAME.won and G.GAME.round_resets.ante >= G.GAME.win_ante
    		G.E_MANAGER:add_event(Event({
				trigger = 'after',
    		    func = function()
    		        card:juice_up()
    		        play_sound('cancel')
					if card.ability.extra.delayed then
						card:add_sticker('SEMBY_possessive', true)
					else card:start_dissolve() end
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
		if card.ability.extra.delayed then card:start_dissolve() end
    end
}
