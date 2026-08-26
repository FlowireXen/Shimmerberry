--## SEMBY Shop Functions

local cost_hook = Card.set_cost_value
function Card:set_cost_value()
	cost_hook(self)
	if G.GAME.SEMBY_Global_ShopMod then
	    self.cost = math.max(0, math.floor(self.cost * G.GAME.SEMBY_Global_ShopMod + 0.5))
	end
	if self.ability.SEMBY_price_mod then
	    self.cost = math.max(0, math.floor(self.cost + self.ability.SEMBY_price_mod))
	end
end

local sell_hook = Card.set_sell_value
function Card:set_sell_value()
	sell_hook(self)
	if self.ability.SEMBY_price_mod then
	    self.sell_cost = math.max(0, math.floor(self.sell_cost + (self.ability.SEMBY_price_mod/2)))
	end
end

-- Calculate Global:
function SEMBY_Global_ShopMod_Calculate(skip_apply)
	local modifier = false
	if G.GAME.SEMBY_Global_ShopMods then
		for key, amount in pairs(G.GAME.SEMBY_Global_ShopMods) do
			modifier = (modifier or 1.0) * amount
		end
	end
	G.GAME.SEMBY_Global_ShopMod = modifier
	if not skip_apply then
		for key, value in pairs(G.I.CARD) do
			if value.set_cost then value:set_cost() end
		end
	end
end
-- Add Global:
function SEMBY_Global_ShopMod_Add(key, amount, skip_apply)
	if key and amount then
		if not G.GAME.SEMBY_Global_ShopMods then G.GAME.SEMBY_Global_ShopMods = { } end
		G.GAME.SEMBY_Global_ShopMods[key] = (G.GAME.SEMBY_Global_ShopMods[key] or 1.0) + amount
		SEMBY_Global_ShopMod_Calculate(skip_apply)
	end
end
-- Set Global:
function SEMBY_Global_ShopMod_Set(key, value, skip_apply)
	if key then
		if not G.GAME.SEMBY_Global_ShopMods then G.GAME.SEMBY_Global_ShopMods = { } end
		G.GAME.SEMBY_Global_ShopMods[key] = value
		SEMBY_Global_ShopMod_Calculate(skip_apply)
	end
end
-- Remove Global:
function SEMBY_Global_ShopMod_Remove(key, amount, skip_apply)
	if key and G.GAME.SEMBY_Global_ShopMods then
		if amount and G.GAME.SEMBY_Global_ShopMods[key] then
			G.GAME.SEMBY_Global_ShopMods[key] = G.GAME.SEMBY_Global_ShopMods[key] - amount
			if G.GAME.SEMBY_Global_ShopMods[key] == 1.0 then
				G.GAME.SEMBY_Global_ShopMods[key] = nil
			end
		else G.GAME.SEMBY_Global_ShopMods[key] = nil end
		SEMBY_Global_ShopMod_Calculate(skip_apply)
	end
end
