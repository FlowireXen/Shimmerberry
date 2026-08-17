--## Hide Winning Ante (Lovely-Patch):
-- @ lovely/mod_ante.toml
function SEMBY_Win_Ante_Hidden()
	return G.GAME.SEMBY_hide_win_ante
end

--## SEMBY Challange Changes
function SEMBY_Challenge_Start()
	-- Add "Shimmer-Immunity" to "Eternal"/"Possessive" Cards:
	G.E_MANAGER:add_event(Event({
		func = function()
			for _, area in ipairs(SMODS.get_card_areas('jokers')) do
				for _, card in ipairs(area.cards) do
					if SMODS.is_eternal(card)
					--or card.ability.SEMBY_possessive
					then card:add_sticker('SEMBY_shimmer_immune', true) end
				end
			end
			return true
		end
	}))
	-- Custom Bans for Vanilla Challenges
	if G.GAME.challenge == 'c_jokerless_1'
	then -- Remove Joker-Generator:
		G.GAME.banned_keys['c_SEMBY_soul_gem'] = true
		-- Useless
		G.GAME.banned_keys['c_SEMBY_order_shrine'] = true
		G.GAME.banned_keys['tag_SEMBY_edt_pearlescent'] = true
		G.GAME.banned_keys['tag_SEMBY_adt_duplitage'] = true
		-- Too Difficult
		G.GAME.banned_keys['bl_SEMBY_sharp_shooter'] = true
		return
	end
	if G.GAME.challenge == 'c_non_perishable_1'
	then -- Ban SEMBY-Jokers that aren't Eternal Compat.:
		for i = 1, #G.P_CENTER_POOLS.Joker do
			if G.P_CENTER_POOLS.Joker[i].mod
			and G.P_CENTER_POOLS.Joker[i].mod.id == 'SEMBY'
			and not G.P_CENTER_POOLS.Joker[i].eternal_compat
			then --print(G.P_CENTER_POOLS.Joker[i].key)
				G.GAME.banned_keys[G.P_CENTER_POOLS.Joker[i].key] = true
			end
		end
		return
	end
	if G.GAME.challenge == 'c_five_card_1'
	then -- Remove Hand-Size Changing *Jokers*:
		G.GAME.banned_keys['j_SEMBY_garden_gnome'] = true
		G.GAME.banned_keys['j_SEMBY_scaffolding'] = true
		G.GAME.banned_keys['j_SEMBY_stylish_joker'] = true
		G.GAME.banned_keys['j_SEMBY_the_dwarf'] = true
		G.GAME.banned_keys['j_SEMBY_the_giant'] = true
		-- I said *Jokers*, but...
		G.GAME.banned_keys['bl_SEMBY_frog'] = true
		G.GAME.banned_keys['v_SEMBY_mask_comedy'] = true
		G.GAME.banned_keys['v_SEMBY_mask_tragedy'] = true
		return
	end
	if G.GAME.challenge == 'c_fragile_1'
	then -- Remove Enhancements-Changes and Card-Generation:
		G.GAME.banned_keys['c_SEMBY_backup'] = true
		G.GAME.banned_keys['c_SEMBY_daybreak'] = true
		G.GAME.banned_keys['j_SEMBY_goobert'] = true
		G.GAME.banned_keys['j_SEMBY_hemoturgy'] = true
		G.GAME.banned_keys['c_SEMBY_microcosm'] = true
		G.GAME.banned_keys['j_SEMBY_mineshaft'] = true
		G.GAME.banned_keys['j_SEMBY_nostalgia'] = true
		-- Useless and not fun to find
		G.GAME.banned_keys['j_SEMBY_alpha'] = true
		G.GAME.banned_keys['j_SEMBY_anodized_steel'] = true
		G.GAME.banned_keys['j_SEMBY_doomsday_device'] = true
		G.GAME.banned_keys['j_SEMBY_fifty_seven_leaf_clover'] = true
		G.GAME.banned_keys['j_SEMBY_inventation'] = true
		G.GAME.banned_keys['j_SEMBY_reagent'] = true
		G.GAME.banned_keys['j_SEMBY_vip_ticket'] = true
		-- Overpowered
		G.GAME.banned_keys['j_SEMBY_benthic_bloom'] = true
		G.GAME.banned_keys['j_SEMBY_chrono_break'] = true
		G.GAME.banned_keys['j_SEMBY_singularity'] = true
		G.GAME.banned_keys['j_SEMBY_tempered_glass'] = true
		return
	end
	if G.GAME.challenge == 'c_blast_off_1'
	or G.GAME.challenge == 'c_golden_needle_1'
	then -- Remove Hand-Amount Changing Stuff:
		G.GAME.banned_keys['j_SEMBY_alpha'] = true
		G.GAME.banned_keys['j_SEMBY_eternal_fortune'] = true
		G.GAME.banned_keys['j_SEMBY_improv'] = true
		G.GAME.banned_keys['j_SEMBY_money_laundering'] = true
		G.GAME.banned_keys['j_SEMBY_ouroboros'] = true
		G.GAME.banned_keys['tag_SEMBY_bnt_hands'] = true
		-- Early Exit;
		if G.GAME.challenge == 'c_blast_off_1' then return end
	end
	if G.GAME.challenge == 'c_omelette_1'
	or G.GAME.challenge == 'c_rich_1'
	or G.GAME.challenge == 'c_inflation_1'
	or G.GAME.challenge == 'c_golden_needle_1'
	then -- Ban all kinds of Money Generation:
		G.GAME.banned_keys['c_SEMBY_ocean'] = true
		G.GAME.banned_keys['e_SEMBY_shiny'] = true
		G.GAME.banned_keys['j_SEMBY_adblocker'] = true
		G.GAME.banned_keys['j_SEMBY_berry_golden'] = true
		G.GAME.banned_keys['j_SEMBY_bunburrow'] = true
		G.GAME.banned_keys['j_SEMBY_fire_exint'] = true
		G.GAME.banned_keys['j_SEMBY_lavish_joker'] = true
		G.GAME.banned_keys['j_SEMBY_risky_joker'] = true
		G.GAME.banned_keys['j_SEMBY_silver_mask'] = true
		G.GAME.banned_keys['j_SEMBY_stylish_joker'] = true
		G.GAME.banned_keys['j_SEMBY_tool_pickaxe'] = true
		G.GAME.banned_keys['tag_SEMBY_edt_shiny'] = true
		-- Other Shop Modifier:
		G.GAME.banned_keys['j_SEMBY_coupon'] = true
		G.GAME.banned_keys['j_SEMBY_coupon_booklet'] = true
		G.GAME.banned_keys['tag_SEMBY_bnt_reroll'] = true
		G.GAME.banned_keys['tag_SEMBY_bnt_vouch_down'] = true
		return
	end
end

--## Custom Rules/Functions for MY Challenges (Lovely Patched):
-- @ lovely\mod_challenges.toml
function SEMBY_Challenge_WIN()
	G.E_MANAGER:add_event(Event({
		blocking = false,
		func = function()
			if G.STATE == G.STATES.BLIND_SELECT
			or G.STATE == G.STATES.ROUND_EVAL
			then
				if not G.GAME.won then
					G.GAME.won = true
					save_run()
					G.E_MANAGER:add_event(Event({
						trigger = 'after',
						delay = 0.2,
						blocking = false,
						func = function()
							win_game()
							return true
						end
					}))
				end
				return true
			end
			return false
		end
	}))
end
function SEMBY_Challenge_LOSE(forced)
	G.E_MANAGER:add_event(Event({
		blocking = false,
		func = function()
			if G.STATE == G.STATES.BLIND_SELECT
			or G.STATE == G.STATES.ROUND_EVAL
			or forced --> Might cause bugs!
			then
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.2,
					blocking = false,
					func = function()
						G.STATE = G.STATES.GAME_OVER
						G:save_settings()
						G.FILE_HANDLER.force = true
						G.STATE_COMPLETE = false
						return true
					end
				}))
				return true
			end
			return false
		end
	}))
end
