--## SEMBY Cardarea Misc. Functions

-- Area Block:
-- Hook to Make sure the Area is always full -> THANKS nh6574 <-
local count_ref = CardArea.count_property
function CardArea:count_property(property)
	local retVal = count_ref(self, property)
	if property == "extra_slots_used" and self.config.SEMBY_blocked and self.config.SEMBY_blocked ~= 0 then
		retVal = retVal + self.config.card_limits.total_slots * 2
	end
	return retVal
end
function CardArea:SEMBY_block()
	self.config.SEMBY_blocked = (self.config.SEMBY_blocked or 0) + 1
end
function CardArea:SEMBY_unblock()
	self.config.SEMBY_blocked = (self.config.SEMBY_blocked or 0) - 1
	if self.config.SEMBY_blocked <= 0 then
		self.config.SEMBY_blocked = nil
	end
end

-- Area Override-Text:
function CardArea:SEMBY_add_text_override(id, loc_key)
	if not (self.config.SEMBY_override and self.config.SEMBY_override[1]) then
		self.config.SEMBY_override = { }
	end
	self.config.SEMBY_override[#self.config.SEMBY_override+1] = {
		text = localize(loc_key),
		id = id
	}
	-- Force Redraw
	self.children.area_uibox = nil
end
function CardArea:SEMBY_remove_text_override(id)
	if self.config.SEMBY_override and self.config.SEMBY_override[1] then
		for i = 1, #self.config.SEMBY_override do
			if self.config.SEMBY_override[i].id == id then
				table.remove(self.config.SEMBY_override, i)
				break
			end
		end
		if #self.config.SEMBY_override == 0 then
			self.config.SEMBY_override = nil
		end
	end
	-- Force Redraw
	self.children.area_uibox = nil
end
