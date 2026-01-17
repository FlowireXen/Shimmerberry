SMODS.Joker{
	key = "bound",
	name = "SEMBY_bound",
    atlas = 'SEMBY_jokers',
    pos = { x = 4, y = 3 },
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = false,
    blueprint_compat = false,
    rarity = 2,
    cost = 8,
	config = {
		card_limit = 4
	},
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
        return { vars = {
			card.ability.card_limit
		} }
    end,
	calculate = function(self, card, context)
		if context.setting_blind and not (self.getting_sliced or context.blueprint) then
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				func = function()
					card:juice_up(0.2, 0.1)
					play_sound('tarot1')
					if #G.jokers.cards > 0 then
						local local_jokers = G.jokers.cards
						for k, v in pairs(local_jokers) do
							if not v.debuff then
								v:set_debuff(true)
								if not SMODS.is_eternal(v, card) then
									v:start_dissolve()
								end
								break
							end
						end
					end
					return true
				end
			}))
			delay(1.0)
			return
        end
	end
}
