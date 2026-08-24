--## CrossMod: Card Pronouns
if Shimmerberry.compat.cardpronouns then
local neutral_index = #CardPronouns.classifications["neutral"].pronouns
-- Custom Pronoun: CHAD
CardPronouns.classifications["neutral"].pronouns[neutral_index + 1] = "Chad"
CardPronouns.Pronoun {
	key = "SEMBY_chad", pronoun_table = { "Chad", "Chad" },
	colour = G.C.MONEY, text_colour = G.C.WHITE,
	in_pool = function() return false end
}
-- Custom Pronoun: ERROR
CardPronouns.classifications["neutral"].pronouns[neutral_index + 2] = "ERR/OR"
CardPronouns.Pronoun {
	key = "SEMBY_err_or", pronoun_table = { "ERR/OR" },
	colour = HEX('FF00FF'), text_colour = G.C.WHITE,
	in_pool = function() return false end
}
-- Custom Pronoun: Was/Were
CardPronouns.classifications["neutral"].pronouns[neutral_index + 3] = "Was"
CardPronouns.classifications["neutral"].pronouns[neutral_index + 4] = "Were"
CardPronouns.Pronoun {
	key = "SEMBY_was_were", pronoun_table = { "Was", "Were" },
	colour = HEX('886644'), text_colour = G.C.WHITE,
	in_pool = function() return false end
}
-- Custom Pronoun: They/It
CardPronouns.Pronoun {
	key = "SEMBY_they_it", pronoun_table = { "They", "It" },
	colour = HEX('844FAF'), text_colour = G.C.WHITE,
	in_pool = function() return false end
}
-- Custom Pronoun: She/Her/It
CardPronouns.Pronoun {
	key = "SEMBY_she_her_it", pronoun_table = { "She", "Her", "It" },
	colour = HEX('CA80CA'), text_colour = G.C.WHITE,
	in_pool = function() return true end
}
-- Custom Pronoun: He/Him/It
CardPronouns.Pronoun {
	key = "SEMBY_he_him_it", pronoun_table = { "He", "Him", "It" },
	colour = HEX('6098C6'), text_colour = G.C.WHITE,
	in_pool = function() return true end
}
-- Vanilla Changes:
G.P_CENTERS.j_hanging_chad.pronouns = "SEMBY_chad"
G.P_CENTERS.j_misprint.pronouns = "SEMBY_err_or"
G.P_CENTERS.j_mr_bones.pronouns = "SEMBY_was_were"
-- Shimmerberry Pronouns:
local SEMBY_Joker_Pronouns = {
	abandoned_soul = "she_her",
	adblocker = "they_them",
	afterimage = "she_her",
	agent_fourty_seven = "he_him",
	alpha = "it_its",
	anchor = "he_him",
	annoying_dog = "it_its",
	anodized_steel = "SEMBY_he_him_it",
	arcoex = "any_all",
	balloon = "she_they",
	barmy_joker = "he_him",
	benthic_bloom = "they_them",
	berry_blue = "it_its",
	berry_golden = "he_him",
	berry_shimmer = "she_her",
	berry_straw = "she_her",
	boosterpack_joker = "he_him",
	bound = "he_they",
	broken_record = "she_her",
	buccaneer = "he_him",
	bunburrow = "she_her",
	butterfly = "he_him",
	cassette_beast = "SEMBY_she_her_it",
	ceaseless_void = "it_its",
	chrono_break = "she_they",
	cockroach = "it_its",
	common_denominator = "they_them",
	copy_printer = "any_all",
	coupon = "he_they",
	coupon_booklet = "she_they",
	daffy_joker = "she_they",
	DATAMINER = "SEMBY_err_or",
	doomsday_device = "SEMBY_was_were",
	echoing_joker = "any_all",
	eden_blessing = "he_they",
	emergency_button = "he_him",
	eternal_fortune = "SEMBY_she_her_it",
	fifty_seven_leaf_clover = "she_they",
	fire_exint = "he_him",
	fortune_cookie = "SEMBY_they_it",
	foxie_plush = "she_her",
	garden_gnome = "he_him",
	ghostsalt_contract = "he_they",
	gold_bomb = "they_them",
	goobert = "he_him",
	hemoturgy = "SEMBY_they_it",
	hypetrain = "SEMBY_she_her_it",
	improv = "he_him",
	incinerator = "he_him",
	inventation = "SEMBY_they_it",
	jevil = "he_him",
	jokebra = "she_her",
	lavish_joker = "SEMBY_chad",
	lost_constellation = "she_her",
	lottery_ticket = "she_her",
	melon = "SEMBY_she_her_it",
	mineshaft = "he_they",
	misery = "he_they",
	money_laundering = "he_him",
	nashi_pear = "SEMBY_he_him_it",
	nostalgia = "it_its",
	oblivion = "he_him",
	obscure_ritual = "any_all",
	opulent_skint = "he_him",
	ouroboros = "SEMBY_he_him_it",
	paper_swan = "SEMBY_she_her_it",
	parking_disc = "SEMBY_they_it",
	pay_two_win = "it_its",
	peculiar_joker = "she_her",
	perfect_pitch = "SEMBY_she_her_it",
	pet_plastic = "she_her",
	piggy_bank = "he_him",
	pinata = "SEMBY_they_it",
	plastic_key = "SEMBY_he_him_it",
	pocket_dimension = "any_all",
	potted_flowers = "she_they",
	pygmymall = "SEMBY_they_it",
	quest = "any_all",
	reagent = "he_they",
	red_mask = "they_them",
	replicator = "it_its",
	ripped_joker = "SEMBY_chad",
	risky_joker = "he_him",
	scaffolding = "he_they",
	scav_prototype = "it_its",
	seven_wonders = "it_its",
	shooting_star = "she_her",
	shrewd_joker = "it_its",
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
	TMTRAINER = "SEMBY_err_or",
	to_and_fro = "they_them",
	tool_axe = "she_they",
	tool_hoe = "any_all",
	tool_pickaxe = "she_her",
	tool_shovel = "he_him",
	toolkit = "she_they",
	twenty_to_die_for = "they_them",
	unicorn = "she_her",
	vip_ticket = "she_her",
	warm_embrace = "she_her",
	watching_forest = "she_they",
}
local SEMBY_Other_Pronouns = {
	-- Consumables
	c_SEMBY_backup = "he_him",
	c_SEMBY_daybreak = "any_all",
	c_SEMBY_eden_spawner = "any_all",
	c_SEMBY_microcosm = "they_them",
	c_SEMBY_ocean = "she_her",
	c_SEMBY_order_shrine = "they_them",
	c_SEMBY_soul_gem = "it_its",
	-- Editions
	e_SEMBY_pearlescent = "she_her",
	e_SEMBY_resonance = "SEMBY_he_him_it",
	e_SEMBY_shiny = "she_her",
	-- Enhancements
	m_SEMBY_memory = "SEMBY_she_her_it",
	m_SEMBY_vintage = "SEMBY_they_it",
	-- Vouchers
	v_SEMBY_mask_comedy = "she_her",
	v_SEMBY_mask_tragedy = "she_her",
	v_SEMBY_urn_old = "he_him",
	v_SEMBY_urn_cursed = "he_him",
	-- Can't set:
	-- Blinds, Decks, Sleeves, Stickers, Tags
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
