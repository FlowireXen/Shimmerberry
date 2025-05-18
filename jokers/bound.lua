SMODS.Joker{
	key = "bound",
	name = "SEMBY_bound", -- For lovely patching
    atlas = 'SEMBY_jokers',
    pos = { x = 1, y = 1 },
    rarity = 2,
    cost = 9,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = false,
    blueprint_compat = false,
	config = {
		extra = { slots = 4 }
	},
	loc_vars = function(self, info_queue, card)
        return {
            vars = {card.ability.extra.slots}
        }
    end,
    add_to_deck = function(self, card, from_debuff)
        if G.jokers then
			G.jokers.config.card_limit = G.jokers.config.card_limit + card.ability.extra.slots
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        if G.jokers then
            G.jokers.config.card_limit = G.jokers.config.card_limit - card.ability.extra.slots
        end
    end,
	calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint and not self.getting_sliced then
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				func = function()
					-- Animate Bound
					card:juice_up()
					play_sound('tarot1')
					if #G.jokers.cards > 0 then
						local local_jokers = G.jokers.cards
						for k, v in pairs(local_jokers) do
							if not v.debuff then
								-- Debuff (and Destroy) Joker
								v:set_debuff(true)
								if not v.ability.eternal then
									v:start_dissolve()
								end
								return true -- return fresh and early!
							end
						end
					end
					return true -- uNrEaChAbLe CoDe DeTeCtEd
				end
			}))
			delay(1.0)
			return
        end
	end
}
