SMODS.Joker {
	key = "jokebra",
	name = "SEMBY_jokebra",
	atlas = "SEMBY_jokers",
	pos = { x = 1, y = 2 },
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = false,
	rarity = 2,
	cost = 8,
	config = {
		extra = {
			active = false,
			failed = false,
			range_min = 100,
			range_max = 1100,
			target = 0
		}
	},
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
		info_queue[#info_queue + 1] = { key = "inspired_buffoonery", set = "Other" }
		if card.ability.extra.active then
			return {
				key = 'j_SEMBY_jokebra_active',
				vars = { number_format(card.ability.extra.target) }
			}
		elseif card.ability.extra.failed then
			return {
				key = 'j_SEMBY_jokebra_failed',
				vars = { number_format(card.ability.extra.target) }
			}
		else
			return { vars = {
				card.ability.extra.range_min,
				card.ability.extra.range_max
			} }
		end
	end,
	load = function(self, card, card_table, other_card)
		G.E_MANAGER:add_event(Event({
			func = function()
				if card.ability.extra.active then
					SEMBY_jokebra_infobox(card)
				end
				return true
			end
		}))
	end,
    add_to_deck = function(self, card, from_debuff)
		if card.ability.extra.target ~= 0 and not card.ability.extra.failed then
			if G.GAME.chips <= card.ability.extra.target then
				card.ability.extra.active = true
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					func = function()
						-- Effects
						card:juice_up(0.2, (math.random() < 0.5) and 0.2 or -0.2)
						play_sound('generic1')
						-- Infobox Below Joker:
						SEMBY_jokebra_infobox(card)
						return true
					end
				}))
			else card.ability.extra.failed = true end
		end
    end,
    remove_from_deck = function(self, card, from_debuff)
		card.ability.extra.active = false
    end,
	calculate = function(self, card, context)
		if not context.blueprint then
			if context.setting_blind and not self.getting_sliced then
				-- Select Target
				local range_max = card.ability.extra.range_max > G.GAME.blind.chips and not (G.GAME.blind.chips ~= G.GAME.blind.chips) and G.GAME.blind.chips
								  or card.ability.extra.range_max
				card.ability.extra.target = math.floor(pseudorandom('SEMBY_jokebra_'..card.sort_id, card.ability.extra.range_min, range_max))
				card.ability.extra.active = true
				-- Finish:
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					func = function()
						-- Effects
						card:juice_up(0.2, (math.random() < 0.5) and 0.2 or -0.2)
						play_sound('generic1')
						-- Infobox Below Joker:
						SEMBY_jokebra_infobox(card)
						return true
					end
				}))
				delay(0.4)
				return nil, false
			end
			if context.after and context.cardarea == G.jokers and card.ability.extra.active then
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					func = function()
						if math.floor(G.GAME.chips) == card.ability.extra.target then
							card.ability.extra.active = false
							-- Pull Blind-Size down ("end_round()" not needed!)
							G.GAME.blind.chips = math.floor(G.GAME.chips)
							G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
							SEMBY_Blind_Wiggle()
							-- Return
							card_eval_status_text(card, 'extra', nil, nil, nil, {
								message = localize('SEMBY_perfect_ex'),
								colour = G.C.GREEN
							})
						elseif G.GAME.chips > card.ability.extra.target then
							card.ability.extra.active = false
							-- Normal Check (Overshot but beat Blind)
							if G.GAME.chips < G.GAME.blind.chips
							-- Are you valid? ("NaN"-Check)
							or G.GAME.blind.chips ~= G.GAME.blind.chips
							-- Okay... Are you infinite?
							-- or G.GAME.blind.chips == math.huge
							-- or G.GAME.blind.chips == -math.huge
							then
								-- Failed...
								card.ability.extra.failed = true
								-- Return
								card_eval_status_text(card, 'extra', nil, nil, nil, {
									message = localize('SEMBY_failed_ex'),
									colour = G.C.RED
								})
							end
						end
						return true
					end
				}))
				return nil, false
			end
			if context.end_of_round and context.main_eval and context.game_over == false then
				card.ability.extra.target = 0
				card.ability.extra.active = false
				if card.ability.extra.failed then
					card.ability.extra.failed = false
					return { message = localize('k_reset') }
				end
			end
		end
    end
}

-- The "local infobox [...]" was initially a Variable in "card.ability.extra"
-- But when you copy a card with an UIBox-Container in it, the Game Hard-Crashes.
function SEMBY_jokebra_infobox(card)
	-- CREATE:
	local infobox = UIBox{
		T = { 0, 0, 0, 0 },
		definition = { n = G.UIT.ROOT, config = {
			align = 'bm', minw = 1.2, padding = 0.1, r = 0.1,
			emboss = 0.05, colour = lighten(G.C.BLACK, 0.1) },
			nodes = {{ n=G.UIT.O, config = {
				draw_layer = 1,
				object = DynaText({
					scale = 0.7,
					string = number_format(card.ability.extra.target),
					colours = { G.C.BLUE },
					shadow = true
				})
			}},
		}},
		config = {
			align = 'bm',
			offset = { x = 0, y = 0.05 },
			major = card
		}
	}
	-- Show Text above (other) cards:
	infobox.attention_text = true
	-- Disable all Interactions:
	infobox.states.collide.can = false
	infobox.states.drag.can = false
	infobox.states.focus.can = false
	infobox.states.hover.can = false
	-- Setup, DESTROY:
	G.E_MANAGER:add_event(Event({
		blocking = false,
		blockable = false,
		func = function()
			if not card.ability.extra.active then
				if infobox["remove"] then
					infobox:remove()
				end
				return true
			end
			return false
		end
	}))
end
