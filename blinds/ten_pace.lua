local PACE_FROM = 0.8
local PACE_TO = 1.0
local PACE_ADD = 0.1
--local PACE_WEAK = 0.5
local blind = {
	key = "ten_pace",
	name = "SEMBY_ten_pace",
    vars = { 100 * PACE_FROM, 100 * PACE_TO, 100 * PACE_ADD },
    config = {
		extra = {
			from = PACE_FROM,
			to = PACE_TO,
			add = PACE_ADD,
			--weaken = PACE_WEAK,
			--initial = 100000.0 --fallback value
		}
	},
    boss = { showdown = true, min = 2, max = 10 },
    boss_colour = HEX("FFD61D"), -- softer yellow   prev: ffff00
    atlas = "critterblinds",
    pos = { x = 0, y = 2},
	dollars = 8
}

blind.loc_vars = function(self)
    return {
		vars = {
			100 * self.config.extra.from,
			100 * self.config.extra.to,
			100 * self.config.extra.add
		}
	}
end

blind.set_blind = function(self, reset, silent)
    if not G.GAME.blind.disabled then
        G.GAME.blind.backup_chips = G.GAME.blind.chips
		--self.config.extra.initial = G.GAME.blind.chips
    end
end

blind.press_play = function(self)
	G.GAME.blind.prepped = true
end

blind.drawn_to_hand = function(self)
    if G.GAME.blind.prepped then
		local ratio = G.GAME.chips / G.GAME.blind.chips
		-- talisman compat
		if type(ratio) == "table" then
			ratio = ratio:to_number()
		end
		if ratio > self.config.extra.from and ratio < self.config.extra.to then
			-- change score
			local increase = 1.0 + self.config.extra.add
			G.GAME.blind.chips = math.floor(G.GAME.blind.chips * increase);
			G.GAME.blind.triggered = true
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.5,
				func = function()
					G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
					G.GAME.blind:wiggle()
					return true
				end
			}))
			-- weaken effect (only once)
			--self.config.extra.add = self.config.extra.add * self.config.extra.weaken
			--self.config.extra.weaken = 1.0
		end
    end
end

blind.disable = function(self, silent)
    G.GAME.blind.chips = G.GAME.blind.backup_chips
	--G.GAME.blind.chips = self.config.extra.initial
    G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
    G.GAME.blind.backup_chips = nil
end

return blind
