--## SEMBY Cardarea Misc. Functions

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
