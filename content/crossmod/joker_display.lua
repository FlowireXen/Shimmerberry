-- hook "JokerDisplay.calculate_card_triggers = function(card, scoring_hand, held_in_hand)"
-- for my retrigger cards: Vintage Edition (maybe)
-- also support for "jevil"
-- rework how Flowerpot is Detected

-- Add Editions to this
-- Add Consumables to this; Especially the Token from Eden Token

-- Clear all "##TODO##"s

--- Joker Display Definitions
--- Check Github Wiki for API details
--- https://github.com/nh6574/JokerDisplay/wiki

if Shimmerberry.compat.display then
local jd_def = JokerDisplay.Definitions
local function SEMBY_Percent(num, triggers)
    return (1 - (triggers == 1 and num or num ^ triggers)) * 100
end

jd_def['j_SEMBY_abandoned_soul'] = {
    text = { {
        border_nodes = {
            { text = "X" }, { ref_table = "card.ability.extra", ref_value = "xchips", retrigger_type = "exp" }
        },
        border_colour = G.C.CHIPS
    } }
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
        { ref_table = "card.joker_display_values", ref_value = "localized_text", retrigger_type = "mult", scale = 0.35 },
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
    text = { {
        border_nodes = {
            { text = "X" }, { ref_table = "card.ability.extra", ref_value = "xchips", retrigger_type = "exp" }
        },
        border_colour = G.C.CHIPS
    } }
}

jd_def['j_SEMBY_annoying_dog'] = {
    text = { {
        border_nodes = {
            { text = "X" }, { ref_table = "card.ability.extra", ref_value = "xmult", retrigger_type = "exp" },
            { ref_table = "card.joker_display_values", ref_value = "tail" } -- "Annoying Dog" Tail! :3c
        },
        border_colour = G.C.MULT
    } },
    calc_function = function(card)
        card.joker_display_values.tail = (card.ability.extra.xmult % 1 == 0) and '.0' or ''
    end
}

jd_def['j_SEMBY_anodized_steel'] = {
    text = {
        { text = "-" }, { ref_table = "card.joker_display_values", ref_value = "percent", retrigger_type = SEMBY_Percent }, { text = "%" },
    },
    text_config = { colour = G.C.SEMBY_PERCENT },
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
        { text = "-" }, { ref_table = "card.joker_display_values", ref_value = "percent", retrigger_type = SEMBY_Percent }, { text = "%" },
    },
    text_config = { colour = G.C.SEMBY_PERCENT },
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
    --##TODO##
    -- reminder: show durability
    --[[
    reminder_text = {
        { text = "(" },
        { ref_table = "card.ability.extra", ref_value = "durability", colour = G.C.SEMBY },
        { text = "/" },
        { ref_table = "card.ability.extra", ref_value = "durability_max", colour = G.C.IMPORTANT },
        { text = ")" },
    },
    -- colour? -> use the durability method in calc.
    ]]
}

jd_def['j_SEMBY_bound'] = {
    --##TODO##
    -- No info
    -- maybe show what would be destroyed?
}

jd_def['j_SEMBY_broken_record'] = {
    --##TODO##
    -- add retriggers like hanging chad -> always use the average between both rounded down
    -- does display "Avg. [...]"
    --> see bloodstone
    -- or 3-8 retriggers
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
    --##TODO##
    -- show all three values at once?? owo' (just show "+10% X1.05 X1.05" i guess?)
    -- when selecting a joker maybe show expected stat average?
    -- needs a custom retrigger
    --> Repeating Percentages get better
}

jd_def['j_SEMBY_chrono_break'] = {
    --##TODO##
    -- no info
}

jd_def['j_SEMBY_cockroach'] = {
    --##TODO##
    -- shows "+1 Ante" when in Boss blind... maybe.
    -- otherwise: no info
}

jd_def['j_SEMBY_common_denominator'] = {
    --##TODO##
    -- just show (reminder); "3 Commons", don't even try to combine all values.
    --> baseball card! (basically add 1x retrigger?)
    --> would be wrong :/
    -- IDK :3
}

jd_def['j_SEMBY_copy_printer'] = {
    --##TODO##
    -- in shop: show conversion? -> can detect challenge stuff!
    -- in shop reminder: "will break"/"won't break"
}

jd_def['j_SEMBY_coupon'] = {
    --##TODO##
    -- no info
}

jd_def['j_SEMBY_coupon_booklet'] = {
    --##TODO##
    -- show theoretical uses left
    -- reminder: shows current reduction
}

jd_def['j_SEMBY_echoing_joker'] = {
    --##TODO##
    -- no info
    -- maybe show info when probability has increased the value
}

jd_def['j_SEMBY_eden_blessing'] = {
    --##TODO##
    -- show "X1.5" in eden colour -> maybe figure out which one would be increased??
}

jd_def['j_SEMBY_emergency_button'] = {
    --##TODO##
    -- no info :3
    -- maybe as reminder: when in challenge show "X excluded"
}

jd_def['j_SEMBY_eternal_fortune'] = {
    --##TODO##
    -- no info
}

jd_def['j_SEMBY_fifty_seven_leaf_clover'] = {
    --##TODO##
    -- retrigger like hanging chad ya ya ya
}

jd_def['j_SEMBY_fortune_cookie'] = {
    --##TODO##
    -- just the usual edition stuff
}

jd_def['j_SEMBY_garden_gnome'] = {
    --##TODO##
    -- just show mult
}

jd_def['j_SEMBY_gold_bomb'] = {
    --##TODO##
    -- reminder: show active or inactive --> copy dusk
}

jd_def['j_SEMBY_goobert'] = {
    --##TODO##
    -- show durability --> X/10
    -- consider durability when showing values
}

jd_def['j_SEMBY_hemoturgy'] = {
    --##TODO##
    -- no info
    -- reminder: show the amount of cards that would be changed
}

jd_def['j_SEMBY_hypetrain'] = {
    --##TODO##
    -- show mult, and Xmult, maybe how long till upgrade?
    -- reminder maybe: "Upgrade in X hands"
}

jd_def['j_SEMBY_improv'] = {
    --##TODO##
    -- show stored hands
    -- reminder: percentage till NEXT hand
}

jd_def['j_SEMBY_incinerator'] = {
    --##TODO##
    -- no info
}

jd_def['j_SEMBY_jevil'] = {
    --##TODO##
    -- hanging chad'nt
    -- oh dear god this is gonna be horrible
}

jd_def['j_SEMBY_jokebra'] = {
    --##TODO##
    -- NO INFO, THIS ONE MANAGES ITSELF!!!
}

jd_def['j_SEMBY_lavish_joker'] = {
    --##TODO##
    -- show money store   and
    -- show next blind size increase
}

jd_def['j_SEMBY_lost_constellation'] = {
    --##TODO##
    -- no info
}

jd_def['j_SEMBY_lottery_ticket'] = {
    --##TODO##
    -- bloodstone joker logic for both
    -- inverse for chips etc.
    -- reminder: "(Non-face cards)"
}

jd_def['j_SEMBY_melon'] = {
    --##TODO##
    -- either "no info" or "show 50% decrease"
    -- reminder: about to be destroyed or not
}

jd_def['j_SEMBY_mineshaft'] = {
    --##TODO##
    -- amount till next card / how many cards you'll gain
    -- durability
    -- consider durability when showing values
}

jd_def['j_SEMBY_misery'] = {
    --##TODO##
    -- show both Chips and Mult on first hand
    -- show only mult on all other hands
}

jd_def['j_SEMBY_money_laundering'] = {
    --##TODO##
    -- no info, i guess?
}

jd_def['j_SEMBY_nashi_pear'] = {
    --##TODO##
    -- amount + "hidden" durability
    -- consider durability when showing values
}

jd_def['j_SEMBY_oblivion'] = {
    --##TODO##
    -- money increase, difficulty increase
    -- reminder: loops done (on that joker)
}

jd_def['j_SEMBY_obscure_ritual'] = {
    --##TODO##
    -- Active or Inactive
}

jd_def['j_SEMBY_opulent_skint'] = {
    --##TODO##
    -- no info
}

jd_def['j_SEMBY_ouroboros'] = {
    --##TODO##
    -- blind size increase
    -- hands you would be getting
}

jd_def['j_SEMBY_parking_disc'] = {
    --##TODO##
    -- ... Yes.
    -- Reminder? Mhm!
}

jd_def['j_SEMBY_pay_two_win'] = {
    --##TODO##
    -- just mult
    -- reminder -$2 ?
}

jd_def['j_SEMBY_perfect_pitch'] = {
    --##TODO##
    -- xmult
    -- reminder: Amount of cards
}

jd_def['j_SEMBY_pet_plastic'] = {
    --##TODO##
    -- mult
}

jd_def['j_SEMBY_piggy_bank'] = {
    --##TODO##
    -- xmult
}

jd_def['j_SEMBY_pinata'] = {
    --##TODO##
    -- no info
}

jd_def['j_SEMBY_plastic_key'] = {
    --##TODO##
    -- no info
}

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

jd_def['j_SEMBY_shooting_star'] = {
    --##TODO##
    -- no info
}

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

jd_def['j_SEMBY_to_and_fro'] = {
    --##TODO##
    -- either try to show switch states or no info
}

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

jd_def['j_SEMBY_twenty_to_die_for'] = {
    --##TODO##
    -- no info
}

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

--]]


end
