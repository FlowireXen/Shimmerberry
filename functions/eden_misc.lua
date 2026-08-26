--## SEMBY Eden Token Functions

-- Is Eden active this Run?
-- Block in Challenges, Allow in Seeded Runs
function SEMBY_Eden_Valid()
	return Shimmerberry.config.eden_enabled and not G.GAME.challenge
end
-- Get/Update Eden Config
function SEMBY_Eden_Token(amount)
	local profile = 'P'..G.SETTINGS.profile
	Shimmerberry.config.eden_tokens[profile] = SEMBY_tonum(Shimmerberry.config.eden_tokens[profile] or 0)
	if amount and amount ~= 0 then
		Shimmerberry.config.eden_tokens[profile] = Shimmerberry.config.eden_tokens[profile] + amount
	end
	return Shimmerberry.config.eden_tokens[profile]
end
-- Hook Win:
local win_hook = win_game
function win_game()
    if SEMBY_Eden_Valid() then
        SEMBY_Eden_Token(1 + math.max(G.GAME.SEMBY_eden_bonus or 0))
    end
	return win_hook()
end
