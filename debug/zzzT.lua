SMODS.Joker {
	key = "debugtest",
	name = "SEMBY_debugtest",
	loc_txt = { name = "DEBUG{B:1,C:white}TEST",
		text = { { "{C:red}Can Crash your Game!", "Current Test/Function:" }, {
			--"{C:inactive}Nothing!"
			"{B:1,C:white} Retrigger {}",
			"leftmost {C:attention}Joker"
	} } },
	loc_vars = function(self, info_queue, card) return {vars={colours={HEX('000000')}}} end,
	draw = function(self, card, layer) card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader) end,
	atlas = "SEMBY_jokers", pos = { x = 0, y = 0 }, rarity = 1, cost = 1242,
	--display_size = { w = 35.5, h = 47.5 }, soul_pos = { x = 11, y = 11 },
	unlocked = true, discovered = true, blueprint_compat = true, in_pool = function(self, args) return false end,
	--set_ability = function(self, card, initial, delay_sprites)
	--	card:set_alignment{ major = card, type = 'cm', offset = {x=0, y=0} }
	--end,
	--add_to_deck = function(self, card, from_debuff)
	--	card:set_dissolve({G.C.WHITE, G.C.BLACK}, 0.0, 0.5, 0)
	--end,
	calculate = function(self, card, context)
		-- UNSAFE CODE: Blueprint will Hardcrash if Pointed at this Joker.
		if context.joker_main and G.jokers.cards[1] ~= card then
			-- Announce
			SMODS.calculate_effect({ message = 'Retrigger!', colour = HEX('000000') }, (context.blueprint_card or card))
			-- Start Modified Copy from: "state_events.lua" -> "G.FUNCS.evaluate_play = function(e)" -> "Joker Effects"
			local effects = {}
			-- Edition
            local eval = eval_card(G.jokers.cards[1], {cardarea = G.jokers, full_hand = G.play.cards, scoring_hand = scoring_hand, scoring_name = text, poker_hands = poker_hands, edition = true, pre_joker = true})
            if eval.edition then effects[#effects+1] = eval end
			-- Joker + Retrigger
            local joker_eval, post = eval_card(G.jokers.cards[1], {cardarea = G.jokers, full_hand = G.play.cards, scoring_hand = scoring_hand, scoring_name = text, poker_hands = poker_hands, joker_main = true})
            if next(joker_eval) then
                if joker_eval.edition then joker_eval.edition = {} end
                table.insert(effects, joker_eval)
                for _, v in ipairs(post) do effects[#effects+1] = v end
                if joker_eval.retriggers then
                    for rt = 1, #joker_eval.retriggers do
                        local rt_eval, rt_post = eval_card(G.jokers.cards[1], {cardarea = G.jokers, full_hand = G.play.cards, scoring_hand = scoring_hand, scoring_name = text, poker_hands = poker_hands, joker_main = true, retrigger_joker = true})
                        if next(rt_eval) then
                            table.insert(effects, {retriggers = joker_eval.retriggers[rt]})
                            table.insert(effects, rt_eval)
                            for _, v in ipairs(rt_post) do effects[#effects+1] = v end
                        end
                    end
                end
            end
			-- Insert Event
			SMODS.trigger_effects(effects, G.jokers.cards[1])
			-- Return
			return nil, true
		end
    end
}
