local SEMBY_EGG_REWARD = 25
local function SetEggReward(amount)
    G.GAME.blind.dollars = math.max(0, amount)
    G.GAME.current_round.dollars_to_be_earned = '$'..G.GAME.blind.dollars
end
SMODS.Blind {
    key = "golden_egg",
	SEMBY_art = "flowire",
    atlas = "SEMBY_blinds",
    pos = { x = 0, y = 4},
    dollars = math.floor(SEMBY_EGG_REWARD/10+0.5),
    mult = 3,
    boss = { min = 3 },
    boss_colour = G.C.MONEY,
    set_blind = function(self) SetEggReward(SEMBY_EGG_REWARD) end,
    disable = function(self) SetEggReward(SEMBY_EGG_REWARD) end,
    calculate = function(self, blind, context)
        if context.individual and not blind.disabled and context.cardarea == G.play then
            local juice_card = context.other_card
            G.E_MANAGER:add_event(Event({
                func = function()
                    if G.GAME.blind.dollars ~= 0 then
			            attention_text({
			            	text = localize{ type = 'variable', key = 'SEMBY_money_minus', vars = { 1 } },
			            	backdrop_colour = G.C.MONEY,
			            	scale = 0.5, hold = 0.65, major = juice_card,
			            	align = 'tm', offset = { x = 0.74, y = 0.5 }
			            })
                        blind:wiggle()
				        blind.triggered = true --> Metador
                    end
                    SetEggReward(G.GAME.blind.dollars - 1)
                    return true
                end
            }))
		    return
        end
    end,
    loc_vars = function(self) --> Emulates "load = function([...])"
        if G.GAME.blind and G.GAME.blind.boss and G.GAME.blind.config.blind.key == "bl_SEMBY_golden_egg" then
            G.GAME.current_round.dollars_to_be_earned = '$'..G.GAME.blind.dollars
        end
    end,
    calc_dollar_bonus = function (self, blind)
        check_for_unlock({ type = 'SEMBY_check', hatched = (G.GAME.blind.dollars == 0) })
    end
}
