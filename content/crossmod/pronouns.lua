--## CrossMod: Card Pronouns
if Shimmerberry.compat.cardpronouns then
-- Custom Pronoun: CHAD
local neutral_index = #CardPronouns.classifications["neutral"].pronouns
CardPronouns.classifications["neutral"].pronouns[neutral_index + 1] = "Chad"
CardPronouns.Pronoun {
    key = "SEMBY_chad", pronoun_table = { "Chad", "Chad" },
    colour = G.C.MONEY, text_colour = G.C.WHITE,
    in_pool = function() return false end
}
-- Custom Pronoun: ERROR
CardPronouns.classifications["neutral"].pronouns[neutral_index + 2] = "ERR/OR"
CardPronouns.Pronoun {
    key = "SEMBY_error", pronoun_table = { "ERR/OR" },
    colour = HEX('FF00FF'), text_colour = G.C.WHITE,
    in_pool = function() return false end
}
-- Vanilla Changes:
G.P_CENTERS.j_hanging_chad.pronouns = "SEMBY_chad"
G.P_CENTERS.j_misprint.pronouns = "SEMBY_error"
-- SEMBYs Pronouns:
--[[
  "she_her"
  "he_him"
  "they_them"
  "any_all"
  "it_its"
  "she_they"
  "he_they"
--]]
local SEMBY_Joker_Pronouns = {
  abandoned_soul = nil,
  adblocker = nil,
  afterimage = "she_her",
  agent_fourty_seven = "he_him",
  alpha = nil,
  anchor = nil,
  annoying_dog = "it_its",
  anodized_steel = nil,
  arcoex = nil,
  balloon = nil,
  barmy_joker = nil,
  benthic_bloom = nil,
  berry_blue = nil,
  berry_golden = nil,
  berry_shimmer = nil,
  berry_straw = nil,
  boosterpack_joker = nil,
  bound = "he_they",
  broken_record = nil,
  buccaneer = "he_him",
  bunburrow = nil,
  butterfly = nil,
  cassette_beast = nil,
  ceaseless_void = "it_its",
  chrono_break = nil,
  cockroach = nil,
  common_denominator = nil,
  copy_printer = nil,
  coupon = nil,
  coupon_booklet = nil,
  daffy_joker = nil,
  DATAMINER = "SEMBY_error",
  digitizon = nil,
  doomsday_device = nil,
  echoing_joker = "any_all",
  eden_blessing = "he_they",
  emergency_button = nil,
  eternal_fortune = nil,
  fifty_seven_leaf_clover = nil,
  fire_exint = nil,
  fortune_cookie = nil,
  foxie_plush = "she_her",
  garden_gnome = nil,
  ghostsalt_contract = nil,
  gold_bomb = nil,
  goobert = "he_him",
  hemoturgy = nil,
  hypetrain = nil,
  improv = nil,
  incinerator = nil,
  inventation = nil,
  jevil = "he_him",
  jokebra = "she_her",
  lavish_joker = "SEMBY_chad",
  lost_constellation = nil,
  lottery_ticket = nil,
  melon = nil,
  mineshaft = nil,
  misery = nil,
  money_laundering = nil,
  nashi_pear = nil,
  oblivion = "he_him",
  obscure_ritual = nil,
  opulent_skint = "he_him",
  ouroboros = nil,
  paper_swan = nil,
  parking_disc = nil,
  pay_two_win = nil,
  peculiar_joker = nil,
  perfect_pitch = "she_her", -- She/Her/It
  pet_plastic = nil,
  piggy_bank = nil,
  pinata = "they_them", -- They/It
  plastic_key = nil,
  pocket_dimension = "any_all",
  potted_flowers = nil,
  pygmymall = nil,
  quest = "any_all",
  reagent = nil,
  red_mask = nil,
  replicator = "it_its",
  ripped_joker = "SEMBY_chad", -- :3
  risky_joker = nil,
  scaffolding = nil,
  scav_prototype = "it_its",
  seven_wonders = nil,
  shooting_star = nil,
  shrewd_joker = nil,
  silver_mask = "he_they",
  singularity = "she_her",
  stern_teacher = "he_him",
  stylish_joker = "she_her",
  stocked_shelves = "they_them",
  swordswallower = "she_they",
  t3mprr = "she_her",
  tempered_glass = "any_all",
  the_dwarf = "she_they",
  the_giant = "he_they",
  TMTRAINER = "SEMBY_error",
  to_and_fro = "they_them",
  tool_axe = "she_they",
  tool_hoe = "any_all",
  tool_pickaxe = nil,
  tool_shovel = nil,
  toolkit = nil,
  twenty_to_die_for = "they_them",
  unicorn = "she_her",
  vip_ticket = nil,
  warm_embrace = nil,
  watching_forest = "she_they",
}
local SEMBY_Other_Pronouns = { --Can't set: Blinds, Decks, Stickers
  -- Consumables
  c_SEMBY_backup = nil,
  c_SEMBY_daybreak = nil,
  c_SEMBY_eden_spawner = nil,
  c_SEMBY_microcosm = nil,
  c_SEMBY_ocean = nil,
  c_SEMBY_order_shrine = nil,
  c_SEMBY_soul_gem = nil,
  -- Vouchers
  v_SEMBY_mask_comedy = nil,
  v_SEMBY_mask_tragedy = nil,
  v_SEMBY_urn_old = nil,
  v_SEMBY_urn_cursed = nil,
  -- Enhancements
  m_SEMBY_memory = nil,
  m_SEMBY_vintage = nil,
  -- Editions
  e_SEMBY_pearlescent = nil,
  e_SEMBY_resonance = nil,
  e_SEMBY_shiny = nil,
  -- Sleeves
  sleeve_SEMBY_burning_sl = nil,
  sleeve_SEMBY_hopeless_sl = nil,
  sleeve_SEMBY_scartare_sl = nil,
  sleeve_SEMBY_strange_sl = nil,
  -- Tags
  tag_SEMBY_adt_duplitage = nil,
  tag_SEMBY_adt_intimidating = nil,
  tag_SEMBY_bnt_discards = nil,
  tag_SEMBY_bnt_hands = nil,
  tag_SEMBY_bnt_reroll = nil,
  tag_SEMBY_bnt_shop = nil,
  tag_SEMBY_bnt_vouch_down = nil,
  tag_SEMBY_edt_pearlescent = nil,
  tag_SEMBY_edt_shiny = nil,
  tag_SEMBY_ngt_doom = nil,
  tag_SEMBY_ngt_lavish = nil,
}
-- Apply Pronouns:
G.E_MANAGER:add_event(Event({
	func = function()
        for key, value in pairs(SEMBY_Joker_Pronouns) do
            local jKey = 'j_SEMBY_'..key
            if value and G.P_CENTERS[jKey] then G.P_CENTERS[jKey].pronouns = value end
        end
        for key, value in pairs(SEMBY_Other_Pronouns) do
            if value and G.P_CENTERS[key] then G.P_CENTERS[key].pronouns = value end
        end
		return true
	end
}))
end
