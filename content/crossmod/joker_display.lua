-- hook "JokerDisplay.calculate_card_triggers = function(card, scoring_hand, held_in_hand)"
-- for my retrigger cards: Vintage Edition (maybe)
-- also support for "jevil"

--- Joker Display Definitions
--- Check Github Wiki for API details
--- https://github.com/nh6574/JokerDisplay/wiki

if Shimmerberry.compat.display then
local jd_def = JokerDisplay.Definitions

jd_def['j_SEMBY_anchor'] = {
    text = { {
        border_nodes = {
            { text = "X" }, { ref_table = "card.ability.extra", ref_value = "xchips", retrigger_type = "exp" }
        },
        border_colour = G.C.CHIPS
    } }
}




end

