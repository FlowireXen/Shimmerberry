-- Add more Pronouns :3
if Shimmerberry.compat.cardpronouns then
--local feminine_index = #CardPronouns.classifications["feminine"].pronouns
--local masculine_index = #CardPronouns.classifications["masculine"].pronouns
local neutral_index = #CardPronouns.classifications["neutral"].pronouns

-- Pronoun: CHAD
neutral_index = neutral_index + 1
CardPronouns.classifications["neutral"].pronouns[neutral_index] = "Chad"
CardPronouns.Pronoun {
    colour = G.C.MONEY, --HEX("5F5F5F"),
    text_colour = G.C.WHITE,
    pronoun_table = { "Chad" },
    --in_pool = function() return true end,
    in_pool = function() return false end,
    key = "SEMBY_chad"
}
G.P_CENTERS.j_hanging_chad.pronouns = "SEMBY_chad"
end
