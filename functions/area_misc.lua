--## SEMBY Cardarea Misc. Functions

-- Area Block:
-- Hook to Make sure the Area is always full -> THANKS nh6574 <-
local count_ref = CardArea.count_property
function CardArea:count_property(property)
	local retVal = count_ref(self, property)
	if property == "extra_slots_used" and self.config.SEMBY_blocked and self.config.SEMBY_blocked ~= 0 then
		retVal = retVal + self.config.card_limits.total_slots
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

-- Area Overwrite-Text:
function CardArea:add_text_overwrite(id, loc_key)
	if not (self.config.SEMBY_overwrite and self.config.SEMBY_overwrite[1]) then
		self.config.SEMBY_overwrite = { }
	end
	self.config.SEMBY_overwrite[#self.config.SEMBY_overwrite+1] = {
		text = localize(loc_key),
		id = id
	}
	-- Force Redraw
	self.children.area_uibox = nil
end
function CardArea:remove_text_overwrite(id)
	if self.config.SEMBY_overwrite and self.config.SEMBY_overwrite[1] then
		for i = 1, #self.config.SEMBY_overwrite do
			if self.config.SEMBY_overwrite[i].id == id then
				table.remove(self.config.SEMBY_overwrite, i)
				break
			end
		end
		if #self.config.SEMBY_overwrite == 0 then
			self.config.SEMBY_overwrite = nil
		end
	end
	-- Force Redraw
	self.children.area_uibox = nil
end
