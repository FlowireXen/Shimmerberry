--## SEMBY Achievements

-- "golden_egg.lua": $0 Reward
SMODS.Achievement({
	key = 'SEMBY_hatched',
	bypass_all_unlocked = true,
	unlock_condition = function(self, args)
		return args and args.type == 'SEMBY_check' and args.hatched
	end
})

-- All Challenges Won?
local function SEMBY_Challenge_Achievement()
	if G.PROFILES and G.SETTINGS then
		local challenges = G.PROFILES[G.SETTINGS.profile].challenge_progress.completed
		if challenges and next(challenges) then
			local DONE = 0; local TOTAL = 21 --!! IMPORTANT !!--
			local pattern = 'c_SEMBY'
			for name, state in pairs(challenges) do
				if state and string.sub(name, 1, #pattern) == pattern then
					DONE = DONE + 1
				end
			end
			--print(DONE..'/'..TOTAL)
			return TOTAL <= DONE
		end
	end
	return false
end
SMODS.Achievement({
	key = 'SEMBY_all_challenge',
	bypass_all_unlocked = true,
	unlock_condition = function(self, args)
		return args and args.type == 'win_challenge' and SEMBY_Challenge_Achievement()
	end
})

-- "daybreak.lua": Rankless Cards
SMODS.Achievement({
	key = 'SEMBY_001',
	bypass_all_unlocked = true,
	unlock_condition = function(self, args)
		return args and args.type == 'SEMBY_check' and args.daybreak
	end
})
