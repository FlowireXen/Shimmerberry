SMODS.Joker {
	key = "mineshaft",
	SEMBY_art = "unkokat",
	atlas = "SEMBY_jokers_1",
	pos = { x = 0, y = 6 },
    eternal_compat = false,
    perishable_compat = true,
    blueprint_compat = true,
	rarity = 1,
	cost = 6,
	config = {
		extra = {
			-- Durability
			durability = 25,
			durability_max = 25,
			-- Joker
			every = 3,
			count = 0
		}
	},
    attributes = {
		'generation', 'enhancements',
		'durability'
	},
	pools = {
        ["Durability"] = true,
    },
	loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
        info_queue[#info_queue + 1] = G.P_CENTERS.m_steel
        info_queue[#info_queue + 1] = G.P_CENTERS.m_gold
		return { vars = {
			card.ability.extra.every,
			card.ability.extra.count,
			card:SEMBY_durability_amount(),
			colours = { card:SEMBY_durability_color() }
		} }
	end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
			local mine_a_card = false
			if context.blueprint_card then
				context.blueprint_card.ability.SEMBY_mineshaft = context.blueprint_card.ability.SEMBY_mineshaft + 1
				if context.blueprint_card.ability.SEMBY_mineshaft >= card.ability.extra.every then
					context.blueprint_card.ability.SEMBY_mineshaft = 0
					mine_a_card = true
				end
			else
				card.ability.extra.count = card.ability.extra.count + 1
				if card.ability.extra.count >= card.ability.extra.every then
					card.ability.extra.count = 0
					mine_a_card = true
				end
			end
			if mine_a_card then
				if context.blueprint or card:SEMBY_durability_use() then
					-- Create Card:
					local minecard = SMODS.create_card{ set = "Base", enhancement = SMODS.poll_enhancement({ guaranteed = true, options = { 'm_stone', 'm_steel', 'm_gold' } }) }
            		G.playing_card = (G.playing_card and G.playing_card + 1) or 1
            		minecard.playing_card = G.playing_card
            		table.insert(G.playing_cards, minecard)
					-- Setup "Materialize"
					minecard.states.visible = nil
					context.other_card.SEMBY_offset = (context.other_card.SEMBY_offset or -0.5) + 0.5
					minecard.T.x = context.other_card.T.x
					minecard.T.y = context.other_card.T.y + (context.other_card.SEMBY_offset % 3)
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
						colour = G.C.IMPORTANT
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
			local mined = false
			for _, playing_card in ipairs(G.playing_cards) do
				if playing_card.SEMBY_offset then
					mined = true
					playing_card.SEMBY_offset = nil
				end
			end
			if mined then G.deck:shuffle() end
			card:SEMBY_durability_check()
		end
		if context.blueprint_card then
			if context.before then context.blueprint_card.ability.SEMBY_mineshaft = card.ability.extra.count end
			if context.after then context.blueprint_card.ability.SEMBY_mineshaft = nil end
		end
    end
}
