-- Other Durabilities:
local SEMBY_durable_jokers = {
	["j_selzer"]      = { edit_key = "extra",  durability_max = 10, durability_other = { direct = true, refill = true } },
	["j_popcorn"]     = { edit_key = "mult",   durability_max = 20, durability_other = { direct = true, refill = true } },
	["j_ice_cream"]   = { edit_key = "chips",  durability_max = 100 },
	--["j_turtle_bean"] = { edit_key = "h_size", durability_max = 5   },
}
local Semby_durable_abilities = {
	["perishable"]      = { edit_key = "perish_tally",          durability_max = 5 },
	["SEMBY_degrading"] = { edit_key = "SEMBY_degrading_tally", durability_max = 5 },
}
-- Joker Code
SMODS.Joker {
	key = "toolkit",
	SEMBY_art = "unkokat",
	atlas = "SEMBY_jokers_1",
	pos = { x = 5, y = 1 },
    eternal_compat = false,
    perishable_compat = false,
    blueprint_compat = true,
	rarity = 1,
	cost = 4,
	config = {
		extra = {
			-- Durability
			durability = 200,
			durability_max = 200,
			durability_other = { no_repair = true },
			-- Joker
			repair_mod = 5,
		}
	},
    attributes = {
		'joker',
		'durability'
	},
	pools = {
        ["Durability"] = true,
    },
	loc_vars = function(self, info_queue, card)
		return { vars = {
			card.ability.extra.repair_mod,
			card:SEMBY_durability_amount(),
			colours = { card:SEMBY_durability_color() }
		} }
	end,
	calculate = function(self, card, context)
		if context.end_of_round and context.main_eval and not context.game_over then
			for _, joker in pairs(G.jokers.cards) do
				if joker == card then break end
				if not (joker.debuff or joker.getting_sliced) then
					-- Max Amount for Repair
					local repair_max = context.blueprint and card.ability.extra.repair_mod
									   or math.min(card.ability.extra.repair_mod, card.ability.extra.durability)
					if repair_max ~= 0 then
						-- Vars.
						local repair_gain = 0
						local repair_type = "repaired" -- repaired, refilled
						-- Normal Behaviour
						if joker:SEMBY_has_durability() then
							-- Check Properties
							if type((joker.ability.extra.durability_other or nil)) == "table" then
								if joker.ability.extra.durability_other.no_repair then goto no_repair; end
								if joker.ability.extra.durability_other.refill then repair_type = "refilled"; end
							end
							-- Maximum Repair
							if type((joker.ability.extra.durability_max or nil)) == "number" then
								repair_gain = math.max(0, math.min(repair_max, joker.ability.extra.durability_max - joker.ability.extra.durability))
							else repair_gain = repair_max end
							-- Repair Joker
							joker.ability.extra.durability = joker.ability.extra.durability + repair_gain
						-- Support Behaviour
						elseif SEMBY_durable_jokers[joker.config.center.key] then
							local edit_path = SEMBY_durable_jokers[joker.config.center.key].edit_key
							local edit_direct = false
							-- Check Properties
							if type((SEMBY_durable_jokers[joker.config.center.key].durability_other or nil)) == "table" then
								if SEMBY_durable_jokers[joker.config.center.key].durability_other.direct then edit_direct = true; end
								if SEMBY_durable_jokers[joker.config.center.key].durability_other.refill then repair_type = "refilled"; end
							end
							-- Maximum Repair & Repair Joker
							if edit_direct then
								repair_gain = math.max(0, math.min(repair_max, SEMBY_durable_jokers[joker.config.center.key].durability_max - joker.ability[edit_path]))
								joker.ability[edit_path] = joker.ability[edit_path] + repair_gain
							else
								repair_gain = math.max(0, math.min(repair_max, SEMBY_durable_jokers[joker.config.center.key].durability_max - joker.ability.extra[edit_path]))
								joker.ability.extra[edit_path] = joker.ability.extra[edit_path] + repair_gain
							end
						end
						-- Normal Feedback
						if repair_gain and repair_gain > 0 then
							-- Damage Toolkit
							if not context.blueprint then card.ability.extra.durability = card.ability.extra.durability - repair_gain; end
							-- Animate + Feedback
							local juice_card = (context.blueprint_card or card)
							G.E_MANAGER:add_event(Event({ func = function() juice_card:juice_up(); return true; end }))
							card_eval_status_text(joker, 'extra', nil, nil, nil, {
								message = localize { type = 'variable', key = 'SEMBY_durability_'..repair_type, vars = { repair_gain } },
								colour = G.C.GREEN
							})
						end
						-- Ability Behaviour
						repair_type = "repaired"
						for key, ability in pairs(Semby_durable_abilities) do
							if joker.ability[key] and joker.ability[ability.edit_key] then
								-- Maximum Repair & Repair Joker
								repair_max = context.blueprint and card.ability.extra.repair_mod
											 or math.min(card.ability.extra.repair_mod, card.ability.extra.durability)
								if repair_max ~= 0 then
									repair_gain = math.max(0, math.min(repair_max, ability.durability_max - joker.ability[ability.edit_key]))
									joker.ability[ability.edit_key] = joker.ability[ability.edit_key] + repair_gain
									-- Ability Feedback
									if repair_gain and repair_gain > 0 then
										-- Damage Toolkit
										if not context.blueprint then card.ability.extra.durability = card.ability.extra.durability - repair_gain; end
										-- Animate + Feedback
										local juice_card = (context.blueprint_card or card)
										G.E_MANAGER:add_event(Event({ func = function() juice_card:juice_up(); return true; end }))
										card_eval_status_text(joker, 'extra', nil, nil, nil, {
											message = localize { type = 'variable', key = 'SEMBY_durability_'..repair_type, vars = { repair_gain } },
											colour = G.C.GREEN
										})
									end
								end
							end
						end
					end
				end
				::no_repair::
			end
			if not context.blueprint then
				card:SEMBY_durability_check()
			end
			return nil, true
		end
	end,
    in_pool = function(self, args)
		if G.jokers then
			for _, joker in pairs(G.jokers.cards) do
				if (joker.config.center.pools and joker.config.center.pools.Durability)
				or joker.ability.perishable or joker.ability.SEMBY_degrading
				then return true end
			end
		end
        return false
    end
}
