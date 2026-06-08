local SEED = 'TMTRAINER'

-- Blacklisted Jokers
function SEMBY_TMTR_Blacklisted(center_key)
    if center_key == 'j_chaos'
	or center_key == 'j_stencil'
    or center_key == 'j_riff_raff'
    or center_key == 'j_fortune_teller'
    then return true else return false end
end

-- TMTRAINER Change
function SEMBY_TMTR_Change(card)
    if card and G.jokers then
		if not SEMBY_TMTR_Blacklisted(card.config.center.key) then
    	    -- Flip
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.4,
				func = function()
					card:flip()
					play_sound('card1', math.random()*0.2 + 0.85, 0.5)
					return true
				end
			}))
    	    -- Main Effect(s):
			local changing_sources = {}
			for _, area in ipairs(SMODS.get_card_areas('jokers')) do
				for _, card in ipairs(area.cards) do
					if not card.debuff and card.ability
					and type(card.ability.extra or nil) == "table"
					and card.ability.extra.SEMBY_TMTR then
						changing_sources[#changing_sources+1] = {
							card = card,
							change = {
								type = card.ability.extra.SEMBY_TMTR,
								min = card.ability.extra.SEMBY_TMTR_MIN,
								max = card.ability.extra.SEMBY_TMTR_MAX
							}
						}
					end
				end
			end
			--if G.GAME.SEMBY_TMTRAINER_Challenge then
			--	changing_sources[#changing_sources+1] = { card = false, change = { type = "RNG", min = -1.0, max = 3.0 } }
			--end
			if SEMBY_TMTR_Main(card, changing_sources) then
    	    	-- Unique Effect(s):
				if card.ability and card.ability.extra
				and card.ability.extra.SEMBY_corrupt
				then card.ability.extra.SEMBY_corrupt = 1 end
			end
    	    -- Flip
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.4,
				func = function()
					card:flip()
					play_sound('card1', math.random()*0.2 + 1.05, 0.5)
					return true
				end
			}))
    	else-- Blacklisted:
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.4,
				blocking = false,
				func = function()
					play_sound('cancel', 1.0, 0.8)
					-- Un-Changed Card:
					card:juice_up(0.15)
					attention_text({
						text = localize('k_nope_ex'),
						backdrop_colour = G.C.SEMBY_TMTRAINER,
						scale = 0.8, hold = 1.2, major = card,
						align = 'cm', offset = { x = 0, y = 0 }
					})
					return true
				end
			}))
    	end
	end
end

-- change: .type, .min, .max
function SEMBY_TMTR_Get(change)
	local TYPE = (change or {}).type or false--"RNG+"
	local MIN = 1 - ((change or {}).min or 0.5)
	local MAX = (change or {}).max or 2.0
    local change_amount
	if TYPE == "RNG" then -- True Random
        change_amount = pseudorandom(SEED, MIN*100, MAX*100)/100
    elseif TYPE == "AoN" then -- "All or Nothing"
		change_amount = pseudorandom(SEED) > 0.5 and MAX or MIN
	else--if TYPE == "RNG+" -- Average Random
        change_amount = (pseudorandom(SEED, MIN*100, MAX*100)/100 + pseudorandom(SEED, MIN*100, MAX*100)/100) / 2
	end
	return round_number(change_amount, 2)
end

-- actual tmtrainer
function SEMBY_TMTR_Main(card, sources)
	local change_final = false
	if type((sources or nil)) == "table" and #sources ~= 0 then
		-- "Base"-Table:
		for id, prop in pairs(card.ability) do
			if type(prop) == "number" and prop ~= 0 and not (prop == 1 and (id == "x_mult" or id == "x_chips" or id == "h_x_chips")) then
				if not ( -- Blacklist:
					id == "SEMBY_tmtrainer_value"
					or string.lower(id) == "effect"
					or string.lower(id) == "order"
	                or string.lower(id) == "hands_played_at_create"
					or string.match(string.lower(id), 'limit')
					or string.match(string.lower(id), 'slot')
				) then
					for i = 1, #sources do
	                	local change_value = SEMBY_TMTR_Get(sources[i].change)
						card.ability[id] = card.ability[id] * change_value
						change_final = (change_final or 1.0) * change_value
						sources[i].final = (sources[i].final or 1.0) * change_value
					end
					card.ability[id] = round_number(card.ability[id], 2)
				end
			end
		end
		-- "Extra"-Table:
		if type((card.ability.extra or nil)) == "table" then
			for id, prop in pairs(card.ability.extra) do
				if type(prop) == "number" and prop ~= 0 then
					for i = 1, #sources do
	                	local change_value = SEMBY_TMTR_Get(sources[i].change)
						card.ability.extra[id] = card.ability.extra[id] * change_value
						change_final = (change_final or 1.0) * change_value
						sources[i].final = (sources[i].final or 1.0) * change_value
					end
					card.ability.extra[id] = round_number(card.ability.extra[id], 2)
	                if string.match(string.lower(id), 'ante') then
	                    card.ability.extra[id] = math.floor(card.ability.extra[id]+0.5)
	                end
				end
			end
		end
	end
	-- Animate:
	if change_final then
		-- Update Generic Value:
		local tmtr_val = card.ability.SEMBY_tmtrainer_value or 1.0
		if type(tmtr_val) == "number" and tmtr_val ~= 0 then
			card.ability.SEMBY_tmtrainer_value = round_number(tmtr_val * change_final, 3)
		else --> Override custom value
			card.ability.SEMBY_tmtrainer_value = round_number(change_final, 3)
		end
		-- Apply Sticker:
		G.E_MANAGER:add_event(Event({
			func = function()
				if not card.ability.SEMBY_tmtrainer_sticker then
					card:add_sticker('SEMBY_tmtrainer_sticker', true)
				end
				return true
			end
		}))
		-- Animate Sources:
		for i = 1, #sources do
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.4,
				func = function()
					play_sound('generic1', 1.0, 0.8)
					-- Source Card:
					if sources[i].card then
						sources[i].card:juice_up(0.15)
						attention_text({
							text = localize('SEMBY_TMTRAINER_Y'..math.random(1, 3)),
							backdrop_colour = G.C.SEMBY_TMTRAINER,
							scale = 0.8, hold = 0.8, major = sources[i].card,
							align = 'bm', offset = { x = 0, y = 0 }
						})
					end
					-- Change Card:
					card:juice_up(0.3)
					attention_text({
						text = 'x'..(
							sources[i].final >= 1000 and math.floor(sources[i].final)
							or string.format("%.2f", round_number(sources[i].final, 2))
						), backdrop_colour = G.C.SEMBY_TMTRAINER,
						scale = 1.2, hold = 0.5, major = card,
						align = 'cm', offset = { x = 0, y = 0 }
					})
					return true
				end
			}))
		end
		return true
	else-- Nothing Changed :(
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			delay = 0.4,
			func = function()
				play_sound('generic1', 1.0, 0.8)
				-- Change Card:
				card:juice_up(0.15)
				attention_text({
					text = localize('SEMBY_TMTRAINER_N'..math.random(1, 3)),
					backdrop_colour = G.C.SEMBY_TMTRAINER,
					scale = 0.8, hold = 1.0, major = card,
					align = 'cm', offset = { x = 0, y = 0 }
				})
				return true
			end
		}))
		delay(0.2)
		return false
	end
end

-- Toggle TMTRAINER State
function SEMBY_TMTR_State(toggle)
	if toggle then G.GAME.SEMBY_TMTRAINER = (G.GAME.SEMBY_TMTRAINER or 0) + 1
	else G.GAME.SEMBY_TMTRAINER = (G.GAME.SEMBY_TMTRAINER or 0) - 1 end
	if G.GAME.SEMBY_TMTRAINER <= 0 then G.GAME.SEMBY_TMTRAINER = nil end
end
