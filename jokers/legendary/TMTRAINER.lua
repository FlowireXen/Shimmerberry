SMODS.Joker {
	key = "TMTRAINER",
	name = "SEMBY_TMTRAINER",
	atlas = "SEMBY_jokers",
	pos = { x = 1, y = 10 },
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = false,
    blueprint_compat = true,
	rarity = 3,
	cost = 9,
	config = {
		extra = {
			rng_min = 0.5,
			rng_max = 0.7,
			-- Special
			corrupt = false,
			corrupt_overwrite = { x = 1, y = 11 }
		},
		card_limit = 1
	},
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
		local min = math.floor((card.ability.extra.rng_min * card.ability.extra.rng_max) * 100 + 0.5)
		local max = math.floor(((1.0+card.ability.extra.rng_min) * (1.0+card.ability.extra.rng_max)) * 100 + 0.5)
		return { vars = {
			min,
			max,
			--card.ability.card_limit
		} }
	end,
	load = function(self, card, card_table, other_card)
		G.E_MANAGER:add_event(Event({
			func = function()
				if card.ability.extra.corrupt then
					card.children.center:set_sprite_pos(card.ability.extra.corrupt_overwrite)
				end
				return true
			end
		}))
	end,
    add_to_deck = function(self, card, from_debuff)
		if card.ability.extra.corrupt and not from_debuff then
			card.children.center:set_sprite_pos(card.ability.extra.corrupt_overwrite)
		end
    end,
	calculate = function(self, card, context)
		if context.card_added and context.card.ability.set == "Joker" then
			local juice_card = (context.blueprint_card or card) --> Juice-Up doesn't work in Events without this
			-- Q: Why not check for "blueprint_compat"?
			-- A: I like to break expectations :>
			--print("TMTRAINER:")
			-- START: BLACKLIST
			-- Visual Stupidity
			if context.card.config.center.key == 'j_chaos'
			or context.card.config.center.key == 'j_riff_raff'
			or context.card.config.center.key == 'j_fortune_teller'
			-- Truly Gamebreaking
			or context.card.config.center.key == 'j_credit_card'
			then
				--print("Blacklisted")
				G.E_MANAGER:add_event(Event({ trigger = 'after', func = function() juice_card:juice_up(0.1) return true end }))
				return {
					message = localize('SEMBY_TMTRAINER_BL'),
					colour = HEX('000000'),
					message_card = context.card
				}
			end
			-- END: BLACKLIST
			-- START: SPECIAL PROPERTY
			if context.card.config.center.key == 'j_SEMBY_TMTRAINER'
			then
				context.card.ability.extra.corrupt = true
				context.card.children.center:set_sprite_pos(context.card.ability.extra.corrupt_overwrite)
			end
			-- END: SPECIAL PROPERTY
			-- START: BASE ABILITY
			local Changed = false
			--print("context.card.ability:")
			for id, prop in pairs(context.card.ability) do
				if type(prop) == "number" and not (prop == 0) then
					if not (prop == 1 and (
						id == "x_mult" or id == "x_chips"
						or id == "h_x_chips"
					)) then
						if not (
							-- Blacklist
							id == "extra" or id == "effect"
							or id == "order" or id == "hands_played_at_create"
							or id == "SEMBY_tmtrainer_value"
							-- Generic
							or string.match(string.lower(id), 'size')
							or string.match(string.lower(id), 'slot')
							or string.match(string.lower(id), 'limit')
							-- Modded
							or string.match(string.lower(id), 'inflation')
							or string.match(string.lower(id), 'state')
						) then
							local rng_mult = pseudorandom(id)
							rng_mult = (rng_mult + card.ability.extra.rng_min) * (rng_mult + card.ability.extra.rng_max)
							context.card.ability[id] = round_number(context.card.ability[id] * rng_mult, 2)
							--print(id, context.card.ability[id])
							Changed = (Changed or 1.0) * rng_mult
						end
					end
				end
			end
			-- END: BASE ABILITY
			-- START: EXTRA ABILITY
			if context.card.ability.extra then
				if type(context.card.ability.extra) == "table" then
					--print("context.card.ability.extra[table]:")
					for id, prop in pairs(context.card.ability.extra) do
						if type(prop) == "number" and not (prop == 0) then
							if not (
								-- Blacklist
								string.lower(id) == "ante_mod"
								-- Generic
								or string.match(string.lower(id), 'size')
								or string.match(string.lower(id), 'slot')
								or string.match(string.lower(id), 'limit')
								-- Modded
								or string.match(string.lower(id), 'inflation')
								or string.match(string.lower(id), 'state')
							) then
								local rng_mult = pseudorandom(id)
								rng_mult = (rng_mult + card.ability.extra.rng_min) * (rng_mult + card.ability.extra.rng_max)
								context.card.ability.extra[id] = round_number(context.card.ability.extra[id] * rng_mult, 2)
								--print(id, context.card.ability.extra[id])
								Changed = (Changed or 1.0) * rng_mult
							end
						end
					end
				elseif type(context.card.ability.extra) == "number" then
					--print("context.card.ability.extra:")
					local rng_mult = pseudorandom("TMTRAINER")
					rng_mult = (rng_mult + card.ability.extra.rng_min) * (rng_mult + card.ability.extra.rng_max)
					context.card.ability.extra = round_number(context.card.ability.extra * rng_mult, 2)
					--print(context.card.ability.extra)
					Changed = (Changed or 1.0) * rng_mult
				end
			end
			-- END: EXTRA ABILITY
			-- START: VISUAL (+SUB STICKER/INFO)
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.4, --> Time to Settle
				func = function()
					context.card:flip()
					juice_card:juice_up(0.1)
					play_sound('card1', math.random()*0.2 + 0.85, 0.5)
					return true
				end
			}))
			if Changed then
				context.card.ability.SEMBY_tmtrainer_value = round_number((context.card.ability.SEMBY_tmtrainer_value or 1.0) * Changed, 2)
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.4,
					func = function()
						if not context.card.ability.SEMBY_tmtrainer_sticker then
							context.card:add_sticker('SEMBY_tmtrainer_sticker', true)
						end
						context.card:juice_up(0.3)
						juice_card:juice_up(0.2)
						play_sound('generic1', 1.0, 0.8)
						-- Show a Green Splash:
						attention_text({
							--text = number_format(context.card.ability.SEMBY_tmtrainer_value),
							text = 'x'..number_format(round_number(Changed, 2)),
							backdrop_colour = HEX('119933'),
							scale = 1.2, hold = 1.2, major = context.card,
							align = 'cm', offset = { x = 0, y = 0 }
						})
						return true
					end
				}))
			else delay(0.2) end
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.4,
				func = function()
					context.card:flip()
					--juice_card:juice_up(0.1)
					play_sound('card1', math.random()*0.2 + 1.05, 0.5)
					return true
				end
			}))
			-- END: VISUAL (+SUB STICKER/INFO)
			-- START: RETURN
			--print("Done!")
			G.E_MANAGER:add_event(Event({ trigger = 'after', func = function() juice_card:juice_up(0.1) return true end }))
			return {
				message = localize('SEMBY_TMTRAINER_'..(Changed and 'Y' or 'N')..math.random(1, 4)),
				colour = HEX('119933'),
				message_card = context.card
			}
			-- END: RETURN
		end
	end
}
