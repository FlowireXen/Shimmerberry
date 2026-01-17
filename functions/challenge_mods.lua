--## Hide Winning Ante (Lovely-Patch):
-- @ lovely/mod_ante.toml
function SEMBY_Hide_Win_Ante()
	return G.GAME.SEMBY_hide_win_ante
end

--## Generic Challenge Modifiers
function SEMBY_Challenge_Generic()
	-- "Order"-Immunity for Eternal Jokers
	G.E_MANAGER:add_event(Event({
		func = function()
			if G.jokers and G.jokers.cards and #G.jokers.cards > 0 then
				for i = 1, #G.jokers.cards do
					if SMODS.is_eternal(G.jokers.cards[i], 'OrderImmunity')
					or G.jokers.cards[i].ability.SEMBY_possessive
					then G.jokers.cards[i].ability.SEMBY_OI = true end
				end
			end
			return true
		end
	}))
	-- Bans, Break Progression:
	G.GAME.banned_keys['j_SEMBY_cockroach'] = true
	G.GAME.banned_keys['j_SEMBY_emergency_button'] = true
	--G.GAME.banned_keys['j_SEMBY_quest'] = true
	-- Bans, Overpowered:
	G.GAME.banned_keys['j_SEMBY_lavish_joker'] = true
	G.GAME.banned_keys['j_SEMBY_singularity'] = true
	G.GAME.banned_keys['j_SEMBY_oblivion'] = true
	--G.GAME.banned_keys['j_SEMBY_copy_printer'] = true
end

--## Custom Bans for Vanilla Challenges
function SEMBY_Challenge_Vanilla()
	if G.GAME.challenge == 'c_jokerless_1'
	then -- Remove Joker-Generator:
		G.GAME.banned_keys['c_SEMBY_soul_gem'] = true
		-- Useless
		G.GAME.banned_keys['c_SEMBY_ocean'] = true
		G.GAME.banned_keys['c_SEMBY_order_shrine'] = true
		G.GAME.banned_keys['tag_SEMBY_pearlescent_skip'] = true
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
			then
				--print(G.P_CENTER_POOLS.Joker[i].key)
				G.GAME.banned_keys[G.P_CENTER_POOLS.Joker[i].key] = true
			end
		end
		-- Too OP
		G.GAME.banned_keys['j_SEMBY_bound'] = true
		--G.GAME.banned_keys['c_SEMBY_order_shrine'] = true
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
		G.GAME.banned_keys['j_SEMBY_goobert'] = true
		G.GAME.banned_keys['j_SEMBY_hemoturgy'] = true
		G.GAME.banned_keys['j_SEMBY_mineshaft'] = true
		-- Useless and not fun to find
		G.GAME.banned_keys['j_SEMBY_alpha'] = true
		G.GAME.banned_keys['j_SEMBY_anodized_steel'] = true
		G.GAME.banned_keys['j_SEMBY_fifty_seven_leaf_clover'] = true
		G.GAME.banned_keys['j_SEMBY_reagent'] = true
		-- OP, but get to Stay
		--G.GAME.banned_keys['j_SEMBY_chrono_break'] = true
		--G.GAME.banned_keys['j_SEMBY_tempered_glass'] = true
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
		-- Early Exit;
		if G.GAME.challenge == 'c_blast_off_1' then return end
	end
	if G.GAME.challenge == 'c_omelette_1'
	or G.GAME.challenge == 'c_rich_1'
	or G.GAME.challenge == 'c_inflation_1'
	or G.GAME.challenge == 'c_golden_needle_1'
	then -- Ban all kinds of Money Generation:
		G.GAME.SEMBY_ceased_money = true --> "j_SEMBY_ceaseless_void"
		G.GAME.banned_keys['c_SEMBY_ocean'] = true
		G.GAME.banned_keys['e_SEMBY_shiny'] = true
		G.GAME.banned_keys['j_SEMBY_adblocker'] = true
		G.GAME.banned_keys['j_SEMBY_berry_golden'] = true
		--G.GAME.banned_keys['j_SEMBY_piggy_bank'] = true
		G.GAME.banned_keys['j_SEMBY_risky_joker'] = true
		G.GAME.banned_keys['j_SEMBY_silver_mask'] = true
		G.GAME.banned_keys['j_SEMBY_stylish_joker'] = true
		G.GAME.banned_keys['j_SEMBY_tool_pickaxe'] = true
		G.GAME.banned_keys['tag_SEMBY_shiny_skip'] = true
		G.GAME.banned_keys['tag_SEMBY_vouch_down'] = true
		-- Other Shop Modifier:
		--G.GAME.banned_keys['j_SEMBY_coupon'] = true
		G.GAME.banned_keys['j_SEMBY_coupon_booklet'] = true
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
							--G.GAME.won = true
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
function SEMBY_Challenge_LOSE()
	G.E_MANAGER:add_event(Event({
		blocking = false,
		func = function()
			if G.STATE == G.STATES.BLIND_SELECT
			or G.STATE == G.STATES.ROUND_EVAL
			then
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.2,
					blocking = false,
					func = function()
						G.STATE = G.STATES.GAME_OVER
						--if not G.GAME.won and not G.GAME.seeded and not G.GAME.challenge then
						--	G.PROFILES[G.SETTINGS.profile].high_scores.current_streak.amt = 0
						--end
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
-- Triggers at the End of each Blind
function SEMBY_Challenge_Blind_Defeated()
	if G.GAME.SEMBY_eleminate_until then
		if #G.playing_cards <= G.GAME.SEMBY_eleminate_until then
			SEMBY_Challenge_WIN()
		end
	end
	if G.GAME.SEMBY_survive_until then
		if #G.playing_cards <= G.GAME.SEMBY_survive_until then
			SEMBY_Challenge_LOSE()
		end
	end
	if G.GAME.SEMBY_countdown_mode then
		G.GAME.round_resets.hands = G.GAME.starting_params.hands - (G.GAME.hands_played or 0)
		--ease_hands_played(0)
		if G.GAME.unused_discards > 0 then
			G.GAME.round_resets.discards = G.GAME.round_resets.discards - (G.GAME.round_resets.discards - (G.GAME.unused_discards or 0))
			G.GAME.unused_discards = 0
			--ease_discard(0)
		end
	end
	if G.GAME.SEMBY_chaos_mode then
		G.GAME.SEMBY_blind_mod = (G.GAME.SEMBY_blind_mod or 1.0) + (math.random(-8, 12) / 100)
		for i = #G.playing_cards, 1, -1 do
			assert(SMODS.change_base(
				G.playing_cards[i],
				pseudorandom_element(SMODS.Suits).key,
				pseudorandom_element(SMODS.Ranks).key
			))
		end
	end
	if G.GAME.SEMBY_unicorn_mode then
		if G.jokers and not G.GAME.won then
			local gone = true
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i].config.center_key == 'j_SEMBY_unicorn' then
					gone = false
					break
				end
			end
			if gone and G.GAME.round ~= 0 then
				SEMBY_Challenge_WIN()
			end
		end
	end
	if G.GAME.SEMBY_money_fuel_mode then
		if G.GAME.dollars <= 0 then
			SEMBY_Challenge_LOSE()
		end
	end
	if G.GAME.SEMBY_menagerie_mode then
		G.E_MANAGER:add_event(Event({
			func = function()
				G.GAME.starting_params.ante_scaling = math.max(1, G.GAME.round_resets.ante)
				return true
			end
		}))
	end
end
-- Sets Durability for all Jokers
function SEMBY_Challenge_Durability(amount)
	G.E_MANAGER:add_event(Event({
		func = function()
			for index, joker in pairs(G.jokers.cards) do
				if joker.ability.extra and type(joker.ability.extra) == "table" and joker.ability.extra.SEMBY_Durability then
					joker.ability.extra.SEMBY_Durability.max_durability = (amount or 100)
					joker.ability.extra.SEMBY_Durability.durability = (amount or 100)
				end
			end
			return true
		end
	}))
end
