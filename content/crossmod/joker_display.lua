-- hook "JokerDisplay.calculate_card_triggers = function(card, scoring_hand, held_in_hand)"
-- for my retrigger cards: Vintage Edition --> Hook/Patch "JokerDisplay.calculate_card_triggers = function(card, scoring_hand, held_in_hand)"
-- also support for "jevil"

-- !!! rework Flowerpot !!!

-- Add Editions to this
-- Add Consumables to this; Especially the Token from Eden Token

-- Clear all "##TODO##"s

--- Joker Display Definitions
--- Check Github Wiki for API details
--- https://github.com/nh6574/JokerDisplay/wiki

-- Always use "SMODS.has_enhancement" instead.
-- Make "j_SEMBY_boosterpack_joker" an extra text! --> durability always "extra" for others!

if Shimmerberry.compat.display then
local jd_def = JokerDisplay.Definitions
-- SEMBY Percent Support
G.C.SEMBY_PERCENT_L = lighten(G.C.SEMBY_PERCENT, 0.25)
local function SEMBY_Reduce(num, triggers)   return (1 - (triggers == 1 and num or num ^ triggers)) * 100  end
local function SEMBY_Increase(num, triggers) return ((triggers == 1 and num or num ^ triggers) - 1) * 100  end
-- SEMBY Jevil Hook
local trigger_calc_hook = JokerDisplay.calculate_card_triggers
function JokerDisplay.calculate_card_triggers(card, scoring_hand, held_in_hand)
    local ret_val = trigger_calc_hook(card, scoring_hand, held_in_hand)
    if G.GAME and G.GAME.SEMBY_jevil_scoring and scoring_hand then
        ret_val = ret_val * G.GAME.SEMBY_jevil_scoring
    end
    return ret_val
end

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
        local text, _, scoring_hand = JokerDisplay.evaluate_hand()
        if text ~= 'Unknown' then
            for _, scoring_card in pairs(scoring_hand) do
                if scoring_card.debuff then
                    debuffed = debuffed + 1
                end
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
					return card.area.cards[i - 1]
				end
			end
        end
        return nil
    end,
    retrigger_joker_function = function(card, retrigger_joker)
        if card and card == retrigger_joker then
            --##TODO## -> Check if correct
            return 2 --card.ability.extra.repeats - 1
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
                --if SMODS.has_enhancement(scoring_card, 'm_stone') then
                if scoring_card.ability.name and scoring_card.ability.name == 'Stone Card' then
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
        { text = "(" }, { ref_table = "card.joker_display_values", ref_value = "localized_text", colour = G.C.IMPORTANT }, { text = ")" }
    },
    calc_function = function(card)
        local percent = 0
        local text, _, scoring_hand = JokerDisplay.evaluate_hand()
        if text ~= 'Unknown' then
            for _, scoring_card in pairs(scoring_hand) do
                --if SMODS.has_enhancement(scoring_card, 'm_steel') then
                if scoring_card.ability.name and scoring_card.ability.name == 'Steel Card' then
                    percent = percent + 1 * JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
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
                    percent = percent + 1 * JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
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
        if extra and extra.children and extra.children[1] and extra.children[1].children and extra.children[1].children[2]
        then extra.children[1].children[2].config.colour = card.joker_display_values.colour or G.C.UI.TEXT_INACTIVE end
    end
}

jd_def['j_SEMBY_bound'] = { } -- No Info.

jd_def['j_SEMBY_broken_record'] = {
    calc_function = function(card)
        local text, _, scoring_hand = JokerDisplay.evaluate_hand()
        if text ~= 'Unknown' and #scoring_hand ~= 0 then
            card.joker_display_values.update_timer = (card.joker_display_values.update_timer or 0) + 1
            if card.joker_display_values.update_timer > 4 then
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
            if joker ~= card then
                sell_cost = sell_cost + joker.sell_cost
            end
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
        { border_nodes = {
            { ref_table = "card.joker_display_values", ref_value = "localized_text" }
        }, border_colour = (G.C.RARITY.Common or G.C.BLUE) }
    },
    calc_function = function(card)
		local compatible = 0
        for _, joker in ipairs(G.jokers and G.jokers.cards or {}) do
            if joker.config.center.blueprint_compat and joker.config.center.rarity == 1 and joker ~= card then
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
        if extra and extra.children and extra.children[1] and extra.children[1].children and extra.children[1].children[2]
        then extra.children[1].children[2].config.colour = card.joker_display_values.colour or G.C.UI.TEXT_INACTIVE end
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
        { ref_table = "card.joker_display_values", ref_value = "count", retrigger_type = "mult" },
        { text = "x", scale = 0.3 },
        { text = "+", colour = G.C.MULT },
        { ref_table = "card.ability.extra", ref_value = "mult", colour = G.C.MULT },
        { ref_table = "card.joker_display_values", ref_value = "spacing", scale = 0.3 },
        { text = "+", colour = G.C.CHIPS },
        { ref_table = "card.ability.extra", ref_value = "chips", colour = G.C.CHIPS }
    },
    text_config = { scale = 0.35 },
    reminder_text = {
        { text = "(" }, { ref_table = "card.joker_display_values", ref_value = "localized_text" }, { text = ")" }
    },
    extra = { {
        { text = "(" }, { ref_table = "card.joker_display_values", ref_value = "odds" }, { text = ")" },
    } },
    extra_config = { colour = G.C.GREEN, scale = 0.3 },
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
            card.ability.extra.numerator, card.ability.extra.denominator, 'SEMBY_lottery_ticket')
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
        { text = "+" },
        { ref_table = "card.joker_display_values", ref_value = "count", retrigger_type = "mult" },
        { ref_table = "card.joker_display_values", ref_value = "localized_text", colour = G.C.IMPORTANT },
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
        local count = card.ability.extra.count; local limited = false
        if text ~= 'Unknown' then
            for _, scoring_card in pairs(scoring_hand) do
                count = count + JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
            end
        end
        count = math.floor(count / card.ability.extra.every)
        if count > card.ability.extra.durability then
            limited = true
            card.joker_display_values.count = card.ability.extra.durability
        else card.joker_display_values.count = count end
        card.joker_display_values.localized_text = ' '..localize('SEMBY_cards')..(limited and '*' or '')
        card.joker_display_values.colour = card:SEMBY_durability_color(true)
    end,
    style_function = function(card, text, reminder_text, extra)
        if extra and extra.children and extra.children[1] and extra.children[1].children and extra.children[1].children[2]
        then extra.children[1].children[2].config.colour = card.joker_display_values.colour or G.C.UI.TEXT_INACTIVE end
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
                    count = count + 1 * JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
                end
            end
        end
        card.joker_display_values.hands = count
        card.joker_display_values.percent = (1 + card.ability.extra.percent) ^ count
    end
}


--[[
jd_def['j_SEMBY_parking_disc'] = {
    --text = {
    --    { ref_table = "card.joker_display_values", ref_value = "pre" },
    --    { ref_table = "card.joker_display_values", ref_value = "main", retrigger_type = "mult" },
    --    { ref_table = "card.joker_display_values", ref_value = "post" },
    --},

    text = { },

    calc_function = function(card)




        card.joker_display_values.test = 12
    end,

    --##TODO##
    -- ... Yes.
    -- Reminder? Mhm!

    style_function = function(card, text, reminder_text, extra)
        if text and text.children then


        text.children[1] = { border_nodes = {
            { text = "X" },
            { ref_table = "card.joker_display_values", ref_value = "test", retrigger_type = "exp" }
        }, border_colour = G.C.CHIPS }


            --text.children[1].config.colour = card.ability.extra.active and G.C.GREEN or G.C.UI.TEXT_INACTIVE
            --text.children[1].config.retrigger_type = 'exp'
        end
    end
}
--]]
--[[
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
					return card.area.cards[i - 1]
				end
			end
        end
        return nil
    end,
    retrigger_joker_function = function(card, retrigger_joker)
        if card and card == retrigger_joker then
            --##TODO## -> Check if correct
            return 2 --card.ability.extra.repeats - 1
        end
    end
--]]








jd_def['j_SEMBY_pay_two_win'] = {
    --##TODO##
    -- just mult
    -- reminder -$2 ?
}

jd_def['j_SEMBY_perfect_pitch'] = {
    --##TODO##
    -- xmult
    -- reminder: Amount of cards -> "3 Cards"
}

jd_def['j_SEMBY_pet_plastic'] = {
    --##TODO##
    -- mult
}

jd_def['j_SEMBY_piggy_bank'] = {
    --##TODO##
    -- xmult
}

jd_def['j_SEMBY_pinata'] = { } -- no info

jd_def['j_SEMBY_plastic_key'] = { } -- no info

jd_def['j_SEMBY_pocket_dimension'] = {
    --##TODO##
    -- current xmult based on consumables
}

jd_def['j_SEMBY_potted_flowers'] = {
    --##TODO##
    -- just xchips? (if valid or not!)
    -- like flower-pot!
    -- reminder: amount of suits needed; "(4 Suits)"
}

jd_def['j_SEMBY_quest'] = {
    --##TODO##
    -- Yes
    -- Reminder? Mhm!
}

jd_def['j_SEMBY_reagent'] = {
    --##TODO##
    -- xmult
}

jd_def['j_SEMBY_red_mask'] = {
    --##TODO##
    -- chips
    -- copy paste canio or similiar card destruction jokers
}

jd_def['j_SEMBY_ripped_joker'] = {
    --##TODO##
    -- copy paste half joker
}

jd_def['j_SEMBY_risky_joker'] = {
    --##TODO##
    -- show total -chips and -mult
    -- reminder: money about to be gained
}

jd_def['j_SEMBY_scaffolding'] = {
    --##TODO##
    -- +/- hand size
}

jd_def['j_SEMBY_seven_wonders'] = {
    --##TODO##
    -- percentage chips stuff
}

jd_def['j_SEMBY_shooting_star'] = { } -- no info

jd_def['j_SEMBY_silver_mask'] = {
    --##TODO##
    -- copy paste golden joker
}

jd_def['j_SEMBY_singularity'] = {
    --##TODO##
    -- main: "+4 Copies"
    -- reminder: cards created (linked to this singularity)
}

jd_def['j_SEMBY_stern_teacher'] = {
    --##TODO##
    -- mult
}

jd_def['j_SEMBY_stylish_joker'] = {
    --##TODO##
    -- money (total)
}

jd_def['j_SEMBY_stocked_shelves'] = {
    --##TODO##
    -- durability
    -- consider durability when showing values
}

jd_def['j_SEMBY_swordswallower'] = {
    --##TODO##
    -- Xmult
    -- reminder: "1x common jokers"
}

jd_def['j_SEMBY_t3mprr'] = {
    --##TODO##
    -- reduction in %
    -- reminder: increase?
}

jd_def['j_SEMBY_target_plush'] = {
    --##TODO##
    -- copy paste walkie talkie
}

jd_def['j_SEMBY_tempered_glass'] = {
    --##TODO##
    -- no info
    -- reminder: glass cards
}

jd_def['j_SEMBY_the_dwarf'] = {
    --##TODO##
    -- amount of discards gained
}

jd_def['j_SEMBY_the_giant'] = {
    --##TODO##
    -- amount of hand size gained
}

jd_def['j_SEMBY_TMTRAINER'] = {
    --##TODO##
    -- X-Change percent
}

jd_def['j_SEMBY_to_and_fro'] = { } -- no info

jd_def['j_SEMBY_tool_axe'] = {
    --##TODO##
    -- show amount of cards to be destroyed
    -- Copy-Paste: Shoot the Moon
    -- show durability (reminder?)
    -- consider durability when showing values
}

jd_def['j_SEMBY_tool_hoe'] = {
    --##TODO##
    -- show chips gained
    -- Copy-Paste: Shoot the Moon
    -- show durability (reminder?)
    -- consider durability when showing values
}

jd_def['j_SEMBY_tool_pickaxe'] = {
    --##TODO##
    -- show money gained
    -- Copy-Paste: Shoot the Moon
    -- show durability (reminder?)
    -- consider durability when showing values
}

jd_def['j_SEMBY_tool_shovel'] = {
    --##TODO##
    -- show Xmult
    -- Copy-Paste: Shoot the Moon
    -- show durability (reminder?)
    -- consider durability when showing values
}

jd_def['j_SEMBY_toolkit'] = {
    --##TODO##
    -- show amount to be repaired
    -- show durability (reminder?)
    -- consider durability when showing values
}

jd_def['j_SEMBY_twenty_to_die_for'] = { } -- no info

jd_def['j_SEMBY_unicorn'] = {
    --##TODO##
    -- show chips
}

jd_def['j_SEMBY_warm_embrace'] = {
    --##TODO##
    -- show chips & mult gained....?
}

jd_def['j_SEMBY_watching_forest'] = {
    --##TODO##
    -- show when it switches
    -- reminder: show sort-order
}

end
