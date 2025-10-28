SMODS.Joker {
	key = "mineshaft",
	name = "SEMBY_mineshaft",
	atlas = "SEMBY_jokers",
	pos = { x = 5, y = 10 },
    unlocked = true,
    discovered = false,
    eternal_compat = false,
    perishable_compat = true,
    blueprint_compat = true,
	rarity = 1,
	cost = 6,
	config = {
		extra = {
			SEMBY_Durability = {
				max_durability = 50,
				durability = 50,
				repair_cost = 3,
				repair_gain = 1
			},
			every = 3,
			remaining = 3
		}
	},
	loc_vars = function(self, info_queue, card)
		SEMBY_Queue_Artist(card, info_queue)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
        info_queue[#info_queue + 1] = G.P_CENTERS.m_steel
        info_queue[#info_queue + 1] = G.P_CENTERS.m_gold
		return { vars = {
			card.ability.extra.remaining,
			card:durability_amount(),
			colours = { card:durability_color() }
		} }
	end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
			card.ability.extra.remaining = card.ability.extra.remaining - 1
			if card.ability.extra.remaining <= 0 then
				card.ability.extra.remaining = card.ability.extra.every
				if context.blueprint or card:durability_use() then
					-- Create Card:
					local minecard = SMODS.create_card{ set = "Base", enhancement = SMODS.poll_enhancement({ guaranteed = true, options = { 'm_stone', 'm_steel', 'm_gold' } }) }
            		G.playing_card = (G.playing_card and G.playing_card + 1) or 1
            		minecard.playing_card = G.playing_card
            		table.insert(G.playing_cards, minecard)
					-- Setup "Materialize"
					minecard.states.visible = nil
					context.other_card.SEMBY_mined = (context.other_card.SEMBY_mined or -0.5) + 0.5
					minecard.T.x = context.other_card.T.x
					minecard.T.y = context.other_card.T.y + (context.other_card.SEMBY_mined % 3)
					-- Materialize --> Shows with Text
					local juice_card = (context.blueprint_card or card)
					G.E_MANAGER:add_event(Event({
						trigger = 'after',
            			func = function()
            			    minecard:start_materialize()
            			    G.GAME.blind:debuff_card(minecard)
							juice_card:juice_up()
            			    SMODS.calculate_context({ playing_card_added = true, cards = { minecard } })
							-- Show but don't allow Moving:
							minecard.states.click.can = false
							minecard.states.drag.can = false
							minecard.states.focus.can = false
            			    return true
            			end
            		}))
					-- Eval-Status instead of return; Slows down further Animations
					card_eval_status_text(context.other_card, 'extra', nil, nil, nil, {
						message = localize('SEMBY_card_mined_ex'),
						colour = G.C.ATTENTION
					})
					-- Let the Card stay a bit before emplacing:
					G.E_MANAGER:add_event(Event({
						trigger = 'after',
						delay = 1.5,
						blocking = false,
						func = function()
							minecard.states.click.can = true
							minecard.states.drag.can = true
							minecard.states.focus.can = true
							G.deck:emplace(minecard)
							return true
						end
					}))
					return nil, true
				end
			end
		end
		if context.after and not context.blueprint then
			for _, playing_card in ipairs(G.playing_cards) do
				if playing_card.SEMBY_mined then
					playing_card.SEMBY_mined = nil
				end
			end
			card:durability_check()
		end
    end
}
