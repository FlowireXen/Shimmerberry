SMODS.Joker {
	key = "toolkit",
	name = "SEMBY_toolkit",
	atlas = "SEMBY_jokers",
	pos = { x = 9, y = 5 },
    unlocked = true,
    discovered = false,
    eternal_compat = false,
    perishable_compat = false,
    blueprint_compat = true,
	rarity = 1,
	cost = 4,
	config = {
		extra = {
			SEMBY_Durability = {
				max_durability = 500,
				durability = 500,
				repair_cost = 0,
				repair_gain = 0
			},
			repair_mod = 5,
			-- Vanilla Support
			j_selzer = {
				max_durability = 10,
				repair_cost = 5,
				repair_gain = 1
			},
			-- Sticker Support
			perishable = {
				max_durability = 6, -- Max: 5, +1 Extra
				repair_cost = 20,
				repair_gain = 1
			}
		}
	},
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
		return { vars = {
			card.ability.extra.repair_mod,
			card:durability_amount(),
			colours = { 
				card:durability_color()
			}
		} }
	end,
	calculate = function(self, card, context)
		if context.end_of_round and context.cardarea == G.jokers and not context.game_over then
			for index, joker in pairs(G.jokers.cards) do
				if not (joker.debuff or joker.getting_sliced) then
					local repaired = false
					local ret_msg = nil
					-- Normal Behaviour
					if joker.ability.SEMBY_Durability and joker.ability.SEMBY_Durability.repair_gain
					and not (joker.ability.SEMBY_Durability.repair_gain == 0) then
						for i = 1, card.ability.extra.repair_mod do
							if context.blueprint or (card.ability.SEMBY_Durability.durability > 0) then
								if joker.ability.SEMBY_Durability.max_durability > joker.ability.SEMBY_Durability.durability then
									joker.ability.SEMBY_Durability.durability = joker.ability.SEMBY_Durability.durability + joker.ability.SEMBY_Durability.repair_gain
									card.ability.SEMBY_Durability.durability = card.ability.SEMBY_Durability.durability - joker.ability.SEMBY_Durability.repair_cost
									repaired = true
								else
									break
								end
							else
								break
							end
						end
						if repaired then
							if joker.ability.SEMBY_Durability.is_liquid then
								ret_msg = localize('SEMBY_durability_refilled')
							elseif joker.ability.SEMBY_Durability.is_vital then
								ret_msg = localize('SEMBY_durability_revitalized')
							else
								ret_msg = localize('SEMBY_durability_repaired')
							end
							if joker.ability.SEMBY_Durability.durability > joker.ability.SEMBY_Durability.max_durability then
								joker.ability.SEMBY_Durability.durability = joker.ability.SEMBY_Durability.max_durability
							end
						end
					-- Vanilla Support
					elseif joker.config.center.key == 'j_selzer' then
						for i = 1, card.ability.extra.repair_mod do
							if context.blueprint or (card.ability.SEMBY_Durability.durability > 0) then
								if card.ability.extra.j_selzer.max_durability > joker.ability.extra then
									joker.ability.extra = joker.ability.extra + card.ability.extra.j_selzer.repair_gain
									card.ability.SEMBY_Durability.durability = card.ability.SEMBY_Durability.durability - card.ability.extra.j_selzer.repair_cost
									repaired = true
								else
									break;
								end
							else
								break;
							end
						end
						if repaired then
							ret_msg = localize('SEMBY_durability_refilled')
							if joker.ability.extra > card.ability.extra.j_selzer.max_durability then
								joker.ability.extra = card.ability.extra.j_selzer.max_durability
							end
						end
					end
					-- Sticker Support
					-- Perishable
					if joker.ability.perishable and joker.ability.perish_tally then
						for i = 1, card.ability.extra.repair_mod do
							if context.blueprint or (card.ability.SEMBY_Durability.durability > 0) then
								if card.ability.extra.perishable.max_durability > joker.ability.perish_tally then
									joker.ability.perish_tally = joker.ability.perish_tally + card.ability.extra.perishable.repair_gain
									card.ability.SEMBY_Durability.durability = card.ability.SEMBY_Durability.durability - card.ability.extra.perishable.repair_cost
									repaired = true
								else
									break;
								end
							else
								break;
							end
						end
						if repaired and not ret_msg then
							ret_msg = localize('SEMBY_durability_revitalized')
							if joker.ability.perish_tally > card.ability.extra.perishable.max_durability then
								joker.ability.perish_tally = card.ability.extra.perishable.max_durability
							end
						end
					end
					-- Forced Perishable
					if joker.ability.SEMBY_forced_perishable and joker.ability.SEMBY_forced_perish_tally then
						for i = 1, card.ability.extra.repair_mod do
							if context.blueprint or (card.ability.SEMBY_Durability.durability > 0) then
								if card.ability.extra.perishable.max_durability > joker.ability.SEMBY_forced_perish_tally then
									joker.ability.SEMBY_forced_perish_tally = joker.ability.SEMBY_forced_perish_tally + card.ability.extra.perishable.repair_gain
									card.ability.SEMBY_Durability.durability = card.ability.SEMBY_Durability.durability - card.ability.extra.perishable.repair_cost
									repaired = true
								else
									break;
								end
							else
								break;
							end
						end
						if repaired and not ret_msg then
							ret_msg = localize('SEMBY_durability_revitalized')
							if joker.ability.SEMBY_forced_perish_tally > card.ability.extra.perishable.max_durability then
								joker.ability.SEMBY_forced_perish_tally = card.ability.extra.perishable.max_durability
							end
						end
					end
					-- The End!
					if repaired then
						local juice_card = (context.blueprint_card or card)
						G.E_MANAGER:add_event(Event({
							func = function()
								juice_card:juice_up()
								return true
							end
						}))
						card_eval_status_text(joker, 'extra', nil, nil, nil, {
							message = ret_msg,
							colour = G.C.GREEN
						})
					end
				end
			end
			if not context.blueprint then
				card:durability_check()
			end
			return nil, true
		end
	end,
    in_pool = function(self, args)
		if G.jokers then
			for index, joker in pairs(G.jokers.cards) do
				if joker.ability.perishable
				or joker.ability.SEMBY_Durability
				or joker.ability.SEMBY_forced_perishable
				or joker.config.center.key == 'j_selzer'
				then return true end
			end
		end
        return false
    end
}
