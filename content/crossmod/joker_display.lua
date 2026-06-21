
-- Clear all "##TODO##"s
-- ##TODO## !!! DON'T FORGET THE BETA JOKERS !!!

--## CrossMod: JokerDisplay
-- > https://github.com/nh6574/JokerDisplay/wiki
if Shimmerberry.compat.display then
local jd_def = JokerDisplay.Definitions
local jd_e_def = JokerDisplay.Edition_Definitions
local jd_b_def = JokerDisplay.Blind_Definitions
-- SEMBY Diff. Update Ticks
local SLOW_UPDATE, NORM_UPDATE, FAST_UPDATE = 8, 4, 2
-- SEMBY Special Colors
G.C.SEMBY_PERCENT_L = lighten(G.C.SEMBY_PERCENT, 0.25)
G.C.SEMBY_TMTRAINER_L = lighten(G.C.SEMBY_TMTRAINER, 0.25)
-- SEMBY Percent Support
local function SEMBY_Reduce(num, triggers)   return (1 - (triggers == 1 and num or num ^ triggers)) * 100  end
local function SEMBY_Increase(num, triggers) return ((triggers == 1 and num or num ^ triggers) - 1) * 100  end
-- ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## -- ##  ##  ##  ####  ##  ##  ##
-- ## HOOKS & MOD CHANGES                                   ## -- ##  ##  ##  #  #  ##  ##  ##
-- ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## -- ###    ####  ##  ####    ###
local trigger_calc_hook = JokerDisplay.calculate_card_triggers
function JokerDisplay.calculate_card_triggers(card, scoring_hand, held_in_hand)
    local ret_val = trigger_calc_hook(card, scoring_hand, held_in_hand)
    -- Vintage Enhancement
    local hand_info = JokerDisplay.current_hand_info or {}
    if hand_info.text and hand_info.text ~= 'Unknown' and SMODS.has_enhancement(card, 'm_SEMBY_vintage') then
        if hand_info.SEMBY_vintage then
            ret_val = ret_val + 1
        elseif hand_info.SEMBY_vintage == nil then
            --print('vintage checked')
            local _, is_vintage = SEMBY_vintage_hand(hand_info.text)
            JokerDisplay.current_hand_info.SEMBY_vintage = is_vintage
            ret_val = ret_val + (is_vintage and 1 or 0)
        end
    end
    -- The Pencil Blind
    if G.GAME.blind and G.GAME.blind.boss and not G.GAME.blind.disabled
    and G.GAME.blind.name and G.GAME.blind.name == 'bl_SEMBY_pencil' then
        local first_card = scoring_hand and JokerDisplay.calculate_leftmost_card(JokerDisplay.current_hand)
        if first_card and first_card == card then ret_val = 0 end
    end
    -- JEV][L Joker
    if G.GAME and G.GAME.SEMBY_jevil_scoring and scoring_hand then
        ret_val = ret_val * G.GAME.SEMBY_jevil_scoring
    end
    -- Return new Total
    return ret_val
end
-- ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## -- ##  ##  ##  ####  ##  ##  ##
-- ## VANILLA CHANGES                                       ## -- ##  ##  ##  #  #  ##  ##  ##
-- ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## -- ###    ####  ##  ####    ###
jd_def['j_flower_pot'] = {
    text = {
        { border_nodes = {
            { text = "X" }, { ref_table = "card.joker_display_values", ref_value = "xmult", retrigger_type = "exp" }
        }, border_colour = G.C.MULT }
    },
    reminder_text = {
        { text = "(" },
        { ref_table = "card.ability.extra", ref_value = "suits", colour = G.C.IMPORTANT },
        { ref_table = "card.joker_display_values", ref_value = "localized_text" },
        { text = ")" },
    },
    calc_function = function(card)
        card.joker_display_values.update_timer = (card.joker_display_values.update_timer or NORM_UPDATE) + 1
        if card.joker_display_values.update_timer > NORM_UPDATE then
            card.joker_display_values.update_timer = 0
            local text, _, scoring_hand = JokerDisplay.evaluate_hand()
            if text ~= 'Unknown' and #scoring_hand >= card.ability.extra.suits
            and SEMBY_count_suits(scoring_hand) >= card.ability.extra.suits then
                card.joker_display_values.xmult = card.ability.extra.xmult
            else card.joker_display_values.xmult = 1.0 end
            card.joker_display_values.localized_text = ' '..localize('SEMBY_suits')
        end
    end
}
-- ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## -- ##  ##  ##  ####  ##  ##  ##
-- ## JOKERS                                                ## -- ##  ##  ##  #  #  ##  ##  ##
-- ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## -- ###    ####  ##  ####    ###
jd_def['j_SEMBY_abandoned_soul'] = {
    text = {
        { border_nodes = {
            { text = "X" },
            { ref_table = "card.ability.extra", ref_value = "xchips", retrigger_type = "exp" }
        }, border_colour = G.C.CHIPS }
    }
}
jd_def['j_SEMBY_adblocker'] = {
    text = {
        { text = "+$" }, { ref_table = "card.joker_display_values", ref_value = "dollars", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.MONEY },
    reminder_text = {
        { text = "(" }, { ref_table = "card.joker_display_values", ref_value = "card_suit" }, { text = ")" }
    },
    calc_function = function(card)
        local debuffed = 0
        local hand = JokerDisplay.current_hand
        for _, playing_card in pairs(hand) do
            if playing_card.debuff then
                debuffed = debuffed + 1
            end
        end
        card.joker_display_values.dollars = debuffed * card.ability.extra.dollars
        card.joker_display_values.card_suit = card.ability.extra.debuffed and
            localize(card.ability.extra.debuffed, 'suits_plural') or localize('SEMBY_nothing')
    end,
    style_function = function(card, text, reminder_text, extra)
        if reminder_text and reminder_text.children[2] then
            reminder_text.children[2].config.colour = card.ability.extra.debuffed and
                lighten(G.C.SUITS[card.ability.extra.debuffed], 0.35) or G.C.UI.TEXT_INACTIVE
        end
    end
}
jd_def['j_SEMBY_afterimage'] = {
    reminder_text = {
        { text = "(" }, { ref_table = "card.joker_display_values", ref_value = "blueprint_compat", colour = G.C.RED }, { text = ")" }
    },
    calc_function = function(card)
        local copied_joker, copied_debuff = JokerDisplay.calculate_blueprint_copy(card)
        card.joker_display_values.blueprint_compat = localize('k_incompatible')
        JokerDisplay.copy_display(card, copied_joker, copied_debuff)
    end,
    get_blueprint_joker = function(card)
		if card.area and not card.area.config.collection then
			for i = 1, #card.area.cards do
				if card.area.cards[i] == card then
                    local other = card.area.cards[i - 1]
                    if other and card.joker_display_values then
                        card.joker_display_values.repeats = card.ability.extra.repeats
                        if other.joker_display_values and other.joker_display_values.repeats then
                            card.joker_display_values.repeats = card.joker_display_values.repeats * other.joker_display_values.repeats
                        end
                    end
					return other
				end
			end
        end
        return nil
    end,
    retrigger_joker_function = function(card, retrigger_joker)
        if card and card == retrigger_joker then
            return math.max(0, (card.joker_display_values and card.joker_display_values.repeats or 0) - 1)
        end
    end
}
jd_def['j_SEMBY_agent_fourty_seven'] = {
    reminder_text = {
        { text = "(" }, { ref_table = "card.joker_display_values", ref_value = "active_text" }, { text = ")" }
    },
    calc_function = function(card)
        card.joker_display_values.active = G.GAME.blind and G.GAME.blind.in_blind
            and #(G.hand and G.hand.highlighted or {}) == card.ability.extra.discard_limit
        card.joker_display_values.active_text =
            localize(card.joker_display_values.active and 'jdis_active' or 'jdis_inactive')
    end,
    style_function = function(card, text, reminder_text, extra)
        if reminder_text and reminder_text.children and reminder_text.children[2] then
            reminder_text.children[2].config.colour = card.joker_display_values.active and G.C.GREEN or G.C.UI.TEXT_INACTIVE
        end
    end
}
jd_def['j_SEMBY_alpha'] = {
    text = {
        { text = "+", colour = G.C.BLUE },
        { ref_table = "card.joker_display_values", ref_value = "hands", retrigger_type = "mult", colour = G.C.BLUE },
        { ref_table = "card.joker_display_values", ref_value = "localized_text", scale = 0.35 },
    },
    reminder_text = {
        { text = "(" }, { ref_table = "card.joker_display_values", ref_value = "localized_reminder", colour = G.C.IMPORTANT }, { text = ")" }
    },
    calc_function = function(card)
        local hands = 0
        local text, _, scoring_hand = JokerDisplay.evaluate_hand()
        if text ~= 'Unknown' then
            for _, scoring_card in pairs(scoring_hand) do
                if SMODS.has_enhancement(scoring_card, 'm_stone') then
                --if scoring_card.ability.name and scoring_card.ability.name == 'Stone Card' then
                    hands = hands + card.ability.extra.hands * JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
                    break
                end
            end
        end
        card.joker_display_values.hands = hands
        card.joker_display_values.localized_text = ' '..localize("k_hud_hands")
        card.joker_display_values.localized_reminder = localize{ type = 'name_text', set = 'Enhanced', key = 'm_stone' }
    end
}
jd_def['j_SEMBY_anchor'] = {
    text = {
        { border_nodes = {
            { text = "X" },
            { ref_table = "card.ability.extra", ref_value = "xchips", retrigger_type = "exp" }
        }, border_colour = G.C.CHIPS }
    }
}
jd_def['j_SEMBY_annoying_dog'] = {
    text = {
        { border_nodes = {
            { text = "X" },
            { ref_table = "card.ability.extra", ref_value = "xmult", retrigger_type = "exp" },
            { ref_table = "card.joker_display_values", ref_value = "tail" } -- "Annoying Dog" Tail! :3c
        }, border_colour = G.C.MULT }
    },
    calc_function = function(card)
        card.joker_display_values.tail = (card.ability.extra.xmult % 1 == 0) and '.0' or ''
    end
}
jd_def['j_SEMBY_anodized_steel'] = {
    text = {
        { text = "-" }, { ref_table = "card.joker_display_values", ref_value = "percent", retrigger_type = SEMBY_Reduce }, { text = "%" },
    },
    text_config = { colour = G.C.SEMBY_PERCENT_L },
    reminder_text = {
        { text = "(" }, { ref_table = "card.joker_display_values", ref_value = "localized_text" }, { text = ")" }
    },
    calc_function = function(card)
        local percent = 0
        local text, _, scoring_hand = JokerDisplay.evaluate_hand()
        if text ~= 'Unknown' then
            for _, scoring_card in pairs(scoring_hand) do
                if SMODS.has_enhancement(scoring_card, 'm_steel') then
                --if scoring_card.ability.name and scoring_card.ability.name == 'Steel Card' then
                    percent = percent + JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
                end
            end
        end
        card.joker_display_values.percent = (1 - card.ability.extra.percent) ^ percent
        card.joker_display_values.localized_text = localize{ type = 'name_text', set = 'Enhanced', key = 'm_steel' }
    end
}
jd_def['j_SEMBY_benthic_bloom'] = {
    retrigger_function = function(playing_card, scoring_hand, held_in_hand, joker_card)
        return next(SMODS.get_enhancements(playing_card)) and JokerDisplay.in_scoring(playing_card, scoring_hand)
            and joker_card.ability.extra.repetitions * JokerDisplay.calculate_joker_triggers(joker_card) or 0
    end
}
jd_def['j_SEMBY_berry_blue'] = { --> "k_safe_ex"?
    text = {
        { text = "+" }, { ref_table = "card.joker_display_values", ref_value = "chips", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.CHIPS },
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "berry_rank_one", colour = G.C.SEMBY },
        { text = ", " },
        { ref_table = "card.joker_display_values", ref_value = "berry_rank_two", colour = G.C.SEMBY },
        { text = ")" },
    },
    calc_function = function(card)
        -- Ranks
		local card_one = G.GAME.current_round.SEMBY_berry_rank_one or { rank = 'King'  }
		local card_two = G.GAME.current_round.SEMBY_berry_rank_two or { rank = 'Queen' }
        -- Get Values
        local chips = 0
        local text, _, scoring_hand = JokerDisplay.evaluate_hand()
        if text ~= 'Unknown' then
            for _, scoring_card in pairs(scoring_hand) do
                if scoring_card:get_id() and (scoring_card:get_id() == card_one.id or scoring_card:get_id() == card_two.id) then
                    chips = chips + card.ability.extra.chips * JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
                end
            end
        end
        -- Set Values
        card.joker_display_values.chips = chips
        card.joker_display_values.berry_rank_one = localize(card_one.rank, 'ranks')
        card.joker_display_values.berry_rank_two = localize(card_two.rank, 'ranks')
    end
}
jd_def['j_SEMBY_berry_golden'] = {--> "k_safe_ex"?
    text = {
        { text = "$", colour = G.C.MONEY }, { ref_table = "card.joker_display_values", ref_value = "dollars_1", retrigger_type = "mult", colour = G.C.MONEY },
        { text = "-" },
        { text = "$", colour = G.C.MONEY }, { ref_table = "card.joker_display_values", ref_value = "dollars_2", retrigger_type = "mult", colour = G.C.MONEY }
    },
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "berry_rank_one", colour = G.C.SEMBY },
        { text = ", " },
        { ref_table = "card.joker_display_values", ref_value = "berry_rank_two", colour = G.C.SEMBY },
        { text = ")" },
    },
    calc_function = function(card)
        -- Ranks
		local card_one = G.GAME.current_round.SEMBY_berry_rank_one or { rank = 'King'  }
		local card_two = G.GAME.current_round.SEMBY_berry_rank_two or { rank = 'Queen' }
        -- Get Values
        local dollars_1 = 0
        local dollars_2 = 0
        local text, _, scoring_hand = JokerDisplay.evaluate_hand()
        if text ~= 'Unknown' then
            for _, scoring_card in pairs(scoring_hand) do
                if scoring_card:get_id() and (scoring_card:get_id() == card_one.id or scoring_card:get_id() == card_two.id) then
                    dollars_1 = dollars_1 + card.ability.extra.dollars_min * JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
                    dollars_2 = dollars_2 + card.ability.extra.dollars_max * JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
                end
            end
        end
        -- Set Values
        card.joker_display_values.dollars_1 = dollars_1
        card.joker_display_values.dollars_2 = dollars_2
        card.joker_display_values.berry_rank_one = localize(card_one.rank, 'ranks')
        card.joker_display_values.berry_rank_two = localize(card_two.rank, 'ranks')
    end
}
jd_def['j_SEMBY_berry_shimmer'] = { --> "k_safe_ex"?
    text = {
        { text = "-" }, { ref_table = "card.joker_display_values", ref_value = "percent", retrigger_type = SEMBY_Reduce }, { text = "%" },
    },
    text_config = { colour = G.C.SEMBY_PERCENT_L },
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "berry_rank_one", colour = G.C.SEMBY },
        { text = ", " },
        { ref_table = "card.joker_display_values", ref_value = "berry_rank_two", colour = G.C.SEMBY },
        { text = ")" },
    },
    calc_function = function(card)
        -- Ranks
		local card_one = G.GAME.current_round.SEMBY_berry_rank_one or { rank = 'King'  }
		local card_two = G.GAME.current_round.SEMBY_berry_rank_two or { rank = 'Queen' }
        -- Get Values
        local percent = 0
        local text, _, scoring_hand = JokerDisplay.evaluate_hand()
        if text ~= 'Unknown' then
            for _, scoring_card in pairs(scoring_hand) do
                if scoring_card:get_id() and (scoring_card:get_id() == card_one.id or scoring_card:get_id() == card_two.id) then
                    percent = percent + JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
                end
            end
        end
        -- Set Values
        card.joker_display_values.percent = (1 - card.ability.extra.percent) ^ percent
        card.joker_display_values.berry_rank_one = localize(card_one.rank, 'ranks')
        card.joker_display_values.berry_rank_two = localize(card_two.rank, 'ranks')
    end
}
jd_def['j_SEMBY_berry_straw'] = { --> "k_safe_ex"?
    text = {
        { text = "+" }, { ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.MULT },
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "berry_rank_one", colour = G.C.SEMBY },
        { text = ", " },
        { ref_table = "card.joker_display_values", ref_value = "berry_rank_two", colour = G.C.SEMBY },
        { text = ")" },
    },
    calc_function = function(card)
        -- Ranks
		local card_one = G.GAME.current_round.SEMBY_berry_rank_one or { rank = 'King'  }
		local card_two = G.GAME.current_round.SEMBY_berry_rank_two or { rank = 'Queen' }
        -- Get Values
        local mult = 0
        local text, _, scoring_hand = JokerDisplay.evaluate_hand()
        if text ~= 'Unknown' then
            for _, scoring_card in pairs(scoring_hand) do
                if scoring_card:get_id() and (scoring_card:get_id() == card_one.id or scoring_card:get_id() == card_two.id) then
                    mult = mult + card.ability.extra.mult * JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
                end
            end
        end
        -- Set Values
        card.joker_display_values.mult = mult
        card.joker_display_values.berry_rank_one = localize(card_one.rank, 'ranks')
        card.joker_display_values.berry_rank_two = localize(card_two.rank, 'ranks')
    end
}
jd_def['j_SEMBY_boosterpack_joker'] = {
    --text = { { text = '' } },
    extra = { {
        { text = "(" },
        { ref_table = "card.ability.extra", ref_value = "durability" },
        { text = "/" },
        { ref_table = "card.ability.extra", ref_value = "durability_max" },
        { text = ")" },
    } },
    extra_config = { colour = G.C.UI.TEXT_INACTIVE, scale = 0.3 },
    calc_function = function(card)
        card.joker_display_values.colour = card:SEMBY_durability_color(true)
    end,
    style_function = function(card, text, reminder_text, extra)
        if extra and extra.children and extra.children[1] and extra.children[1].children and extra.children[1].children[2] then
            extra.children[1].children[2].config.colour = card.joker_display_values.colour or G.C.UI.TEXT_INACTIVE
        end
    end
}
jd_def['j_SEMBY_bound'] = { } -- No Info.

jd_def['j_SEMBY_broken_record'] = {
    calc_function = function(card)
        local text, _, scoring_hand = JokerDisplay.evaluate_hand()
        if text ~= 'Unknown' and #scoring_hand ~= 0 then
            card.joker_display_values.update_timer = (card.joker_display_values.update_timer or 0) + 1 --or NORM_UPDATE) + 1
            if card.joker_display_values.update_timer > NORM_UPDATE then
                card.joker_display_values.update_timer = 0
                local id = 'SEMBY_jdis_'..card.sort_id
                for _, scoring_card in pairs(scoring_hand) do scoring_card[id] = nil end
                local retriggers = (JokerDisplay.calculate_joker_triggers(card) or 0)
                if retriggers ~= 0 then
                    retriggers = math.max(1, math.random(card.ability.extra.min * retriggers, card.ability.extra.max * retriggers))
                    for i = 1, retriggers do
                        local index = math.random(1, #scoring_hand)
                        if scoring_hand[index] then scoring_hand[index][id] = (scoring_hand[index][id] or 0) + 1 end
                    end
                end
            end
        end
    end,
    retrigger_function = function(playing_card, scoring_hand, held_in_hand, joker_card)
        if not held_in_hand and joker_card and playing_card['SEMBY_jdis_'..joker_card.sort_id] then
            return playing_card['SEMBY_jdis_'..joker_card.sort_id]
        end
        return 0
    end
}
jd_def['j_SEMBY_buccaneer'] = {
    text = {
        { text = "+" }, { ref_table = "card.joker_display_values", ref_value = "chips", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.CHIPS },
    calc_function = function(card)
        local sell_cost = 0
        for _, joker in ipairs(G.jokers and G.jokers.cards or {}) do
            if joker ~= card then sell_cost = sell_cost + joker.sell_cost end
        end
        card.joker_display_values.chips = card.ability.extra.chips * sell_cost
    end
}
jd_def['j_SEMBY_butterfly'] = {
    text = {
        { ref_table = "card.joker_display_values", ref_value = "notation" },
        { ref_table = "card.joker_display_values", ref_value = "chips", retrigger_type = "mult" },
    },
    text_config = { colour = G.C.CHIPS },
    reminder_text = {
        { text = "(" }, { ref_table = "card.joker_display_values", ref_value = "localized_text", colour = G.C.ORANGE }, { text = ")" },
    },
    calc_function = function(card)
        local expected = card.ability.extra.chips
        if G.hand and #G.hand.highlighted > 0 then --> Not optimal but it works.
            local _, poker_hands, _ = JokerDisplay.evaluate_hand()
            if poker_hands[card.ability.extra.type] and next(poker_hands[card.ability.extra.type]) then
                expected = expected + card.ability.extra.chip_gain
            else
                expected = expected - card.ability.extra.chip_loss
            end
        end
        card.joker_display_values.notation = expected >= 0 and '+' or '-'
        card.joker_display_values.chips = math.abs(expected)
        card.joker_display_values.localized_text = localize(card.ability.extra.type, 'poker_hands')
    end
}
jd_def['j_SEMBY_ceaseless_void'] = {
    text = {
        { border_nodes = {
            { text = "X" },
            { ref_table = "card.ability.extra", ref_value = "xchips", retrigger_type = "exp" }
        }, border_colour = G.C.CHIPS },
        { text = " " },
        { border_nodes = {
            { text = "X" },
            { ref_table = "card.ability.extra", ref_value = "xmult", retrigger_type = "exp" }
        }, border_colour = G.C.MULT },
    },
    extra = { {
        { text = "+" },
        { ref_table = "card.joker_display_values", ref_value = "percent", retrigger_type = SEMBY_Increase },
        { text = "%" },
    } },
    extra_config = { colour = G.C.SEMBY_PERCENT_L },
    calc_function = function(card)
        card.joker_display_values.percent = 1 + card.ability.extra.percent
    end
}
jd_def['j_SEMBY_chrono_break'] = { } -- no info
jd_def['j_SEMBY_cockroach'] = { } -- no info
jd_def['j_SEMBY_common_denominator'] = {
    text = {
        { ref_table = "card.joker_display_values", ref_value = "count", retrigger_type = "mult" },
        { text = "x", scale = 0.35 },
        { ref_table = "card.joker_display_values", ref_value = "localized_text", colour = (G.C.RARITY.Common or G.C.BLUE) }
    },
    calc_function = function(card)
		local compatible = 0
        for _, joker in ipairs(G.jokers and G.jokers.cards or {}) do
            if joker.config.center.blueprint_compat and joker.config.center.rarity == 1 then
                compatible = compatible + 1
            end
        end
        card.joker_display_values.count = compatible
        card.joker_display_values.localized_text = localize('k_common')
    end,
    retrigger_function = function(playing_card, scoring_hand, held_in_hand, joker_card)
        if joker_card then -- Copy from "JokerDisplay/src/api_helper_functions.lua"
            local joker_trigger = JokerDisplay.calculate_joker_triggers(joker_card) or 0
            if joker_trigger ~= 0 then
                if joker_trigger > 1 then joker_trigger = joker_trigger - 1 end
                local total_retriggers = 0
                for _, joker in ipairs(G.jokers and G.jokers.cards or {}) do
                    if joker.config.center.blueprint_compat and joker.config.center.rarity == 1 and joker ~= joker_card then
                        local joker_display_definition = JokerDisplay.Definitions[joker.config.center.key]
                        local retrigger_function = not joker.debuff and joker.joker_display_values and
                            ((joker_display_definition and joker_display_definition.retrigger_function) or
                                (joker.joker_display_values.blueprint_ability_key and
                                    not joker.joker_display_values.blueprint_debuff and not joker.joker_display_values.blueprint_stop_func and
                                    JokerDisplay.Definitions[joker.joker_display_values.blueprint_ability_key] and
                                    JokerDisplay.Definitions[joker.joker_display_values.blueprint_ability_key].retrigger_function))
                        if retrigger_function then
                            total_retriggers = total_retriggers +
                                math.floor(retrigger_function(playing_card, scoring_hand, held_in_hand or false,
                                    joker.joker_display_values and not joker.joker_display_values.blueprint_stop_func and
                                    joker.joker_display_values.blueprint_ability_joker or joker) or 0)
                        end
                    end
                end
                return total_retriggers * joker_trigger
            end
        end
    end
}
jd_def['j_SEMBY_copy_printer'] = { } -- no info
jd_def['j_SEMBY_coupon'] = { } -- no info
jd_def['j_SEMBY_coupon_booklet'] = {
    text = {
        { text = "-" }, { ref_table = "card.joker_display_values", ref_value = "shop_mod" }, { text = "%" }
    },
    text_config = { colour = G.C.MONEY },
    calc_function = function(card)
        card.joker_display_values.shop_mod = math.floor(card.ability.extra.shop_mod * 100 + 0.5) * card.ability.extra.state
    end
}
jd_def['j_SEMBY_echoing_joker'] = { } -- no info
jd_def['j_SEMBY_eden_blessing'] = {
    text = {
        { border_nodes = {
            { text = "X" },
            { ref_table = "card.ability.extra", ref_value = "xcom", retrigger_type = "exp" }
        }, border_colour = SMODS.Gradients.SEMBY_EDEN }
    }
}
jd_def['j_SEMBY_emergency_button'] = { } -- no info
jd_def['j_SEMBY_eternal_fortune'] = { } -- no info
jd_def['j_SEMBY_fifty_seven_leaf_clover'] = {
    retrigger_function = function(playing_card, scoring_hand, held_in_hand, joker_card)
        return SMODS.has_enhancement(playing_card, 'm_wild') and joker_card.ability.extra.repetitions * JokerDisplay.calculate_joker_triggers(joker_card) or 0
    end
}
jd_def['j_SEMBY_fortune_cookie'] = { } -- no info
jd_def['j_SEMBY_garden_gnome'] = {
    text = {
        { text = "+" }, { ref_table = "card.ability.extra", ref_value = "mult", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.MULT }
}
jd_def['j_SEMBY_gold_bomb'] = {
    reminder_text = {
        { text = "(" }, { ref_table = "card.joker_display_values", ref_value = "active_text" }, { text = ")" },
    },
    calc_function = function(card)
        card.joker_display_values.is_active = G.GAME.current_round.hands_left <= 1
        card.joker_display_values.active_text = localize("jdis_"..(card.joker_display_values.is_active and "active" or "inactive"))
    end,
    style_function = function(card, text, reminder_text, extra)
        if reminder_text and reminder_text.children and reminder_text.children[2] then
            reminder_text.children[2].config.colour = card.joker_display_values.is_active and G.C.GREEN or G.C.UI.TEXT_INACTIVE
        end
    end
}
jd_def['j_SEMBY_goobert'] = {
    --text = { { text = '' } },
    extra = { {
        { text = "(" },
        { ref_table = "card.ability.extra", ref_value = "durability" },
        { text = "/" },
        { ref_table = "card.ability.extra", ref_value = "durability_max" },
        { text = ")" },
    } },
    extra_config = { colour = G.C.UI.TEXT_INACTIVE, scale = 0.3 },
    calc_function = function(card)
        card.joker_display_values.colour = card:SEMBY_durability_color(true)
    end,
    style_function = function(card, text, reminder_text, extra)
        if extra and extra.children and extra.children[1] and extra.children[1].children and extra.children[1].children[2] then
            extra.children[1].children[2].config.colour = card.joker_display_values.colour or G.C.UI.TEXT_INACTIVE
        end
    end
}
jd_def['j_SEMBY_hemoturgy'] = { } -- no info
jd_def['j_SEMBY_hypetrain'] = {
    --FIXME: Hide Xmult when "card.ability.waiting == true" or "card.ability.extra.xmult ~= 1.0"
    text = {
        { text = "+", colour = G.C.MULT },
        { ref_table = "card.ability.extra", ref_value = "mult", retrigger_type = "mult", colour = G.C.MULT },
        { text = " " },
        { border_nodes = {
            { text = "X" },
            { ref_table = "card.ability.extra", ref_value = "xmult", retrigger_type = "exp" }
        }, border_colour = G.C.MULT }
    }
}
jd_def['j_SEMBY_improv'] = {
    text = {
        { ref_table = "card.joker_display_values", ref_value = "hands", colour = G.C.BLUE },
        { ref_table = "card.joker_display_values", ref_value = "localized_text", scale = 0.35 }
    },
    reminder_text = {
        { text = "(" }, { ref_table = "card.joker_display_values", ref_value = "active_text" }, { text = ")" },
    },
    calc_function = function(card)
        card.joker_display_values.hands = math.floor(card.ability.extra.points / card.ability.extra.hand_mod + 0.5)
        card.joker_display_values.localized_text = ' '..localize("k_hud_hands")
        card.joker_display_values.is_active = G.GAME.current_round.hands_left <= 1
        card.joker_display_values.active_text = localize("jdis_"..(card.joker_display_values.is_active and "active" or "inactive"))
    end,
    style_function = function(card, text, reminder_text, extra)
        if reminder_text and reminder_text.children and reminder_text.children[2] then
            reminder_text.children[2].config.colour = card.joker_display_values.is_active and G.C.GREEN or G.C.UI.TEXT_INACTIVE
        end
    end
}
jd_def['j_SEMBY_incinerator'] = { } -- no info
jd_def['j_SEMBY_jevil'] = { } -- special: managed via hook

jd_def['j_SEMBY_jokebra'] = { } -- special: manages itself

jd_def['j_SEMBY_lavish_joker'] = {
    text = {
        { text = "+$", colour = G.C.MONEY }, { ref_table = "card.ability.extra", ref_value = "money_saved", colour = G.C.MONEY },
        { text = " +" }, { ref_table = "card.joker_display_values", ref_value = "percent" }, { text = "%" }
    },
    text_config = { colour = G.C.SEMBY_PERCENT_L },
    calc_function = function(card)
        card.joker_display_values.percent = card.ability.extra.money_saved / card.ability.extra.money_mod * card.ability.extra.percent_mod * 100
    end
}
jd_def['j_SEMBY_lost_constellation'] = { } -- no info
jd_def['j_SEMBY_lottery_ticket'] = {
    text = {
        { ref_table = "card.joker_display_values", ref_value = "spacing", scale = 0.35 },
        { text = " +", colour = G.C.CHIPS },
        { ref_table = "card.ability.extra", ref_value = "chips", colour = G.C.CHIPS }
    },
    reminder_text = {
        { text = "(" }, { ref_table = "card.joker_display_values", ref_value = "localized_text" }, { text = ")" }
    },
    extra = { {
        { ref_table = "card.joker_display_values", ref_value = "count", retrigger_type = "mult" },
        { text = "x", scale = 0.35 },
        { text = "+", colour = G.C.MULT },
        { ref_table = "card.ability.extra", ref_value = "mult", colour = G.C.MULT },
    }, {
        { text = "(", colour = G.C.GREEN, scale = 0.3 },
        { ref_table = "card.joker_display_values", ref_value = "odds", colour = G.C.GREEN, scale = 0.3 },
        { text = ")", colour = G.C.GREEN, scale = 0.3 },
    } },
    calc_function = function(card)
        local text, _, scoring_hand = JokerDisplay.evaluate_hand()
        local count = 0
        if text ~= 'Unknown' then
            for _, scoring_card in pairs(scoring_hand) do
                if not scoring_card:is_face() then
                    count = count + JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
                end
            end
        end
        card.joker_display_values.count = count
        card.joker_display_values.spacing = localize('k_or')
        card.joker_display_values.localized_text = localize('SEMBY_non_face')
        local numerator, denominator = SMODS.get_probability_vars(card,
            card.ability.extra.numerator, card.ability.extra.denominator, 'JokerDisplay')
        card.joker_display_values.odds = localize{type = 'variable', key = "jdis_odds", vars = { numerator, denominator }}
    end
}
jd_def['j_SEMBY_melon'] = {
    text = {
        { text = "-" }, { ref_table = "card.joker_display_values", ref_value = "percent", retrigger_type = SEMBY_Reduce }, { text = "%" },
    },
    text_config = { colour = G.C.SEMBY_PERCENT_L },
    calc_function = function(card)
        card.joker_display_values.percent = (1 - card.ability.extra.percent)
    end
}
jd_def['j_SEMBY_mineshaft'] = {
    text = {
        { text = "+", colour = G.C.IMPORTANT },
        { ref_table = "card.joker_display_values", ref_value = "count", retrigger_type = "mult", colour = G.C.IMPORTANT },
        { ref_table = "card.joker_display_values", ref_value = "localized_text" },
    },
    extra = { {
        { text = "(" },
        { ref_table = "card.ability.extra", ref_value = "durability" },
        { text = "/" },
        { ref_table = "card.ability.extra", ref_value = "durability_max" },
        { text = ")" },
    } },
    extra_config = { colour = G.C.UI.TEXT_INACTIVE, scale = 0.3 },
    calc_function = function(card)
        local text, _, scoring_hand = JokerDisplay.evaluate_hand()
        local count = card.ability.extra.count
        if text ~= 'Unknown' then
            for _, scoring_card in pairs(scoring_hand) do
                count = count + JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
            end
        end
        count = math.floor(count / card.ability.extra.every)
        card.joker_display_values.count = math.min(count, card.ability.extra.durability)
        card.joker_display_values.localized_text = ' '..localize('SEMBY_cards')
        card.joker_display_values.colour = card:SEMBY_durability_color(true)
    end,
    style_function = function(card, text, reminder_text, extra)
        if extra and extra.children and extra.children[1] and extra.children[1].children and extra.children[1].children[2] then
            extra.children[1].children[2].config.colour = card.joker_display_values.colour or G.C.UI.TEXT_INACTIVE
        end
    end
}
jd_def['j_SEMBY_misery'] = {
    text = {
        { border_nodes = {
            { text = "X" },
            { ref_table = "card.joker_display_values", ref_value = "xchips", retrigger_type = "exp" }
        }, border_colour = G.C.CHIPS },
        { text = " " },
        { border_nodes = {
            { text = "X" },
            { ref_table = "card.ability.extra", ref_value = "xmult", retrigger_type = "exp" }
        }, border_colour = G.C.MULT },
    },
    calc_function = function(card)
        card.joker_display_values.xchips = G.GAME.current_round.hands_played == 0 and card.ability.extra.xchips or 1
    end
}
jd_def['j_SEMBY_money_laundering'] = { } -- no info
jd_def['j_SEMBY_nashi_pear'] = {
    text = {
        { text = "+" }, { ref_table = "card.joker_display_values", ref_value = "score", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.SEMBY_PERCENT_L },
    calc_function = function(card)
        card.joker_display_values.score = math.floor(card.ability.extra.score_base * card.ability.extra.state + 0.5)
    end
}
jd_def['j_SEMBY_oblivion'] = {
    text = {
        { text = "+$", colour = G.C.MONEY }, { ref_table = "card.joker_display_values", ref_value = "payout", colour = G.C.MONEY },
        { text = " +" }, { ref_table = "card.joker_display_values", ref_value = "difficulty" }, { text = "%" }
    },
    text_config = { colour = G.C.SEMBY_PERCENT_L },
    reminder_text = {
        { text = "(" }, { ref_table = "card.joker_display_values", ref_value = "ante" }, { text = ")" }
    },
    extra = { {
        { ref_table = "card.joker_display_values", ref_value = "loop" },
    } },
    extra_config = { colour = G.C.UI.TEXT_INACTIVE, scale = 0.35 },
    calc_function = function(card)
        card.joker_display_values.loop = localize{type = 'variable', key = 'SEMBY_loop', vars = { math.floor(card.ability.extra.loop) }}
        card.joker_display_values.payout = G.GAME.blind and G.GAME.blind.boss and card.ability.extra.payout or 0
        card.joker_display_values.difficulty = card.ability.extra.difficulty * 100
        card.joker_display_values.ante = localize('k_ante')..' '..(card.ability.extra.highest_ante or G.GAME.round_resets.ante or 1)
    end
}
jd_def['j_SEMBY_obscure_ritual'] = {
    reminder_text = {
        { text = "(" }, { ref_table = "card.joker_display_values", ref_value = "active_text" }, { text = ")" },
    },
    calc_function = function(card)
        card.joker_display_values.active_text = localize("jdis_"..(card.ability.extra.active and "active" or "inactive"))
    end,
    style_function = function(card, text, reminder_text, extra)
        if reminder_text and reminder_text.children and reminder_text.children[2] then
            reminder_text.children[2].config.colour = card.ability.extra.active and G.C.GREEN or G.C.UI.TEXT_INACTIVE
        end
    end
}
jd_def['j_SEMBY_opulent_skint'] = { } -- no info
jd_def['j_SEMBY_ouroboros'] = {
    text = {
        { text = "+", colour = G.C.BLUE },
        { ref_table = "card.joker_display_values", ref_value = "hands", retrigger_type = "mult", colour = G.C.BLUE },
        { text = " +" },
        { ref_table = "card.joker_display_values", ref_value = "percent", retrigger_type = SEMBY_Increase },
        { text = "%" }
    },
    text_config = { colour = G.C.SEMBY_PERCENT_L },
    --reminder_text = { { text = "( 8 )" } },
    calc_function = function(card)
        local count = 0
        local text, _, scoring_hand = JokerDisplay.evaluate_hand()
        if text ~= 'Unknown' then
            for _, scoring_card in pairs(scoring_hand) do
                if scoring_card:get_id() == 8 then
                    count = count + JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
                end
            end
        end
        card.joker_display_values.hands = count
        card.joker_display_values.percent = (1 + card.ability.extra.percent) ^ count
    end
}
jd_def['j_SEMBY_parking_disc'] = { --> #ScuffedDisc
    text = {
        { border_nodes = {
            { ref_table = "card.joker_display_values", ref_value = "pre_val" },
            { ref_table = "card.joker_display_values", ref_value = "main_val", retrigger_type = "mult" },
            { ref_table = "card.joker_display_values", ref_value = "post_val" },
        }, border_colour = G.C.CLEAR }
    },
    calc_function = function(card)
        local state = card.ability.extra.index.s12 or card.ability.extra.index.main
        if card.joker_display_values.state and card.joker_display_values.state == state then
            if state == 3 then
                local copied_joker
                if card.area and not card.area.config.collection then
		            for i = 1, #card.area.cards do
		            	if card.area.cards[i] == card then
                            copied_joker = card.area.cards[i - 1]
                            break
		            	end
		            end
                end
                if copied_joker and copied_joker.config.center.blueprint_compat then
                    card.joker_display_values.pre_val = 'X'
                    card.joker_display_values.main_val = card.ability.extra.value.main
                    card.joker_display_values.post_val = ' '..localize('k_compatible')
                    card.joker_display_values.text_colour = G.C.GREEN
                else
                    card.joker_display_values.pre_val = ''
                    card.joker_display_values.main_val = localize('k_incompatible')
                    card.joker_display_values.post_val = ''
                    card.joker_display_values.text_colour = G.C.RED
                end
            elseif state == 5 then
                local _, _, scoring_hand = JokerDisplay.evaluate_hand()
                card.joker_display_values.main_val = scoring_hand and card.ability.extra.value.main * #scoring_hand or 0
            end
            if card.joker_display_values.redraw then
                card.joker_display_values.redraw = false
                card:update_joker_display(true, true, 'self')
            end
        else --print('New State: '..state)
            local pre_val, main_val, post_val, retrigger_type, text_colour, border_colour
            if     state ==  0 then -- setup
                pre_val = '.'; main_val = '.'; post_val = G.GAME.SEMBY_random_parking and '?' or '.'
                text_colour = G.C.UI.TEXT_INACTIVE
            elseif state ==  1 then -- handsize
                pre_val = '+'
                retrigger_type = 'mult'
                text_colour = G.C.IMPORTANT
            elseif state ==  2 then -- xmult
                pre_val = 'X'
                retrigger_type = 'exp'
                border_colour = G.C.MULT
            elseif state ==  3 then -- blueprint
                main_val = localize('k_incompatible')
                retrigger_type = 'mult'
                text_colour = G.C.RED
            elseif state ==  4 then -- discards
                pre_val = '+'
                retrigger_type = 'mult'
                text_colour = G.C.RED
            elseif state ==  5 then -- mult
                pre_val = '+'
                main_val = 0
                retrigger_type = 'mult'
                text_colour = G.C.RED
            elseif state ==  6 then -- consumables
                pre_val = '+'
                retrigger_type = 'mult'
                text_colour = G.C.IMPORTANT
            elseif state ==  7 then -- xchips
                pre_val = 'X'
                retrigger_type = 'exp'
                border_colour = G.C.CHIPS
            elseif state ==  8 then -- money
                pre_val = '+$'
                retrigger_type = 'mult'
                text_colour = G.C.MONEY
            elseif state ==  9 then -- percent
                pre_val = '-'
                main_val = (1 - card.ability.extra.value.main)
                post_val = '%'
                retrigger_type = SEMBY_Reduce
                text_colour = G.C.SEMBY_PERCENT_L
            elseif state == 10 then -- chips
                pre_val = '+'
                retrigger_type = 'mult'
                text_colour = G.C.CHIPS
            elseif state == 11 then -- retrigger
                pre_val = '+'
                retrigger_type = 'mult'
                text_colour = G.C.IMPORTANT
            elseif state == 12 then -- random + stat_mult
                pre_val = '?'; main_val = '?'; post_val = '?'
                text_colour = G.C.UI.TEXT_INACTIVE
            else-- Fallback/Unknown -- ???
                main_val = 'ERROR'
                text_colour = { 1, 0, 1, 1 }
            end
            card.joker_display_values.state = state
            card.joker_display_values.pre_val = pre_val or ''
            card.joker_display_values.main_val = main_val or card.ability.extra.value.main
            card.joker_display_values.post_val = post_val or ''
            card.joker_display_values.retrigger_type = retrigger_type or nil
            card.joker_display_values.text_colour = text_colour or G.C.UI.TEXT_LIGHT
            card.joker_display_values.border_colour = border_colour or G.C.CLEAR
            card.joker_display_values.redraw = true
        end
    end,
    retrigger_function = function(playing_card, scoring_hand, held_in_hand, joker_card)
        if not held_in_hand and joker_card and joker_card.joker_display_values
        and joker_card.joker_display_values.state and joker_card.joker_display_values.state == 11 then
            return (joker_card.joker_display_values.main_val or 1) * (JokerDisplay.calculate_joker_triggers(joker_card) or 0)
        end
    end,
    style_function = function(card, text, reminder_text, extra)
        if card and card.joker_display_values and card.joker_display_values.state then
            if text and text.children and text.children[1] then
                text.children[1].config.colour = card.joker_display_values.border_colour or G.C.CLEAR
                if text.children[1].children[1] then -- pre_val
                    text.children[1].children[1].config.colour = card.joker_display_values.text_colour or G.C.UI.TEXT_LIGHT
                end
                if text.children[1].children[2] then -- main_val
                    text.children[1].children[2].config.colour = card.joker_display_values.text_colour or G.C.UI.TEXT_LIGHT
                    text.children[1].children[2].config.retrigger_type = card.joker_display_values.retrigger_type or 'mult'
                end
                if text.children[1].children[3] then -- post_val
                    text.children[1].children[3].config.colour = card.joker_display_values.text_colour or G.C.UI.TEXT_LIGHT
                end
            end
        end
    end
}
jd_def['j_SEMBY_pay_two_win'] = {
    text = {
        { text = "+" }, { ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.MULT },
    reminder_text = {
        { text = "(" },
        { text = "-$", colour = G.C.MONEY },
        { ref_table = "card.ability.extra", ref_value = "spend", retrigger_type = "mult", colour = G.C.MONEY },
        { text = ")" },
    },
    calc_function = function(card)
        if G.GAME.dollars - card.ability.extra.spend >= G.GAME.bankrupt_at then
            card.joker_display_values.mult = card.ability.extra.mult
        else card.joker_display_values.mult = 0 end
    end
}
jd_def['j_SEMBY_perfect_pitch'] = {
    text = {
        { border_nodes = {
            { text = "X" }, { ref_table = "card.joker_display_values", ref_value = "xmult", retrigger_type = "exp" }
        }, border_colour = G.C.MULT }
    },
    reminder_text = {
        { text = "(" },
        { ref_table = "card.ability.extra.scoring", ref_value = "state", colour = G.C.IMPORTANT },
        { ref_table = "card.joker_display_values", ref_value = "localized_text" },
        { text = ")" },
    },
    calc_function = function(card)
        if G.GAME.blind and G.GAME.blind.in_blind then
            local _, _, scoring_hand = JokerDisplay.evaluate_hand()
            card.joker_display_values.xmult = #scoring_hand == card.ability.extra.scoring.state and card.ability.extra.xmult or 1.0
        else card.joker_display_values.xmult = 1.0 end
        card.joker_display_values.localized_text = ' '..localize('SEMBY_cards')
    end
}
jd_def['j_SEMBY_pet_plastic'] = {
    text = {
        { text = "+" }, { ref_table = "card.ability.extra", ref_value = "mult", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.MULT }
}
jd_def['j_SEMBY_piggy_bank'] = {
    text = {
        { border_nodes = {
            { text = "X" }, { ref_table = "card.joker_display_values", ref_value = "xmult", retrigger_type = "exp" }
        }, border_colour = G.C.MULT }
    },
    calc_function = function(card)
        card.joker_display_values.xmult = 1.0 + math.floor(card.sell_cost / card.ability.extra.value_mod) * card.ability.extra.xmult_mod
    end
}
jd_def['j_SEMBY_pinata'] = { } -- no info
jd_def['j_SEMBY_plastic_key'] = { } -- no info
jd_def['j_SEMBY_pocket_dimension'] = {
    text = {
        { border_nodes = {
            { text = "X" }, { ref_table = "card.joker_display_values", ref_value = "xmult", retrigger_type = "exp" }
        }, border_colour = G.C.MULT }
    },
    calc_function = function(card)
        local count = G.consumeables and #G.consumeables.cards or 0
        card.joker_display_values.xmult = card.ability.extra.xmult ^ count
    end
}
jd_def['j_SEMBY_potted_flowers'] = {
    text = {
        { border_nodes = {
            { text = "X" }, { ref_table = "card.joker_display_values", ref_value = "xchips", retrigger_type = "exp" }
        }, border_colour = G.C.CHIPS }
    },
    reminder_text = {
        { text = "(" },
        { ref_table = "card.ability.extra", ref_value = "suits", colour = G.C.IMPORTANT },
        { ref_table = "card.joker_display_values", ref_value = "localized_text" },
        { text = ")" },
    },
    calc_function = function(card)
        card.joker_display_values.update_timer = (card.joker_display_values.update_timer or NORM_UPDATE) + 1
        if card.joker_display_values.update_timer > NORM_UPDATE then
            card.joker_display_values.update_timer = 0
            local text, _, scoring_hand = JokerDisplay.evaluate_hand()
            if text ~= 'Unknown' and #scoring_hand >= card.ability.extra.suits
            and SEMBY_count_suits(scoring_hand) >= card.ability.extra.suits then
                card.joker_display_values.xchips = card.ability.extra.xchips
            else card.joker_display_values.xchips = 1.0 end
            card.joker_display_values.localized_text = ' '..localize('SEMBY_suits')
        end
    end
}
jd_def['j_SEMBY_quest'] = {
    text = {
        { ref_table = "card.joker_display_values", ref_value = "main_text" },
        { ref_table = "card.joker_display_values", ref_value = "post_text", colour = G.C.UI.TEXT_INACTIVE }
    },
    reminder_text = {
        { text = "(" }, { ref_table = "card.joker_display_values", ref_value = "active_text" }, { text = ")" }
    },
    calc_function = function(card)
        if card.ability.extra.quest.complete then
            card.joker_display_values.main_text = localize('SEMBY_quest_completed')
            card.joker_display_values.post_text = ''
            card.joker_display_values.colour = G.C.GREEN
            card.joker_display_values.active = false
            card.joker_display_values.active_text = card.ability.extra.major..'/'..card.ability.extra.target
        else
            card.joker_display_values.main_text = card.ability.extra.major
            card.joker_display_values.post_text = '/'..card.ability.extra.target
            if not card.joker_display_values.colour then
                local category = card.ability.extra.quest.category
                if category == "hand" then
                    card.joker_display_values.colour = G.C.BLUE
                elseif category == "discard" then
                    card.joker_display_values.colour = G.C.RED
                elseif category == "money" then
                    card.joker_display_values.colour = G.C.MONEY
                elseif category == "consumable" then
                    card.joker_display_values.colour = G.C.IMPORTANT
                elseif category == "joker" then
                    card.joker_display_values.colour = G.C.IMPORTANT
                end
            end
            card.joker_display_values.active = not card.ability.extra.quest.reset
            card.joker_display_values.active_text = localize('jdis_'..(card.joker_display_values.active and 'active' or 'inactive'))
        end
    end,
    style_function = function(card, text, reminder_text, extra)
        if card.joker_display_values then
            if text and text.children and text.children[1] then
                text.children[1].config.colour = card.joker_display_values.colour or G.C.UI.TEXT_INACTIVE
            end
            if reminder_text and reminder_text.children and reminder_text.children[2] then
                reminder_text.children[2].config.colour = card.joker_display_values.active and G.C.GREEN or G.C.UI.TEXT_INACTIVE
            end
        end
    end
}
jd_def['j_SEMBY_reagent'] = {
    text = {
        { border_nodes = {
            { text = "X" }, { ref_table = "card.joker_display_values", ref_value = "xmult", retrigger_type = "exp" }
        }, border_colour = G.C.MULT }
    },
    calc_function = function(card)
        card.joker_display_values.update_timer = (card.joker_display_values.update_timer or NORM_UPDATE) + 1
        if card.joker_display_values.update_timer > NORM_UPDATE then
            card.joker_display_values.update_timer = 0
            local xmult = card.ability.extra.xmult
            for _, playing_card in ipairs(G.playing_cards or {}) do
		    	if xmult > 1.0 then
		    		if next(SMODS.get_enhancements(playing_card)) then
		    			xmult = xmult - card.ability.extra.xmult_mod
		    		end
		    	else break end
            end
            card.joker_display_values.xmult = xmult
        end
    end
}
jd_def['j_SEMBY_red_mask'] = {
    text = {
        { text = "+" }, { ref_table = "card.ability.extra", ref_value = "chips", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.CHIPS }
}
jd_def['j_SEMBY_ripped_joker'] = {
    text = {
        { text = "+" }, { ref_table = "card.joker_display_values", ref_value = "chips", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.CHIPS },
    calc_function = function(card)
        local hand = JokerDisplay.current_hand
        card.joker_display_values.chips = hand and #hand > 0 and #hand <= card.ability.extra.size and card.ability.extra.chips or 0
    end
}
jd_def['j_SEMBY_risky_joker'] = {
    text = {
        { text = "-", colour = G.C.CHIPS },
        { ref_table = "card.joker_display_values", ref_value = "chips", retrigger_type = "mult", colour = G.C.CHIPS },
        { text = " -", colour = G.C.MULT },
        { ref_table = "card.joker_display_values", ref_value = "mult",  retrigger_type = "mult", colour = G.C.MULT  },
    },
    reminder_text = {
        { text = "(" },
        { text = "$", colour = G.C.MONEY },
        { ref_table = "card.ability.extra", ref_value = "payout", colour = G.C.MONEY },
        { text = ")" },
        { ref_table = "card.joker_display_values", ref_value = "money_text", colour = G.C.MONEY },
        { ref_table = "card.joker_display_values", ref_value = "money_value", retrigger_type = "mult", colour = G.C.MONEY },
    },
    calc_function = function(card)
        local chips, mult, money = 0, 0, 0
        local text, _, scoring_hand = JokerDisplay.evaluate_hand()
        if text ~= 'Unknown' then
            for _, scoring_card in pairs(scoring_hand) do
                local retriggers = JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
                chips = chips + card.ability.extra.chips * retriggers
                mult = mult + card.ability.extra.mult * retriggers
                money = money + card.ability.extra.gold * retriggers
            end
        end
        card.joker_display_values.chips = chips
        card.joker_display_values.mult = mult
        if money ~= 0 then
            card.joker_display_values.money_text = ' +$'
            card.joker_display_values.money_value = money
        else
            card.joker_display_values.money_text = ''
            card.joker_display_values.money_value = ''
        end
    end
}
jd_def['j_SEMBY_scaffolding'] = {
    reminder_text = {
        { text = "(" }, { ref_table = "card.joker_display_values", ref_value = "size" }, { text = ")" },
    },
    calc_function = function(card)
        local csize = card.ability.extra.current
        card.joker_display_values.size = (csize >= 0 and '+' or '')..csize
        card.joker_display_values.colour = csize > 0 and G.C.GREEN or csize == 0 and G.C.IMPORTANT or G.C.RED
    end,
    style_function = function(card, text, reminder_text, extra)
        if reminder_text and reminder_text.children[2] and card.joker_display_values then
            reminder_text.children[2].config.colour = card.joker_display_values.colour or G.C.UI.TEXT_INACTIVE
        end
    end
}
jd_def['j_SEMBY_seven_wonders'] = {
    text = {
        { text = "-" }, { ref_table = "card.joker_display_values", ref_value = "percent", retrigger_type = SEMBY_Reduce }, { text = "%" },
    },
    text_config = { colour = G.C.SEMBY_PERCENT_L },
    calc_function = function(card)
        card.joker_display_values.update_timer = (card.joker_display_values.update_timer or NORM_UPDATE) + 1
        if card.joker_display_values.update_timer > NORM_UPDATE then
            card.joker_display_values.update_timer = 0
            local seven_tally = 0
		    for _, playing_card in ipairs(G.playing_cards or {}) do
		    	if playing_card:get_id() == 7 then seven_tally = seven_tally + 1 end
		    end
            card.joker_display_values.percent = 1 - math.min(card.ability.extra.percent_max, seven_tally * card.ability.extra.percent_mod)
        end
    end
}
jd_def['j_SEMBY_shooting_star'] = { } -- no info
jd_def['j_SEMBY_silver_mask'] = {
    text = {
        { text = "+$" }, { ref_table = "card.joker_display_values", ref_value = "money" },
    },
    text_config = { colour = G.C.MONEY },
    reminder_text = {
        { ref_table = "card.joker_display_values", ref_value = "localized_text" },
    },
    calc_function = function(card)
        card.joker_display_values.money =
            G.hand and math.max(0, card.ability.extra.gold - (G.hand.config.card_limit * card.ability.extra.goldmod))
            or card.ability.extra.gold
        card.joker_display_values.localized_text = "(" .. localize("k_round") .. ")"
    end
}
jd_def['j_SEMBY_singularity'] = {
    text = {
        { text = "+", colour = G.C.IMPORTANT },
        { ref_table = "card.joker_display_values", ref_value = "cards", retrigger_type = "mult", colour = G.C.IMPORTANT },
        { ref_table = "card.joker_display_values", ref_value = "localized_text" },
    },
    --reminder_text = {
    --    { ref_table = "card.joker_display_values", ref_value = "created" },
    --},
    calc_function = function(card)
        -- Main:
        local count = 0
        local text, _, scoring_hand = JokerDisplay.evaluate_hand()
        if text ~= 'Unknown' then
            for _, scoring_card in pairs(scoring_hand) do
                if scoring_card.ability and not scoring_card.ability.SEMBY_event_horizon then
                    count = count + JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
                end
            end
        end
        card.joker_display_values.cards = count
        card.joker_display_values.localized_text = ' '..localize('SEMBY_cards')
        -- Reminder:
        --card.joker_display_values.update_timer = (card.joker_display_values.update_timer or NORM_UPDATE) + 1
        --if card.joker_display_values.update_timer > NORM_UPDATE then
        --    card.joker_display_values.update_timer = 0
        --    local created = 0
		--    for _, playing_card in ipairs(G.playing_cards or {}) do
		--    	if playing_card.ability.SEMBY_event_horizon == card.sort_id then
        --              created = created + 1
        --          end
		--    end
        --    card.joker_display_values.created = '('..created..' '..localize('SEMBY_cards')..')'
        --end
    end
}
jd_def['j_SEMBY_stern_teacher'] = {
    text = {
        { text = "+" }, { ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.MULT },
    calc_function = function(card)
        local debuffed = 0
        for _, joker in ipairs(G.jokers and G.jokers.cards or {}) do
            if joker.debuff then debuffed = debuffed + 1 end
        end
        card.joker_display_values.mult = debuffed * card.ability.extra.mult
    end
}
jd_def['j_SEMBY_stylish_joker'] = {
    text = {
        { text = "+$" }, { ref_table = "card.joker_display_values", ref_value = "money" },
    },
    text_config = { colour = G.C.MONEY },
    reminder_text = {
        { ref_table = "card.joker_display_values", ref_value = "localized_text" },
    },
    calc_function = function(card)
        card.joker_display_values.money = (G.consumeables and #G.consumeables.cards or 0) * card.ability.extra.gold
        card.joker_display_values.localized_text = "(" .. localize("k_round") .. ")"
    end
}
jd_def['j_SEMBY_stocked_shelves'] = {
    --text = { { text = '' } },
    extra = { {
        { text = "(" },
        { ref_table = "card.ability.extra", ref_value = "durability" },
        { text = "/" },
        { ref_table = "card.ability.extra", ref_value = "durability_max" },
        { text = ")" },
    } },
    extra_config = { colour = G.C.UI.TEXT_INACTIVE, scale = 0.3 },
    calc_function = function(card)
        card.joker_display_values.colour = card:SEMBY_durability_color(true)
    end,
    style_function = function(card, text, reminder_text, extra)
        if extra and extra.children and extra.children[1] and extra.children[1].children and extra.children[1].children[2] then
            extra.children[1].children[2].config.colour = card.joker_display_values.colour or G.C.UI.TEXT_INACTIVE
        end
    end
}
jd_def['j_SEMBY_swordswallower'] = {
    text = {
        { border_nodes = {
            { text = "X" }, { ref_table = "card.joker_display_values", ref_value = "xmult", retrigger_type = "exp" },
        }, border_colour = G.C.MULT }
    },
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "count", retrigger_type = "mult" },
        { text = "x" },
        { ref_table = "card.joker_display_values", ref_value = "localized_text", colour = (G.C.RARITY.Common or G.C.BLUE) },
        { text = ")" },
    },
    calc_function = function(card)
		local common = 0
        for _, joker in ipairs(G.jokers and G.jokers.cards or {}) do
            if joker.config.center.rarity == 1 then common = common + 1 end
        end
        card.joker_display_values.count = common
        card.joker_display_values.xmult = 1 + common * card.ability.extra.Xmult
        card.joker_display_values.localized_text = localize('k_common')
    end
}
jd_def['j_SEMBY_t3mprr'] = {
    text = {
        { text = "-" }, { ref_table = "card.joker_display_values", ref_value = "percent_reduce", retrigger_type = SEMBY_Reduce }, { text = "%" },
    },
    text_config = { colour = G.C.SEMBY_PERCENT_L },
    reminder_text = {
        { text = "(", colour = G.C.UI.TEXT_INACTIVE },
        { text = "+" }, { ref_table = "card.joker_display_values", ref_value = "percent_increase" }, { text = "%" },
        { text = ")", colour = G.C.UI.TEXT_INACTIVE }
    },
    reminder_text_config = { colour = G.C.SEMBY_PERCENT_L },
    calc_function = function(card)
        local percent = 0
        local hand = JokerDisplay.current_hand
        for _, playing_card in pairs(hand) do
            percent = percent + JokerDisplay.calculate_card_triggers(playing_card, hand)
        end
        card.joker_display_values.percent_reduce = (1 - card.ability.extra.push_down) ^ percent
        card.joker_display_values.percent_increase = card.ability.extra.clock_up * 100
    end
}
jd_def['j_SEMBY_target_plush'] = {
    text = {
        { text = "+", colour = G.C.CHIPS },
        { ref_table = "card.joker_display_values", ref_value = "chips", colour = G.C.CHIPS, retrigger_type = "mult" },
        { text = " +", colour = G.C.MULT },
        { ref_table = "card.joker_display_values", ref_value = "mult",  colour = G.C.MULT,  retrigger_type = "mult" },
    },
    calc_function = function(card)
		local jokers = 0
		local joke_limit = 0
		if G.jokers then
			jokers = #G.jokers.cards
			joke_limit = math.max(0, G.jokers.config.card_limit - jokers)
		end
        card.joker_display_values.chips = jokers * card.ability.extra.chips
        card.joker_display_values.mult = joke_limit * card.ability.extra.mult
    end
}
jd_def['j_SEMBY_tempered_glass'] = {
    reminder_text = {
        { text = "(" }, { ref_table = "card.joker_display_values", ref_value = "localized_text" }, { text = ")" }
    },
    calc_function = function(card)
        card.joker_display_values.localized_text = localize{ type = 'name_text', set = 'Enhanced', key = 'm_glass' }
    end
}
jd_def['j_SEMBY_the_dwarf'] = { } -- no info
jd_def['j_SEMBY_the_giant'] = { } -- no info
jd_def['j_SEMBY_TMTRAINER'] = {   -- fluff info
    text = { { ref_table = "card.joker_display_values", ref_value = "TMTRAINER" }, { text = "%" } },
    text_config = { colour = G.C.SEMBY_TMTRAINER_L },
    calc_function = function(card)
        card.joker_display_values.update_timer = (card.joker_display_values.update_timer or SLOW_UPDATE) + 1
        if card.joker_display_values.update_timer > SLOW_UPDATE then
            card.joker_display_values.update_timer = 0
            card.joker_display_values.TMTRAINER = math.floor(math.random(
                (1-card.ability.extra.SEMBY_TMTR_MIN)*100, card.ability.extra.SEMBY_TMTR_MAX*100
            ))
        end
    end
}
jd_def['j_SEMBY_to_and_fro'] = { } -- no info
jd_def['j_SEMBY_tool_axe'] = {
    text = {
        { ref_table = "card.joker_display_values", ref_value = "count", retrigger_type = "mult" }, { text = "x", scale = 0.35 },
        { ref_table = "card.joker_display_values", ref_value = "localized_text", colour = G.C.RED },
    },
    reminder_text = {
        { text = "(" }, { ref_table = "card.joker_display_values", ref_value = "suit" }, { text = ")" },
    },
    extra = { {
        { text = "(", colour = G.C.GREEN, scale = 0.3 },
        { ref_table = "card.joker_display_values", ref_value = "odds", colour = G.C.GREEN, scale = 0.3 },
        { text = ")", colour = G.C.GREEN, scale = 0.3 },
    }, {
        { text = "(" },
        { ref_table = "card.ability.extra", ref_value = "durability" },
        { text = "/" },
        { ref_table = "card.ability.extra", ref_value = "durability_max" },
        { text = ")" },
    } },
    extra_config = { colour = G.C.UI.TEXT_INACTIVE, scale = 0.3 },
    calc_function = function(card)
        card.joker_display_values.update_timer = (card.joker_display_values.update_timer or FAST_UPDATE) + 1
        if card.joker_display_values.update_timer > FAST_UPDATE then
            card.joker_display_values.update_timer = 0
            local count = 0
            local playing_hand = next(G.play.cards)
            local suit = (G.GAME.current_round.SEMBY_tool_suit or {}).suit or 'Spades'
            for _, playing_card in ipairs(G.hand.cards) do
                if playing_hand or not playing_card.highlighted then
                    if playing_card.facing and not (playing_card.facing == 'back')
                    and not playing_card.debuff and playing_card:is_suit(suit) then
                        count = count + JokerDisplay.calculate_card_triggers(playing_card, nil, true)
                    end
                end
            end
            local numerator, denominator = SMODS.get_probability_vars(card,
                card.ability.extra.numerator, card.ability.extra.denominator, 'JokerDisplay')
            card.joker_display_values.odds = localize{type = 'variable', key = "jdis_odds", vars = { numerator, denominator }}
            card.joker_display_values.localized_text = localize('SEMBY_axed')
            card.joker_display_values.count = math.min(count, card.ability.extra.durability)
            card.joker_display_values.suit = localize(suit, 'suits_plural')
            card.joker_display_values.colour = card:SEMBY_durability_color(true)
        end
    end,
    style_function = function(card, text, reminder_text, extra)
        if reminder_text and reminder_text.children[2] then
            local suit = (G.GAME.current_round.SEMBY_tool_suit or {}).suit or 'Spades'
            reminder_text.children[2].config.colour = lighten(G.C.SUITS[suit], 0.35)
        end
        if extra and extra.children and extra.children[1] and extra.children[1].children and extra.children[1].children[2] then
            extra.children[1].children[2].config.colour = card.joker_display_values.colour or G.C.UI.TEXT_INACTIVE
        end
    end
}
jd_def['j_SEMBY_tool_hoe'] = {
    text = {
        { text = "+" }, { ref_table = "card.joker_display_values", ref_value = "chips", retrigger_type = "mult" },
    },
    text_config = { colour = G.C.CHIPS },
    reminder_text = {
        { text = "(" }, { ref_table = "card.joker_display_values", ref_value = "suit" }, { text = ")" },
    },
    extra = { {
        { text = "(" },
        { ref_table = "card.ability.extra", ref_value = "durability" },
        { text = "/" },
        { ref_table = "card.ability.extra", ref_value = "durability_max" },
        { text = ")" },
    } },
    extra_config = { colour = G.C.UI.TEXT_INACTIVE, scale = 0.3 },
    calc_function = function(card)
        card.joker_display_values.update_timer = (card.joker_display_values.update_timer or FAST_UPDATE) + 1
        if card.joker_display_values.update_timer > FAST_UPDATE then
            card.joker_display_values.update_timer = 0
            local chips = 0
            local playing_hand = next(G.play.cards)
            local suit = (G.GAME.current_round.SEMBY_tool_suit or {}).suit or 'Spades'
            for _, playing_card in ipairs(G.hand.cards) do
                if playing_hand or not playing_card.highlighted then
                    if playing_card.facing and not (playing_card.facing == 'back')
                    and not playing_card.debuff and playing_card:is_suit(suit) then
                        chips = chips + JokerDisplay.calculate_card_triggers(playing_card, nil, true)
                    end
                end
            end
            card.joker_display_values.chips = math.min(chips, card.ability.extra.durability) * card.ability.extra.chips
            card.joker_display_values.suit = localize(suit, 'suits_plural')
            card.joker_display_values.colour = card:SEMBY_durability_color(true)
        end
    end,
    style_function = function(card, text, reminder_text, extra)
        if reminder_text and reminder_text.children[2] then
            local suit = (G.GAME.current_round.SEMBY_tool_suit or {}).suit or 'Spades'
            reminder_text.children[2].config.colour = lighten(G.C.SUITS[suit], 0.35)
        end
        if extra and extra.children and extra.children[1] and extra.children[1].children and extra.children[1].children[2] then
            extra.children[1].children[2].config.colour = card.joker_display_values.colour or G.C.UI.TEXT_INACTIVE
        end
    end
}
jd_def['j_SEMBY_tool_pickaxe'] = {
    text = {
        { ref_table = "card.joker_display_values", ref_value = "count", retrigger_type = "mult" }, { text = "x", scale = 0.35 },
        { text = "$", colour = G.C.MONEY }, { ref_table = "card.ability.extra", ref_value = "dollars", colour = G.C.MONEY },
    },
    reminder_text = {
        { text = "(" }, { ref_table = "card.joker_display_values", ref_value = "suit" }, { text = ")" },
    },
    extra = { {
        { text = "(", colour = G.C.GREEN, scale = 0.3 },
        { ref_table = "card.joker_display_values", ref_value = "odds", colour = G.C.GREEN, scale = 0.3 },
        { text = ")", colour = G.C.GREEN, scale = 0.3 },
    }, {
        { text = "(" },
        { ref_table = "card.ability.extra", ref_value = "durability" },
        { text = "/" },
        { ref_table = "card.ability.extra", ref_value = "durability_max" },
        { text = ")" },
    } },
    extra_config = { colour = G.C.UI.TEXT_INACTIVE, scale = 0.3 },
    calc_function = function(card)
        card.joker_display_values.update_timer = (card.joker_display_values.update_timer or FAST_UPDATE) + 1
        if card.joker_display_values.update_timer > FAST_UPDATE then
            card.joker_display_values.update_timer = 0
            local count = 0
            local playing_hand = next(G.play.cards)
            local suit = (G.GAME.current_round.SEMBY_tool_suit or {}).suit or 'Spades'
            for _, playing_card in ipairs(G.hand.cards) do
                if playing_hand or not playing_card.highlighted then
                    if playing_card.facing and not (playing_card.facing == 'back')
                    and not playing_card.debuff and playing_card:is_suit(suit) then
                        count = count + JokerDisplay.calculate_card_triggers(playing_card, nil, true)
                    end
                end
            end
            local numerator, denominator = SMODS.get_probability_vars(card,
                card.ability.extra.numerator, card.ability.extra.denominator, 'JokerDisplay')
            card.joker_display_values.odds = localize{type = 'variable', key = "jdis_odds", vars = { numerator, denominator }}
            card.joker_display_values.count = math.min(count, card.ability.extra.durability)
            card.joker_display_values.suit = localize(suit, 'suits_plural')
            card.joker_display_values.colour = card:SEMBY_durability_color(true)
        end
    end,
    style_function = function(card, text, reminder_text, extra)
        if reminder_text and reminder_text.children[2] then
            local suit = (G.GAME.current_round.SEMBY_tool_suit or {}).suit or 'Spades'
            reminder_text.children[2].config.colour = lighten(G.C.SUITS[suit], 0.35)
        end
        if extra and extra.children and extra.children[1] and extra.children[1].children and extra.children[1].children[2] then
            extra.children[1].children[2].config.colour = card.joker_display_values.colour or G.C.UI.TEXT_INACTIVE
        end
    end
}
jd_def['j_SEMBY_tool_shovel'] = {
    text = {
        { border_nodes = {
            { text = "X" }, { ref_table = "card.joker_display_values", ref_value = "xmult", retrigger_type = "exp" },
        }, border_colour = G.C.MULT }
    },
    reminder_text = {
        { text = "(" }, { ref_table = "card.joker_display_values", ref_value = "suit" }, { text = ")" },
    },
    extra = { {
        { text = "(" },
        { ref_table = "card.ability.extra", ref_value = "durability" },
        { text = "/" },
        { ref_table = "card.ability.extra", ref_value = "durability_max" },
        { text = ")" },
    } },
    extra_config = { colour = G.C.UI.TEXT_INACTIVE, scale = 0.3 },
    calc_function = function(card)
        card.joker_display_values.update_timer = (card.joker_display_values.update_timer or FAST_UPDATE) + 1
        if card.joker_display_values.update_timer > FAST_UPDATE then
            card.joker_display_values.update_timer = 0
            local xmult = 0
            local playing_hand = next(G.play.cards)
            local suit = (G.GAME.current_round.SEMBY_tool_suit or {}).suit or 'Spades'
            for _, playing_card in ipairs(G.hand.cards) do
                if playing_hand or not playing_card.highlighted then
                    if playing_card.facing and not (playing_card.facing == 'back')
                    and not playing_card.debuff and playing_card:is_suit(suit) then
                        xmult = xmult + JokerDisplay.calculate_card_triggers(playing_card, nil, true)
                    end
                end
            end
            card.joker_display_values.xmult = card.ability.extra.xmult ^ math.min(xmult, card.ability.extra.durability)
            card.joker_display_values.suit = localize(suit, 'suits_plural')
            card.joker_display_values.colour = card:SEMBY_durability_color(true)
        end
    end,
    style_function = function(card, text, reminder_text, extra)
        if reminder_text and reminder_text.children[2] then
            local suit = (G.GAME.current_round.SEMBY_tool_suit or {}).suit or 'Spades'
            reminder_text.children[2].config.colour = lighten(G.C.SUITS[suit], 0.35)
        end
        if extra and extra.children and extra.children[1] and extra.children[1].children and extra.children[1].children[2] then
            extra.children[1].children[2].config.colour = card.joker_display_values.colour or G.C.UI.TEXT_INACTIVE
        end
    end
}
jd_def['j_SEMBY_toolkit'] = {
    extra = { {
        { text = "(" },
        { ref_table = "card.ability.extra", ref_value = "durability" },
        { text = "/" },
        { ref_table = "card.ability.extra", ref_value = "durability_max" },
        { text = ")" },
    } },
    extra_config = { colour = G.C.UI.TEXT_INACTIVE, scale = 0.3 },
    calc_function = function(card)
        card.joker_display_values.colour = card:SEMBY_durability_color(true)
    end,
    style_function = function(card, text, reminder_text, extra)
        if extra and extra.children and extra.children[1] and extra.children[1].children and extra.children[1].children[2] then
            extra.children[1].children[2].config.colour = card.joker_display_values.colour or G.C.UI.TEXT_INACTIVE
        end
    end
}
jd_def['j_SEMBY_twenty_to_die_for'] = { } -- no info
jd_def['j_SEMBY_unicorn'] = {
    text = {
        { text = "+" }, { ref_table = "card.joker_display_values", ref_value = "chips", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.CHIPS },
    calc_function = function(card)
        card.joker_display_values.update_timer = (card.joker_display_values.update_timer or SLOW_UPDATE) + 1
        if card.joker_display_values.update_timer > SLOW_UPDATE then
            card.joker_display_values.update_timer = 0
		    local abilities = {}
		    for i, playing_card in ipairs(G.playing_cards or {}) do
		    	if playing_card.edition then abilities[playing_card.edition.key] = true end
		    	if playing_card.seal then abilities[playing_card.seal] = true end
		    	for i, v in pairs(SMODS.get_enhancements(playing_card) or {}) do
		    		abilities[i] = v
		    	end
		    end
		    local amount = 0
		    for i, v in pairs(abilities) do
		    	amount = amount + 1
		    end
            card.joker_display_values.chips = amount * card.ability.extra.chips
        end
    end
}
jd_def['j_SEMBY_warm_embrace'] = { } -- no info
jd_def['j_SEMBY_watching_forest'] = {
    --text = {
    --    { ref_table = "card.joker_display_values", ref_value = "order_text" }
    --},
    --text_config = { colour = G.C.UI.TEXT_INACTIVE, scale = 0.35 },
    reminder_text = {
        { text = "(" }, { ref_table = "card.joker_display_values", ref_value = "remaining" }, { text = ")" },
    },
    calc_function = function(card)
        local remaining = card.ability.extra.remaining + (next(G.play.cards) and 1 or 0)
        local active = remaining % (card.ability.extra.every + 1) == 0
        card.joker_display_values.remaining = localize {
			type = 'variable',
			key = (active and 'loyalty_active' or 'loyalty_inactive'),
			vars = { remaining }
		}
        card.joker_display_values.colour = active and G.C.GREEN or nil
        --card.joker_display_values.order_text = localize('SEMBY_sort_'..card.ability.extra.order)
    end,
    style_function = function(card, text, reminder_text, extra)
        if reminder_text and reminder_text.children and reminder_text.children[2] and card.joker_display_values then
            reminder_text.children[2].config.colour = card.joker_display_values.colour or G.C.UI.TEXT_INACTIVE
        end
    end
}
-- ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## -- ##  ##  ##  ####  ##  ##  ##
-- ## CONSUMABLES :: Special Rulings                        ## -- ##  ##  ##  #  #  ##  ##  ##
-- ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## -- ###    ####  ##  ####    ###
jd_def['c_SEMBY_eden_spawner'] = {
    text = {
        { ref_table = "card.joker_display_values", ref_value = "tokens", colour = G.C.UI.TEXT_INACTIVE }
    },
    calc_function = function(card)
		if Shimmerberry.config.eden_enabled and not G.GAME.challenge then
            if Shimmerberry.config.eden_infinite then
                card.joker_display_values.tokens = localize('SEMBY_infinite')
                card.joker_display_values.colour = SMODS.Gradients.SEMBY_EDEN
            else
                local tokens = SEMBY_tonum(Shimmerberry.config.eden_tokens['P'..G.SETTINGS.profile] or 0)
                card.joker_display_values.tokens = tokens..' '..localize('SEMBY_tokens')
                card.joker_display_values.colour = tokens > 0 and G.C.BLUE or G.C.RED
            end
		else
            card.joker_display_values.tokens = '--'
            card.joker_display_values.colour = nil
        end
    end,
    style_function = function(card, text, reminder_text, extra)
        if text and text.children and text.children[1] and card.joker_display_values then
            text.children[1].config.colour = card.joker_display_values.colour or G.C.UI.TEXT_INACTIVE
        end
    end
}
-- ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## -- ##  ##  ##  ####  ##  ##  ##
-- ## EDITIONS :: Lovely Patched -> JokerDisplay.toml       ## -- ##  ##  ##  #  #  ##  ##  ##
-- ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## -- ###    ####  ##  ####    ###
jd_e_def['e_SEMBY_pearlescent'] = {
    condition_function = function(card)
        return not card.debuff and (card.edition or {}).percent and card.edition.key == 'e_SEMBY_pearlescent'
    end,
    mod_function = function(card)
        return { SEMBY_percent = -card.edition.percent }
    end
}
jd_e_def['e_SEMBY_resonance'] = {
    condition_function = function(card)
        return not card.debuff and (card.edition or {}).percent and card.edition.key == 'e_SEMBY_resonance'
    end,
    mod_function = function(card)
        return { SEMBY_percent = card.edition.percent }
    end
}
jd_e_def['e_SEMBY_shiny'] = {
    condition_function = function(card)
        return not card.debuff and (card.edition or {}).base_value and card.edition.key == 'e_SEMBY_shiny'
    end,
    mod_function = function(card)
        return { dollars = card.edition.base_value, SEMBY_round = true }
    end
}
-- ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## -- ##  ##  ##  ####  ##  ##  ##
-- ## BLINDS (aka "Metador Checks")                         ## -- ##  ##  ##  #  #  ##  ##  ##
-- ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## -- ###    ####  ##  ####    ###
jd_b_def['bl_SEMBY_frog'] = {
    trigger_function = function(blind, text, poker_hands, scoring_hand, full_hand)
        return true --> Triggers each Hand
    end
}
jd_b_def['bl_SEMBY_pencil'] = {
    trigger_function = function(blind, text, poker_hands, scoring_hand, full_hand)
        return true --> Triggers each Hand
    end
}
jd_b_def['bl_SEMBY_sharp_shooter'] = {
    trigger_function = function(blind, text, poker_hands, scoring_hand, full_hand)
        return true --> Triggers each Hand ... for some reason lol
    end
}
jd_b_def['bl_SEMBY_ghost'] = {
    trigger_function = function(blind, text, poker_hands, scoring_hand, full_hand)
        return false --> no trigger [start of blind]
    end
}
jd_b_def['bl_SEMBY_golden_egg'] = {
    trigger_function = function(blind, text, poker_hands, scoring_hand, full_hand)
        return false --> no trigger [start of blind]
    end
}
end
