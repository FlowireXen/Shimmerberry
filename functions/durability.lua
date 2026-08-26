--## SEMBY Durability System

function Card:SEMBY_has_durability()
	if self.ability then
		if self.ability.SEMBY_durability then return true end
		if type((self.ability.extra or nil)) == "table"
		and type((self.ability.extra.durability or nil)) == "number"
		then self.ability.SEMBY_durability = true; return true; end
	end
	return false
end

function Card:SEMBY_durability_use(amount)
	if self:SEMBY_has_durability() then
		self.ability.extra.durability = self.ability.extra.durability - (amount or 1)
		if self.ability.extra.durability < 0 then return false end
	end
	return true
end

function Card:SEMBY_durability_check()
	if self:SEMBY_has_durability() then
		if self.ability.extra.durability <= 0 then
			G.E_MANAGER:add_event(Event({
				func = function()
					self:juice_up()
					play_sound('tarot1')
					self.getting_sliced = true
					self:start_dissolve()
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
				vars = { self:SEMBY_durability_amount() }
			}, colour = self:SEMBY_durability_color()
		})
		return true
	end
	card_eval_status_text(self, 'extra', nil, nil, nil, { message = 'INVALID', colour = HEX('FF00FF') })
	return true
end

function Card:SEMBY_durability_amount()
	return self:SEMBY_has_durability() and format_ui_value(self.ability.extra.durability) or 'INVALID'
end

function Card:SEMBY_durability_color(validated)
	if validated or self:SEMBY_has_durability() then
		if type((self.ability.extra.durability_max or nil)) == "number" then
			if self.ability.extra.durability > math.floor(self.ability.extra.durability_max * 0.5 + 0.5) then return G.C.GREEN end
			if self.ability.extra.durability > math.max(1, self.ability.extra.durability_max * 0.1) then return G.C.ORANGE end
			return G.C.RED
		end
		return G.C.GREEN
	end
	return HEX('FF00FF')
end
