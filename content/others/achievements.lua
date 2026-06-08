--## SEMBY Achievements

-- "golden_egg.lua": $0 Reward
SMODS.Achievement({
	key = 'SEMBY_hatched',
	bypass_all_unlocked = true,
	unlock_condition = function(self, args)
		return args and args.type == 'SEMBY_hatched' and args.hatched
	end,
})
