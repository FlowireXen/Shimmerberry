--## SEMBY Durability System

function Card:durability_use(amount)
	if self.ability and self.ability.extra and self.ability.extra.SEMBY_Durability then
		self.ability.extra.SEMBY_Durability.durability = (self.ability.extra.SEMBY_Durability.durability or 100.0) - (amount or 1)
		if self.ability.extra.SEMBY_Durability.durability < 0 then return false end
	end
	return true
end

function Card:durability_check()
	if self.ability and self.ability.extra and self.ability.extra.SEMBY_Durability
	and self.ability.extra.SEMBY_Durability.durability
	and self.ability.extra.SEMBY_Durability.durability <= 0
	then
		G.E_MANAGER:add_event(Event({
			func = function()
				self:juice_up()
				play_sound('tarot1')
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.3,
					func = function()
						self.getting_sliced = true
						self:start_dissolve()
						return true
					end
				}))
				return true
			end
		}))
		card_eval_status_text(self, 'extra', nil, nil, nil, {
			message = localize('SEMBY_durability_destroy'),
			colour = G.C.RED
		})
		return false
	end
	card_eval_status_text(self, 'extra', nil, nil, nil, {
		message = localize{
			type = 'variable',
			key = 'SEMBY_durability_uses_eval',
			vars = {
				self:durability_amount()
			}
		},
		colour = self:durability_color()
	})
	return true
end

function Card:durability_amount()
	if self.ability and self.ability.extra and self.ability.extra.SEMBY_Durability then
		return format_ui_value((self.ability.extra.SEMBY_Durability.durability or 100.0))
	end
	return format_ui_value(100.0)
end

function Card:durability_color()
	if self.ability and self.ability.extra
	and self.ability.extra.SEMBY_Durability
	and self.ability.extra.SEMBY_Durability.durability
	and self.ability.extra.SEMBY_Durability.max_durability
	then
		if self.ability.extra.SEMBY_Durability.durability > (self.ability.extra.SEMBY_Durability.max_durability * 0.5) then return G.C.GREEN
		elseif self.ability.extra.SEMBY_Durability.durability > (self.ability.extra.SEMBY_Durability.max_durability * 0.1) then return G.C.ORANGE
		else return G.C.RED end
	end
	return G.C.GREEN
end
