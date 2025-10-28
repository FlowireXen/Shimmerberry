--[[ When Translating:
	 SHOULD: Copy the "Translation-Helper" function
	 AVOID:  Rename Variables like "param.type"/"param.key",
]]-- Translation Helper:
-- > Minimizes Copy-Pasting similar Text-Blocks
function SEMBY_Translation_Helper(param)
	local loc_val = {}
	if not (param or param.type) then
		loc_val.name={"{C:attention,s:4.0}INVALID"}
		loc_val.text=loc_val.name
	elseif param.type == 'joker' then
		if param.key == 'parking_disc' then
			if param.index == 1 then
				loc_val.name = "Parking Disc: 1"
				loc_val.text = {
					"{C:attention}+#1#{} Handsize",
				}
			elseif param.index == 2 then
				loc_val.name = "Parking Disc: 2"
				loc_val.text = {
					"{X:mult,C:white}X#1#{} Mult",
				}
			elseif param.index == 3 then
				loc_val.name = "Parking Disc: 3"
				loc_val.text = {
					"Copies ability of {C:attention}Joker",
					"to the left {C:attention}#1#{} times",
				}
			elseif param.index == 4 then
				loc_val.name = "Parking Disc: 4"
				loc_val.text = {
					"{C:red}+#1#{} Discard{C:inactive}(s)",
				}
			elseif param.index == 5 then
				loc_val.name = "Parking Disc: 5"
				loc_val.text = {
					"Scoring cards",
					"give {C:mult}+#1#{} Mult",
				}
			elseif param.index == 6 then
				loc_val.name = "Parking Disc: 6"
				loc_val.text = {
					"Create {C:attention}#1#{} Consumable{C:inactive}(s)",
					"each hand played",
					"{C:inactive}(Must have room)",
				}
			elseif param.index == 7 then
				loc_val.name = "Parking Disc: 7"
				loc_val.text = {
					"{X:chips,C:white}X#1#{} Chips",
				}
			elseif param.index == 8 then
				loc_val.name = "Parking Disc: 8"
				loc_val.text = {
					"Earn {C:money}$#1#{} each",
					"each hand played",
				}
			elseif param.index == 9 then
				loc_val.name = "Parking Disc: 9"
				loc_val.text = {
					"{C:green}Reduce {C:attention}Blind Size{} by {C:SEMBY_percent}#1#%",
					"each hand played",
				}
			elseif param.index == 10 then
				loc_val.name = "Parking Disc: 10"
				loc_val.text = {
					"{C:chips}+#1#{} Chips",
				}
			elseif param.index == 11 then
				loc_val.name = "Parking Disc: 11"
				loc_val.text = {
					"Retrigger all scoring",
					"cards {C:attention}#1#{} time{C:inactive}(s)",
				}
			elseif param.index == 12 then
				loc_val.name = "Parking Disc: 12"
				loc_val.text = {
					"{C:attention}Unknown {C:green}Effect",
					"with {C:dark_edition,E:1}Bonus Effect",
				}
			end
		end
		if param.key == 'berry' then
			loc_val.text = {}
			if param.index == 1 then
				loc_val.name = "Blueberry"
				loc_val.text[1] = {
					"Each scored",
					"{C:attention}#1#{} or {C:attention}#2#",
					"gives {C:chips}+#3#{} Chips",
					"{s:0.1} ",
					"{C:inactive}Ranks change",
					"{C:inactive}every round",
				}
			elseif param.index == 2 then
				loc_val.name = "Goldenberry"
				loc_val.text[1] = {
					"Each scored",
					"{C:attention}#1#{} or {C:attention}#2#",
					"earns {C:money}$#3#{} or {C:money}$#4#",
					"{s:0.1} ",
					"{C:inactive}Ranks change",
					"{C:inactive}every round",
				}
			elseif param.index == 3 then
				loc_val.name = "Shimmerberry"
				loc_val.text[1] = {
					"Each scored",
					"{C:attention}#1#{} or {C:attention}#2#",
					"{C:green}reduces {C:attention}Blind",
					"{C:attention}Size{} by {C:SEMBY_percent}#3#%",
					"{s:0.1} ",
					"{C:inactive}Ranks change",
					"{C:inactive}every round",
				}
			elseif param.index == 4 then
				loc_val.name = "Strawberry"
				loc_val.text[1] = {
					"Each scored",
					"{C:attention}#1#{} or {C:attention}#2#",
					"gives {C:mult}+#3#{} Mult",
					"{s:0.1} ",
					"{C:inactive}Ranks change",
					"{C:inactive}every round",
				}
			end
			-- Added to all Berries:
			loc_val.text[2] = {
				"{s:0.9}Gets {C:red,s:0.9,E:2}Eaten{s:0.9} when",
				"{s:0.9}no {C:attention,s:0.9}#1#{s:0.9} or {C:attention,s:0.9}#2#",
				"{s:0.9}scored this round",
			}
		end
	end
	return loc_val
end
--## Normal Translations:
return {
	descriptions = {
        Mod = {
            SEMBY = {
                name = "Shimmerberry",
                text = {
					"{s:0.5} ",
					"Welcome to {C:SEMBY_flowire,s:1.1,E:1}Shimmerberry{}!",
					"{s:0.2} ",
					"{C:SEMBY_flowire}Shimmerberry{} adds {C:dark_edition}Custom{},",
					"{C:legendary}Fluffy{} and {C:attention}Vanilla-Like{} content:",
					"{s:0.2} ",
					"{C:attention}90{} Jokers, {C:blue}20{} Challenges, {C:tarot}4{} Vouchers,",
					"{C:red}3{} Decks {C:inactive,s:0.8}(& Sleeves){}, {C:spectral}3{} Consumables",
					"and {C:dark_edition,E:1}more{}!",
                    " ",
                    "Programming by {C:SEMBY_flowire}Flowire{}.",
                    "Art by {C:SEMBY_unkokat}unkokat{} and {C:SEMBY_flowire}Flowire{}.",
                    " ",
					"Check the {C:attention}Collection{}-View or the",
					"{C:SEMBY_unkokat}Artists{}-Tab for detailed credits!",
					" ",
					"{s:1.2}Have fun! {C:red,s:1.2}<3",
					"{u:inactive}                                   ",
                    "{s:0.5} ",
                    "Leave Feedback or Report Bugs here:",
					"{C:enhanced,u:enhanced,s:0.9}https://{C:enhanced,s:0.9}g{C:enhanced,u:enhanced,s:0.9}ithub.com/FlowireXen/Shimmerberr{C:enhanced,s:0.9}y",
					--> https://github.com/FlowireXen/Shimmerberry
					"{s:0.5} ",
                }
            }
        },
		Joker = {
			j_SEMBY_abandoned_soul = {
				name = "Abandoned Soul",
				text = {
					"Gains {X:chips,C:white}X#1#{} Chips",
					"when a {C:attention}face{} card",
					"is destroyed",
					"{C:inactive}(Currently {X:chips,C:white}X#2#{C:inactive} Chips)",
				}
			},
			j_SEMBY_adblocker = {
				name = "Adblocker",
				text = {{
					"When {C:attention}Blind{} is selected,",
					"debuff a random suit",
					"in your deck",
					"{C:inactive}(Debuffed: {V:1}#1#{C:inactive})",
				}, {
					"Played debuffed cards",
					"give {C:money}$#2#{} before scoring",
				}}
			},
			j_SEMBY_afterimage = {
				name = "Afterimage",
				text = {
					"Copies ability of",
					"{C:attention}Joker{} to the left",
					"{C:dark_edition,E:1}#1#{} times",
				}
			},
			j_SEMBY_agent_fourty_seven = {
				name = "Agent 47",
				text = {
					"When discarding",
					"exactly {C:attention}#1#{} cards,",
					"{C:red,E:2}eliminate{} {C:attention}one",
					"at random",
				}
			},
			j_SEMBY_alpha = {
				name = "Alpha",
				text = {
					"{C:blue}+#1#{} Hand for",
					"{C:attention}first{} scoring",
					"{C:enhanced}Stone Card",
				}
			},
			j_SEMBY_anchor = {
				name = "Anchor",
				text = {{
					"{X:chips,C:white}X#1#{} Chips",
				}, {
					"{C:red}Can't{} be",
					"{C:attention}Highlighted",
				}}
			},
			j_SEMBY_annoying_dog = {
				name = "Annoying Dog",
				text = {
					"{s:0.2} ",
					"{X:mult,C:white}X#1#{} Mult",
					"{s:0.2} ",
					"{C:red}No{} consumable slots",
				}
			},
			j_SEMBY_anodized_steel = {
				name = "Anodized Steel",
				text = {
					"Played {C:enhanced}Steel{} cards",
					"{C:green}reduce{} the {C:attention}Blind Size",
					"by {C:SEMBY_percent}#1#%{} when scored",
				}
			},
			j_SEMBY_benthic_bloom = {
				name = "Benthic Bloom",
				text = {
					"Retrigger all",
					"{C:enhanced}Enhanced Cards",
					"{s:0.2} ",
					"{C:enhanced}Enhanced Cards{} have",
					"a {C:green}#1# in #2#{} chance to",
					"shatter like {C:attention}Glass",
					"{s:0.2} ",
					"{V:1}Possessive",
					"{s:0.2} ",
				}
			},
			j_SEMBY_berry_blue = SEMBY_Translation_Helper({type = 'joker', key = 'berry', index = 1 }),
			j_SEMBY_berry_golden = SEMBY_Translation_Helper({type = 'joker', key = 'berry', index = 2 }),
			j_SEMBY_berry_shimmer = SEMBY_Translation_Helper({type = 'joker', key = 'berry', index = 3 }),
			j_SEMBY_berry_straw = SEMBY_Translation_Helper({type = 'joker', key = 'berry', index = 4 }),
			j_SEMBY_boosterpack_joker = {
				name = "Booster Pack",
				text = {
					"{C:attention}#1#{} additional",
					"{C:attention}Booster Packs",
					"in each {C:money}Shop",
					"{s:0.2} ",
					"{V:1}Degrading",
					"{s:0.2} ",
				},
			},
			j_SEMBY_bound = {
				name = "Bound Joker",
				text = {
					"{C:red}Debuff{} and {C:red}Destroy",
					"{C:attention}leftmost{} joker that",
					"isn't {C:red}Debuffed{} at",
					"beginning of round",
					"{s:0.2} ",
					"{C:attention}+#1#{} Joker slots",
					"{s:0.2} ",
				}
			},
			j_SEMBY_broken_record = {
				name = "Broken Record",
				text = {
					"Randomly add {C:attention}#1#{} to {C:attention}#2#{}",
					"retriggers to any",
					"scoring cards",
				}
			},
			j_SEMBY_buccaneer = {
				name = "Buccaneer",
				text = {
					"Adds {C:attention}twice{} the sell",
					"value of all other",
					"owned {C:attention}Jokers{} to {C:chips}Chips",
					"{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)",
				}
			},
			j_SEMBY_butterfly = {
				name = "Butterfly",
				text = {{
					"{C:chips}#1#{} Chips",
				}, {
					"{C:green}Gains {C:chips}+#2#{} Chips",
					"if played hand",
					"contains a {C:attention}#4#{},",
					"{C:red}Loses {C:chips}#3#{} Chips",
					"if it doesn't",
				}}
			},
			j_SEMBY_ceaseless_void = {
				name = "Ceaseless Void",
				text = {{
					"This Joker gains a random",
					"upgrade for each Joker {C:attention}sold",
				}, {
					"When {C:attention}Blind{} is selected",
					"{C:red}increase{} Blind Size by {C:SEMBY_percent}#1#%",
				}, {
					"{C:chips}+#2#{} Chips, {X:chips,C:white}X#4#{} Chips",
					"{C:mult}+#3#{} Mult, {X:mult,C:white}X#5#{} Mult",
				}, {
					"Earn {C:money}$#6#{} at end of round",
				}}
			},
			j_SEMBY_chrono_break = {
				name = "Chrono Break",
				text = {{
					"{C:legendary,E:1}Revive{} shattered",
					"{C:attention}playing cards",
				}, {
					"{C:attention}Shatter{} a random",
					"scoring card",
					"each hand",
				}}
			},
			j_SEMBY_cockroach = {
				name = "Cockroach",
				text = {
					"{C:attention}+#1#{} Ante when",
					"{C:attention}Boss Blind",
					"is defeated",
					"{s:0.2} ",
					"{V:1}Possessive",
					"{s:0.2} ",
				}
			},
			j_SEMBY_common_denominator = {
				name = {
					"{u:white}  Common  ",
					"Denominator",
				},
				text = {{
					"Copies abilities of",
					"{C:attention}all {X:common,C:white}Common{} Jokers",
				}, {
					"{C:common}Commons{}: #1#",
					"{C:green}Compatible{}: #2#",
					"{C:red}Incompatible{}: #3#",
				}}
			},
			j_SEMBY_copy_printer = {
				name = "Copy Printer",
				text = {
					"At the end of the {C:attention}Shop",
					"convert the {C:attention}Joker{} to the {C:attention}left",
					"into the {C:attention}Joker{} to the {C:attention}right",
					"{C:inactive}#1#" -- SEMBY_desc_destroyed / SEMBY_desc_maintained
				}
			},
			j_SEMBY_coupon = {
				name = "Coupon",
				text = {
					"Shops are",
					"{C:money}#1#%{} cheaper",
				}
			},
			j_SEMBY_coupon_booklet = {
				name = "Coupon Booklet",
				text = {
					"Shops are {C:money}#1#%{} cheaper",
					"{s:0.2} ",
					"Raise prices by {C:red}#2#%",
					"on every {C:green}Reroll",
				}
			},
			j_SEMBY_echoing_joker = {
				name = "Echoing Joker",
				text = {
					"Create {C:green}#1#{} {C:dark_edition}Negative",
					"copies of the next",
					"used {C:attention}Consumable",
				}
			},
			j_SEMBY_emergency_button = {
				name = "Emergency Button",
				text = {
					"Prevents Death and",
					"{C:green}Rerolls{} all {C:attention}Jokers{} and",
					"{C:attention}Consumables{}, {E:2}unless",
					"the cause is running",
					"out of cards",
				}
			},
			j_SEMBY_eternal_fortune = {
				name = "Eternal Fortune",
				text = {
					"{C:blue}+#1#{} Hand, {C:green}+#2#{} Luck",
				}
			},
			j_SEMBY_fifty_seven_leaf_clover = {
				name = "57 Leaf Clover",
				text = {
					"Retrigger all",
					"{C:enhanced}Wild Cards",
					"{C:dark_edition}#1#{} times",
				}
			},
			j_SEMBY_fortune_cookie = {
				name = "Fortune Cookie",
				text = {{
					"Gains a new random",
					"{C:dark_edition}Edition{} at the start",
					"of every {C:attention}Blind",
				}, {
					"Sell this card to",
					"apply {C:dark_edition}#1#{} to",
					"a random Joker",
				}}
			},
			j_SEMBY_garden_gnome = {
				name = "Garden Gnome",
				text = {
					"{C:mult}+#1#{} Mult",
					"{C:attention}-#2#{} Hand size",
				}
			},
			j_SEMBY_gold_bomb = {
				name = "Gold Bomb",
				text = {
					"Destroy all",
					"played cards",
					"in {C:attention}final hand",
					"of round",
				}
			},
			j_SEMBY_goobert = {
				name = "Goobert",
				text = {{
					"Creates {C:green,E:2}imperfect",
					"copies of {C:attention}playing cards",
					"added to your deck",
				}, {
					"{V:1}#1#{} uses left",
				}}
			},
			j_SEMBY_hemoturgy = {
				name = "Hemoturgy",
				text = {
					"Discarded cards gain",
					"a random {C:dark_edition}Edition{},",
					"{C:enhanced}Enhancement{} or {C:attention}Seal",
					"{s:0.2} ",
					"{C:red}-#1#{} Discard each round",
					"{s:0.2} ",
					"{C:red}Decreases{} amount of",
					"Discardable Cards by {C:attention}#2#",
				}
			},
			j_SEMBY_infoboard = {
				-- Initial text for "j_SEMBY_hypetrain"
				name = "Info Board",
				text = {
					"Your {C:attention}Joker{} arrives in:",
					"{s:0.2} ",
					"{C:mult}+#1#{} Mult",
					"{s:0.2} ",
				}
			},
			j_SEMBY_glitched_infoboard = {
				-- Glitched/TMTRAINER'd Info-Board
				name = "Info Board",
				text = {
					"Your {C:attention}Joker{} arrives in:",
					"{s:0.2} ",
					"{C:mult}+#1#{} Mult",
					"{s:0.2} ",
					"{X:SEMBY_TMTRAINER,C:white,s:0.8}X#2#{s:0.8} Mult{C:inactive,s:0.8,E:1}?",
					"{s:0.2} ",
				}
			},
			j_SEMBY_hypetrain = {
				name = "Hypetrain",
				text = {
					"Level {X:mult,C:white}X#1#{}!",
					"Next stop in:",
					"{s:0.2} ",
					"{C:mult}+#2#{} Mult",
					"{s:0.2} ",
				}
			},
			j_SEMBY_improv = {
				name = "Improv Show",
				text = {{
					"Spend {C:attention}#1# {C:red}Discard",
					"each hand played",
					"to regain {C:attention}#2# {C:blue}Hand",
				}, {
					"Earn {C:money}$#3#{} less per",
					"remaining {C:blue}Hand",
				}}
			},
			j_SEMBY_incinerator = {
				name = "Incinerator",
				text = {
					"{C:green}Increase{} amount",
					"of Discardable",
					"cards by {C:attention}#1#",
				}
			},
			j_SEMBY_jevil = {
				name = "JEV][L",
				text = {{
					"Occupies the",
					"{C:attention}Consumable{}-Area",
					"{C:attention}+#1#{} consumable slots",
				}, {
					"Using a {C:attention}Consumable",
					"{E:2,V:1}Degrades{} and {C:green}Copies",
					"{u:inactive}another{C:attention} Consumable",
					"in your possession",
					"{C:inactive}(Must have room)",
				}}
			},
			j_SEMBY_jokebra = {
				name = "Jokebra",
				text = {
					"When {C:attention}Blind{} is selected,",
					"set an additional {C:enhanced}Target",
					"{C:inactive}(Between {C:blue}#1#{C:inactive} and {C:blue}#2#{C:inactive})",
					"{s:0.2} ",
					"Beat the {C:attention}Blind{} when",
					"the Round score",
					"{u:inactive}matches{} the {C:enhanced}Target",
				}
			},
			j_SEMBY_jokebra_active = {
				name = "Jokebra",
				text = {
					"Beat the {C:attention}Blind{} by",
					"{u:inactive}matching{} the {C:enhanced}Target{}:",
					"{s:1.5,C:blue,E:2}#1#",
				}
			},
			j_SEMBY_jokebra_failed = {
				name = "Jokebra",
				text = {
					"Round score",
					"{C:red}missed{} the",
					"{C:enhanced}Target{}:",
					"{s:1.5,C:blue,E:2}#1#",
				}
			},
			j_SEMBY_lavish_joker = {
				name = "Lavish Joker",
				text = {{
					"Regain lost {C:money}Money",
					"{s:0.2} ",
					"Each {C:money}$1{} regained",
					"{C:red}increases{} the next",
					"{C:attention}Blind Size{} by {C:SEMBY_percent}#2#%",
					"{C:inactive}(Next Blind: {C:SEMBY_percent}+#3#%{C:inactive})",
				}, {
					"Turns {V:1}Possessive",
					"after {C:money}$#1#{} regained",
				}}
			},
			j_SEMBY_lost_constellation = {
				name = "Lost Constellation",
				text = {
					"{C:green}#1# in #2# {C:planet}Planet{} cards",
					"upgrade poker hand",
					"{C:attention}#3#{} additional times",
				}
			},
			j_SEMBY_lottery_ticket = {
				name = "Lottery Ticket",
				text = {
					"Scoring {C:attention}numbered{} cards",
					"have a {C:green}#1# in #2#{} chance",
					"to give {C:mult}+#3#{} Mult or",
					"{C:chips}+#4#{} Chips otherwise",
				}
			},
			j_SEMBY_melon = {
				name = "Melon",
				text = {{
					"When {C:attention}Blind{} is selected,",
					"{C:green}reduce {C:attention}Blind Size{} by {C:SEMBY_percent}#1#%",
				}, {
					"{C:attention}Destroyed{} when",
					"{C:attention}Boss Blind{} is defeated",
				}}
			},
			j_SEMBY_mineshaft = {
				name = "Mineshaft",
				text = {{
					"Every {C:attention}#1#{} scoring",
					"cards, add a {C:enhanced}Stone{},",
					"{C:enhanced}Steel{} or {C:enhanced}Gold{} card",
					"to the deck",
				}, {
					"{V:1}#2#{} uses left",
				}}
			},
			j_SEMBY_misery = {
				name = "Misery",
				text = {
					"{X:mult,C:white}X#1#{} Mult",
					"{s:0.2} ",
					"{X:chips,C:white}X#2#{} Chips for {C:attention}first",
					"{C:attention}hand{} of round",
				}
			},
			j_SEMBY_money_laundering = {
				name = "Money Laundering",
				text = {{
					"When {C:attention}Blind{} is selected,",
					"gain {C:blue}+#1#{} Hands and",
					"{C:red}+#2#{} Discards",
				}, {
					"Shop prices",
					"{C:red}increase{} by {C:money,E:1}#3#%",
				}}
			},
			j_SEMBY_nashi_pear = {
				name = "Nashi Pear",
				text = {
					"When Blind is selected,",
					"increase {C:attention}Round score",
					"by {C:attention}#1#{} and reduce",
					"this by {C:attention}#2#",
				}
			},
			j_SEMBY_oblivion = {
				name = "Oblivion",
				text = {{
					"You can't {E:2}Up the Ante{},",
					"{C:dark_edition,E:1}Win{} after {C:attention}#1#{} Loops",
				}, {
					"Gain {C:green,E:2}Progress{} by",
					"defeating {C:attention}Blinds{},",
					"reaching {C:green}100%{} allows",
					"you to {E:2}Up the Ante",
				}, {
					"{C:red,E:2}Difficulty{} rises",
					"with each {C:blue}Hand{} played,",
					"each Card {C:red}discarded",
					"or each {C:attention}Blind{} skipped",
				}, {
					"Progress: {C:green}#2#%",
					"Difficulty: {C:red}#3#%",
				}}
			},
			j_SEMBY_obscure_ritual = {
				name = "Obscure Ritual",
				text = {
					"{C:green}Reduce {C:attention}Blind Size",
					"by {C:SEMBY_percent}#1#%{} when drawing",
					"the {C:attention}last{} card",
				}
			},
			j_SEMBY_opulent_skint = {
				name = "Opulent Skint",
				text = {
					"Generate an {C:attention}extra",
					"Joker in the Shop",
					"{s:0.2} ",
					"The less {C:money}Money",
					"you have, the",
					"{C:dark_edition,E:2}Rarer{} the Joker",
				}
			},
			j_SEMBY_ouroboros = {
				name = "Ouroboros",
				text = {
					"Each scored {C:attention}8{} gives",
					"{C:blue}+#1#{} Hand and {C:red}increases",
					"the {C:attention}Blind Size{} by {C:SEMBY_percent}#2#%",
				}
			},
			j_SEMBY_parking_disc = {
				name = "Parking Disc",
				text = {
					"{C:green}Effect{} changes each round,",
					"{C:dark_edition}Bonus Effect{} in {C:attention}Boss Blinds",
				}
			},
			j_SEMBY_pay_two_win = {
				name = "P2W",
				text = {
					"Spend {C:money}$#1#{} to",
					"gain {C:mult}+#2#{} Mult",
				}
			},
			j_SEMBY_perfect_pitch = {
				name = "Perfect Pitch",
				text = {{
					"{X:mult,C:white}X#1#{} Mult when {C:attention}scoring",
					"exactly {C:attention}#2#{} card(s)",
					"{C:inactive,s:0.8}(Amount changes every hand)",
				}, {
					"Gain {X:mult,C:white}X#3#{} Mult",
					"after {C:attention}#4#{} successful",
					"hands in a row",
					"{C:inactive}(Currently {C:attention}#5#{C:inactive}/#4#)",
				}}
			},
			j_SEMBY_pet_plastic = {
				name = "P.E.T.",
				text = {
					"This Joker gains",
					"{C:mult}+#1#{} Mult for every card",
					"discarded this round",
					"{C:inactive}(Currently {}{C:mult}+#2#{}{C:inactive} Mult)",
				}
			},
			j_SEMBY_piggy_bank = {
				name = "Piggy Bank",
				text = {{
					"{X:mult,C:white}X#1#{} Mult for every",
					"{C:money}$#2#{} of {C:attention}sell value",
					"{C:inactive}(Currently {}{X:mult,C:white}X#3#{}{C:inactive} Mult)",
				}, {
					"When {C:attention}Blind{} is selected",
					"or skipped, spend {C:money}$#4#{} to",
					"add {C:money}$#5#{} of {C:attention}sell value",
				}, {
					"Starts with {C:money}$#6#",
					"extra {C:attention}sell value",
				}}
			},
			j_SEMBY_pinata = {
				name = "Piñata",
				text = {{
					"{C:green}#1# in #2#{} chance to",
					"break open {C:attention}each",
					"{C:attention}hand{} played",
				}, {
					"Gain {C:attention}+#3#{} and fill",
					"all {C:attention}Consumable",
					"slots when Joker",
					"gets destroyed",
				}}
			},
			j_SEMBY_plastic_key = {
				name = "Plastic Key",
				text = {
					"{C:attention}Destroy{} this card and",
					"create {C:attention}#1# {C:spectral}Spectral{} cards",
					"when {C:attention}Boss Blind{} is defeated",
					"{C:inactive}(Must have room)",
				}
			},
			j_SEMBY_pocket_dimension = {
				name = "Pocket Dimension",
				text = {
					"Cards in your",
					"{C:attention}Consumable{} area",
					"give {X:mult,C:white}X#2#{} Mult",
					"{s:0.2} ",
					"{C:attention}+#1#{} Consumable slots",
					"{s:0.2} ",
				}
			},
			j_SEMBY_potted_flowers = {
				name = "Potted Flowers",
				text = {
					"Gains {X:chips,C:white}X#1#{} Chips if",
					"poker hand contains a",
					"{C:diamonds}Diamond{} card, {C:clubs}Club{} card,",
					"{C:hearts}Heart{} card, and {C:spades}Spade{} card",
					"{C:inactive}(Currently {}{X:chips,C:white}X#2#{}{C:inactive} Chips)",
				}
			},
			j_SEMBY_quest = {
				name = "Quest?",
				text = {
					"Start a {C:enhanced,E:2}Quest{}!",
					"{s:0.2} ",
					"Complete it to",
					"{C:dark_edition,E:1}Win{} the Game and",
					"obtain a random",
					"{C:legendary,E:1}Legendary{} Joker",
				}
			},
			j_SEMBY_quest_hand_use = {
				name = {
					"{s:0.8,C:enhanced}Quest:",
					"{s:1.0}Honest Work",
				},
				text = {
					"Play {C:attention}#1# {C:blue}Hands",
				}
			},
			j_SEMBY_quest_hand_beat = {
				name = {
					"{s:0.8,C:enhanced}Quest:",
					"{s:1.0}The Nail",
				},
				text = {
					"Beat {C:attention}#1#{} Blinds {u:inactive}in a row",
					"with only {C:attention}One {C:blue}Hand{} played",
				}
			},
			j_SEMBY_quest_hand_shot = {
				name = {
					"{s:0.8,C:enhanced}Quest:",
					"{s:1.0}Super Speed",
				},
				text = {
					"Play {C:attention}#1# {C:blue}Hands",
					"in {C:attention}One{} Blind",
				}
			},
			j_SEMBY_quest_discard_use = {
				name = {
					"{s:0.8,C:enhanced}Quest:",
					"{s:1.0}Pollution",
				},
				text = {
					"{C:red}Discard {C:attention}#1#{} Cards",
				}
			},
			j_SEMBY_quest_discard_beat = {
				name = {
					"{s:0.8,C:enhanced}Quest:",
					"{s:1.0}The Anchor",
				},
				text = {
					"Beat {C:attention}#1#{} Blinds {u:inactive}in a row",
					"without {C:red}Discarding", "any cards",
				}
			},
			j_SEMBY_quest_discard_shot = {
				name = {
					"{s:0.8,C:enhanced}Quest:",
					"{s:1.0}Anarchy",
				},
				text = {
					"{C:red}Discard {C:attention}#1#{} Cards",
					"in {C:attention}One{} Blind",
				}
			},
			j_SEMBY_quest_money_use = {
				name = {
					"{s:0.8,C:enhanced}Quest:",
					"{s:1.0}Obliged Debt",
				},
				text = {
					"Spend {C:money}$#1#",
				}
			},
			j_SEMBY_quest_money_beat = {
				name = {
					"{s:0.8,C:enhanced}Quest:",
					"{s:1.0}The Claw",
				},
				text = {
					"Beat {C:attention}#1#{} Blinds {u:inactive}in a row",
					"without spending or", "losing any {C:money}Money",
				}
			},
			j_SEMBY_quest_money_shot = {
				name = {
					"{s:0.8,C:enhanced}Quest:",
					"{s:1.0}Big Bounty",
				},
				text = {
					"Earn {C:money}$#1#",
					"in {C:attention}One{} Blind",
				}
			},
			j_SEMBY_quest_consumable_use = {
				name = {
					"{s:0.8,C:enhanced}Quest:",
					"{s:1.0}Consumerism",
				},
				text = {
					"Use {C:attention}#1# {E:2}Consumables",
				}
			},
			j_SEMBY_quest_consumable_beat = {
				name = {
					"{s:0.8,C:enhanced}Quest:",
					"{s:1.0}The Incentive",
				},
				text = {
					"Beat {C:attention}#1#{} Blinds {u:inactive}in a row",
					"without using",
					"any {C:attention,E:2}Consumables",
				}
			},
			j_SEMBY_quest_consumable_shot = {
				name = {
					"{s:0.8,C:enhanced}Quest:",
					"{s:1.0}Bullet Time",
				},
				text = {
					"Use {C:attention}#1# {E:2}Consumables",
					"in {C:attention}One{} Blind",
				}
			},
			j_SEMBY_quest_joker_use = {
				name = {
					"{s:0.8,C:enhanced}Quest:",
					"{s:1.0}Heartbeat",
				},
				text = {
					"Skip {C:attention}#1# {C:enhanced}Buffoon Packs",
				}
			},
			j_SEMBY_quest_joker_beat = {
				name = {
					"{s:0.8,C:enhanced}Quest:",
					"{s:1.0}The Soul",
				},
				text = {
					"Beat {C:attention}#1#{} Blinds {u:inactive}in a row",
					"without adding or", "selling any {C:attention}Jokers",
				}
			},
			j_SEMBY_quest_joker_shot = {
				name = {
					"{s:0.8,C:enhanced}Quest:",
					"{s:1.0}Final Hunt",
				},
				text = {
					"Sell {C:attention}#1# {C:attention}Jokers",
					"in {C:attention}One{} Blind",
				}
			},
			j_SEMBY_quest_complete = {
				name = {
					"{s:0.8,C:enhanced}Quest:",
					"{s:1.0,C:green}Successful",
				},
				text = {
					"Sell or remove", "this card to create",
					"a {C:legendary,E:1}Legendary{} Joker",
				}
			},
			j_SEMBY_reagent = {
				name = "Reagent",
				text = {
					"{X:mult,C:white}X#1#{} Mult",
					"{s:0.2} ",
					"Loses {X:mult,C:white}X#2#{} Mult",
					"for each {C:enhanced}Enhanced",
					"card in your deck",
				}
			},
			j_SEMBY_red_mask = {
				name = "Red Mask",
				text = {
					"This Joker gains {C:chips}+#1#{} Chips",
					"when adding or removing",
					"a {C:attention}playing card",
					"{C:inactive}(Currently {}{C:chips}+#2#{}{C:inactive} Chips)",
				}
			},
			j_SEMBY_ripped_joker = {
				name = "Ripped Joker",
				text = {
					"{C:chips}+#1#{} Chips if played",
					"hand contains",
					"{C:attention}#2#{} or fewer cards",
				}
			},
			j_SEMBY_risky_joker = {
				name = "Risky Joker",
				text = {
					"Scoring cards {C:red}take",
					"{C:chips}#1#{} Chips and {C:mult}#2#{} Mult",
					"and increase the",
					"Blind Payout by {C:money}$#3#",
					"{C:inactive}(Next payout {C:money}+$#4#{C:inactive})",
				}
			},
			j_SEMBY_scaffolding = {
				name = "Scaffolding",
				text = {
					"{V:1}#3#{} Hand size",
					"{s:0.2} ",
					"When {C:attention}Blind{} is selected",
					"{C:green}gain {C:attention}#1#{} Hand size for",
					"every other {C:attention}Joker",
					"{s:0.2} ",
					"{C:red}Lose {C:attention}#2#{} Hand size",
					"each {C:blue}Hand{} played",
				}
			},
			j_SEMBY_seven_wonders = {
				name = "7 Wonders",
				text = {
					"When {C:attention}Blind{} is selected",
					"{C:green}reduce{} the {C:attention}Blind Size",
					"by {C:SEMBY_percent}#1#%{} for each {C:attention}7{} in",
					"your {C:attention}full deck",
					"{C:inactive}(Currently {C:SEMBY_percent}#2#%{C:inactive}/#3#%)",
				}
			},
			j_SEMBY_shooting_star = {
				name = "Shooting Star",
				text = {
					"When {C:attention}Boss Blind{} is",
					"defeated, upgrade",
					"every {C:legendary,E:1}Poker Hand",
					"by {C:green}#1#{} level{C:inactive}(s)",
				}
			},
			j_SEMBY_silver_mask = {
				name = "Silver Mask",
				text = {
					"Earn {C:money}$#1#{} at the",
					"end of the round",
					"{s:0.2} ",
					"Earn {C:money}$#2# {C:attention}less{} for",
					"each Hand size",
				}
			},
			j_SEMBY_singularity = {
				name = "Singularity",
				text = {{
					"Create a copy of",
					"{E:1}every{} {C:attention}scoring card",
				}, {
					"When this {C:attention}Joker",
					"gets removed,",
					"{C:red}Destroy{} all cards",
					"it has created",
					"{C:inactive,s:0.9}(Can't be {V:1,s:0.9}Debuffed{C:inactive,s:0.9})",
				}, {
					"Occupies {C:attention}#1#",
					"Joker slots",
				}}
			},
			j_SEMBY_stirn_librarian = {
				name = "Stirn Librarian",
				text = {{
					"When {C:attention}Blind{} is selected,",
					"{V:1}Debuff{} adjacent Jokers",
				}, {
					"{C:mult}+#1#{} Mult for each",
					"{V:1}Debuffed{} Joker",
					"{C:inactive}(Currently {C:mult}+#2# {C:inactive}Mult)",
				}}
			},
			j_SEMBY_stylish_joker = {
				name = "Stylish Joker",
				text = {
					"{C:red}-#1#{} hand size",
					"{C:attention}+#2#{} consumable slots",
					"{s:0.2} ",
					"Earn {C:money}$#3#{} for every",
					"{C:attention}Consumable{} you keep",
					"at the end of round",
				}
			},
			j_SEMBY_stocked_shelves = {
				name = "Stocked Shelves",
				text = {
					"{C:attention}+#1#{} Booster pack,",
					"Card and Voucher",
					"slot in {C:money}Shop",
				}
			},
			j_SEMBY_swordswallower = {
				name = "Sword Swallower",
				text = {
					"{X:mult,C:white}X#1#{} Mult for each",
					"{X:common,C:white}Common{} Joker",
					"{C:inactive}(Currently {}{X:mult,C:white}X#2#{}{C:inactive} Mult)",
				}
			},
			j_SEMBY_t3mprr = {
				name = "PUSH UR T3MPRR",
				text = {{
					"{C:attention,E:2}BLIND {E:2}SELECTED,",
					"{C:red,E:2}CLOCK IT UP {C:SEMBY_percent,E:2}#1#%",
				}, {
					"{C:attention,E:2}CARD {E:2}PLAYED,",
					"{C:green,E:2}PUSH IT DOWN {C:SEMBY_percent,E:2}#2#%",
				}}
			},
			j_SEMBY_target_plush = {
				name = "Target Plush",
				text = {
					"{C:chips}+#1#{} Chips for",
					"each {C:attention}Joker{} and",
					"{C:mult}+#2#{} Mult for each",
					"empty {C:attention}Joker{} slot",
					"{C:inactive}({C:chips}+#3#{}{C:inactive} Chips, {}{C:mult}+#4#{}{C:inactive} Mult)",
				}
			},
			j_SEMBY_tempered_glass = {
				name = "Tempered Glass",
				text = {
					"{C:enhanced}Glass Cards{} have",
					"a {C:green}#1# in #2#{} chance",
					"to be destroyed",
				}
			},
			j_SEMBY_the_dwarf = {
				name = "The Dwarf",
				text = {
					"When {C:attention}Blind{} is selected,",
					"set hand size to {C:attention}#1#{} and",
					"add the {C:attention}difference",
					"to the {C:red}Discards",
				}
			},
			j_SEMBY_the_giant = {
				name = "The Giant",
				text = {
					"When {C:attention}Blind{} is selected,",
					"{C:attention}lose all discards{} and",
					"gain {C:attention}as much{} hand size",
				}
			},
			j_SEMBY_TMTRAINER = {
				name = "TMTRAINER",
				text = {
					"{C:SEMBY_TMTRAINER,E:1}Randomizes{} most",
					"{C:enhanced}Numbers{} on newly",
					"obtained {C:attention}Jokers",
					"{C:inactive,s:0.8}Range: #1#%-#2#%",
					"{s:0.2} ",
					"{C:attention}+1{} Joker slot",
					"{s:0.2} ",
				}
			},
			j_SEMBY_to_and_fro = {
				name = "To n' Fro",
				text = {
					"{s:0.2} ",
					"Played cards swap",
					"{C:chips}Chips{} and {C:mult}Mult",
					"{u:inactive}before{} scoring",
					"{s:0.2} ",
				}
			},
			j_SEMBY_fro_and_to = {
				name = "To n' Fro",
				text = {
					"{s:0.2} ",
					"Played cards swap",
					"{C:mult}Mult{} and {C:chips}Chips",
					"{u:inactive}before{} scoring",
					"{s:0.2} ",
				}
			},
			j_SEMBY_tool_axe = {
				name = "Axe",
				text = {{
					"Each {V:1}#1#{} card",
					"held in hand has",
					"a {C:green}#2#%{} chance to",
					"be {C:attention}destroyed",
					"{s:0.1} ",
					"{C:inactive}Suit changes",
					"{C:inactive}every round",
				}, {
					"{V:2}#3#{} uses left",
				}}
			},
			j_SEMBY_tool_hoe = {
				name = "Hoe",
				text = {{
					"Each {V:1}#1#{} card",
					"held in hand",
					"gives {C:chips}+#2#{} Chips",
					"{s:0.1} ",
					"{C:inactive}Suit changes",
					"{C:inactive}every round",
				}, {
					"{V:2}#3#{} uses left",
				}}
			},
			j_SEMBY_tool_pickaxe = {
				name = "Pickaxe",
				text = {{
					"Each {V:1}#1#{} card",
					"held in hand has",
					"a {C:green}#2#%{} chance",
					"to give {C:money}$#3#",
					"{s:0.1} ",
					"{C:inactive}Suit changes",
					"{C:inactive}every round",
				}, {
					"{V:2}#4#{} uses left",
				}}
			},
			j_SEMBY_tool_shovel = {
				name = "Shovel",
				text = {{
					"Each {V:1}#1#{} card",
					"held in hand",
					"gives {X:mult,C:white}X#2#{} Mult",
					"{s:0.1} ",
					"{C:inactive}Suit changes",
					"{C:inactive}every round",
				}, {
					"{V:2}#3#{} uses left",
				}}
			},
			j_SEMBY_toolkit = {
				name = "Toolkit",
				text = {{
					"{C:attention}Jokers{} with a limited",
					"number of uses are",
					"{C:green,E:2}repaired{} and regain",
					"up to {C:attention}#1#{} uses at the",
					"end of the round",
				}, {
					"Some {C:attention}Jokers{} use up",
					"more durability while",
					"getting {C:green,E:2}repaired",
				}, {
					"{V:1}#2#{} uses left",
					"{C:inactive,s:0.8}Can't be repaired",
				}}
			},
			j_SEMBY_twenty_to_die_for = {
				name = "20 to Die for",
				text = {
					"Quadruples all {C:attention}listed",
					"{C:green,E:1,S:1.1}probabilities",
					"{C:inactive}(ex: {C:green}1 in 3{C:inactive} -> {C:green}#1# in 3{C:inactive})",
				}
			},
			j_SEMBY_unicorn = {
				name = "Unicorn",
				text = {
					"{C:chips}+#1#{} Chips for each unique",
					"{C:dark_edition}Edition{}, {C:enhanced}Enhancement{} or",
					"{C:attention}Seal{} in your full deck",
					"{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)",
				}
			},
			j_SEMBY_warm_embrace = {
				name = "Warm Embrace",
				text = {
					"{C:chips}Chips{} and {C:mult}Mult{} are",
					"rounded up to the",
					"{C:attention}next{} multiple of {C:attention}#1#",
				}
			},
			j_SEMBY_watching_forest = {
				name = "Watching Forest",
				text = {
					"Sort the Deck",
					"{C:attention}lowest to highest",
					"every {C:attention}#1#{} hands played",
					"{C:inactive}#2#",
				}
			},
			--## Doubled for "Technical Limitations" (Skill issue)
			-- > Check Method up Top for Translation!
			j_SEMBY_parking_disc_1 = SEMBY_Translation_Helper({type = 'joker', key = 'parking_disc', index = 1 }),
			j_SEMBY_parking_disc_2 = SEMBY_Translation_Helper({type = 'joker', key = 'parking_disc', index = 2 }),
			j_SEMBY_parking_disc_3 = SEMBY_Translation_Helper({type = 'joker', key = 'parking_disc', index = 3 }),
			j_SEMBY_parking_disc_4 = SEMBY_Translation_Helper({type = 'joker', key = 'parking_disc', index = 4 }),
			j_SEMBY_parking_disc_5 = SEMBY_Translation_Helper({type = 'joker', key = 'parking_disc', index = 5 }),
			j_SEMBY_parking_disc_6 = SEMBY_Translation_Helper({type = 'joker', key = 'parking_disc', index = 6 }),
			j_SEMBY_parking_disc_7 = SEMBY_Translation_Helper({type = 'joker', key = 'parking_disc', index = 7 }),
			j_SEMBY_parking_disc_8 = SEMBY_Translation_Helper({type = 'joker', key = 'parking_disc', index = 8 }),
			j_SEMBY_parking_disc_9 = SEMBY_Translation_Helper({type = 'joker', key = 'parking_disc', index = 9 }),
			j_SEMBY_parking_disc_10 = SEMBY_Translation_Helper({type = 'joker', key = 'parking_disc', index = 10 }),
			j_SEMBY_parking_disc_11 = SEMBY_Translation_Helper({type = 'joker', key = 'parking_disc', index = 11 }),
			j_SEMBY_parking_disc_12 = SEMBY_Translation_Helper({type = 'joker', key = 'parking_disc', index = 12 }),
		},
		Back = {
			b_SEMBY_hopeless = {
				name = "Hopeless Deck",
				text = {
					"{C:dark_edition}Unknown{} Winning Ante",
					"{s:0.2} ",
					"Gain {C:attention}+#1#{} Joker Slot",
					"for every {C:attention}#2#{} Boss",
					"Blinds defeated",
				}
			},
			b_SEMBY_scartare = { --> "Skat"(ska:t)
				name = "Scartare Deck",
				text = {
					"Remove all Ranks below {C:attention}#1#",
					"{C:attention}+#2#{} Hand size, {C:red}-#3#{} Discards",
					"{s:0.2} ",
					"Discard {C:red}#4#{} random cards",
					"with each hand played",
				}
			},
			b_SEMBY_strange = {
				name = "Strange Deck",
				text = {
					"Generating Deck: {V:1}#1#{V:2}#2#",
				}
			},
		},
		Sleeve = {
			sleeve_SEMBY_burning_sl = {
				name = "Burned Sleeve",
				text = {
					"{C:legendary}Challenge Sleeve!",
					"{s:0.2} ",
					"{C:red}Destroy{} the",
					"first drawn hand",
					"every {C:attention}Boss Blind",
				}
			},
			sleeve_SEMBY_hopeless_sl = {
				name = "Hopeless Sleeve",
				text = {
					"{C:dark_edition}Unknown{} Winning Ante",
					"{s:0.2} ",
					"Gain {C:attention}+#1#{} Joker Slot",
					"for every {C:attention}#2#{} Boss",
					"Blinds defeated",
				}
			},
			sleeve_SEMBY_hopeless_sl_alt = {
				name = "Hopeless Sleeve",
				text = {
					"{C:red}Increased{} Winning Ante",
					"{s:0.2} ",
					"{C:green}Decrease{} amount",
					"of needed Boss",
					"Blinds by {C:attention}#1#",
				}
			},
			sleeve_SEMBY_scartare_sl = { --> "Skat"(ska:t)
				name = "Scartare Sleeve",
				text = {
					"Remove all Ranks below {C:attention}#1#",
					"{C:attention}+#2#{} Hand size, {C:red}-#3#{} Discards",
					"{s:0.2} ",
					"Discard {C:red}#4#{} random cards",
					"with each hand played",
				}
			},
			sleeve_SEMBY_scartare_sl_alt = { --> "Skat"(ska:t)
				name = "Scartare Sleeve",
				text = {
					"{C:attention}+#1#{} Hand size",
					"{s:0.2} ",
					"Discard {C:red}#2#{} additional",
					"cards with each",
					"hand played",
				}
			},
			sleeve_SEMBY_strange_sl = {
				name = "Strange Sleeve",
				text = {
					"Generating Sleeve: {V:1}#1#{V:2}#2#",
				}
			},
			sleeve_SEMBY_strange_sl_alt = {
				name = "Strange Sleeve",
				text = {
					"{C:red,s:1.1}Corrupt Data Segment{s:1.1}:",
					--{ Don't Translate }-->
					"{C:attention,s:0.9}SMODS{s:0.9}.{u:inactive,s:0.9}Sleeve",
					"{s:0.9}.obj_table[{C:blue,s:0.9}'SEMBY_strange'{s:0.9}]",
					"{s:0.9}.loc_vars({C:enhanced,s:0.9}self{s:0.9})",
				}
			},
		},
		Blind = {
			bl_SEMBY_frog = {
				name = "The Frog",
				text = {
					'{C:attention}-1{} hand size and',
					'{C:red}+1{} discard for',
					'each hand played'
				},
			},
			bl_SEMBY_pencil = {
				name = 'The Pencil',
				text = {
					'Debuff {C:attention}first{} played',
					'card every hand'
				}
			},
			bl_SEMBY_sharp_shooter = {
				name = 'Sharp Shooter',
				text = {
					"{C:attention}Five{} random Cards",
					"debuffed every hand",
				}
			},
		},
		Voucher = {
			v_SEMBY_mask_comedy = { -- Mask 1
				name = "Comedy Mask",
				text = {
					"{C:green}Reduce{} all",
					"Blind Sizes by {C:SEMBY_percent}#1#%",
					"{C:red}-#2#{} hand size",
				}
			},
			v_SEMBY_mask_tragedy = { -- Mask 2
				name = "Tragedy Mask",
				text = {
					"{C:green}Reduce{} all",
					"Blind Sizes by {C:SEMBY_percent}#1#%",
					"{C:red}-#2#{} hand size",
				},
                unlock = {
                    "Discover",
					"{C:attention}#1#{} Blinds",
                }
			},
			v_SEMBY_urn_old = { -- Urn 1
				name = "Old Urn",
				text = {
					"Permanently",
					"{C:green}increase{} amount",
					"of Discardable",
					"cards by {C:attention}#1#",
				}
			},
			v_SEMBY_urn_cursed = { -- Urn 2
				name = "Cursed Urn",
				text = {
					"Permanently",
					"{C:green}increase{} amount",
					"of Discardable",
					"cards by {C:attention}#1#{}, but",
					"{C:red}lose {C:attention}#2#{} Discard",
					"each round",
				},
                unlock = {
					"Discard a total",
					"of {C:attention}#1#{} cards",
					"{C:inactive}(#2#)",
                }
			},
		},
		Tarot = {
			c_SEMBY_ocean = {
				name = "Ocean",
				text = {
					"Add {C:dark_edition}Pearlescent{} or {C:dark_edition}Shiny",
					"to {C:attention}one{} selected {C:attention}Playing Card",
					"{C:attention}or{} a random {C:attention}Joker",
				}
			},
		},
		Spectral = {
			c_SEMBY_order_shrine = {
				name = "Order",
				text = {
					"Replace {C:attention,E:1}all{} Jokers with",
					"one {C:attention,E:2}random{} Joker in",
					"your possession, the",
					"new copies keep their",
					"old {C:dark_edition}Modifiers",
				},
			},
			c_SEMBY_soul_gem = {
				name = "Soul Gem",
				text = {
					"{B:1,C:white,E:1}#1#{} Soul Captured",
					"{C:inactive}(Must have room)",
				},
			},
			c_SEMBY_soul_gem_empty = {
				name = "Empty Soul Gem",
				text = {
					"Captures the",
					"{C:spectral,E:1}Soul{} of the next",
					"defeated {C:attention}Blind",
				},
			},
		},
		Tag = {
			tag_SEMBY_intimidating = {
				name = "Intimidating Tag",
				text = {
					"{C:SEMBY_percent}-#1#% {C:attention}Blind Size",
					"next round",
				}
			},
			tag_SEMBY_pearlescent_skip = {
				name = "Pearlescent Tag",
				text = {
					"Next base edition shop",
					"Joker is free and",
					"becomes {C:dark_edition}Pearlescent",
				}
			},
			tag_SEMBY_shiny_skip = {
				name = "Shiny Tag",
				text = {
					"Next base edition shop",
					"{C:attention}Consumable{} is free and",
					"becomes {C:dark_edition}Shiny",
				}
			},
			tag_SEMBY_vouch_down = {
				name = "Vouch-down Tag",
				text = {
					"Reduce the cost of a random",
					"{C:attention}Voucher{} by {C:money}$#1#{} next shop",
				}
			},
		},
		Edition = {
			e_SEMBY_pearlescent = {
				name = "Pearlescent",
				text = {
					"{C:green}Reduce",
					"{C:attention}Blind Size",
					"by {C:SEMBY_percent}#1#%",
				}
			},
			e_SEMBY_shiny = {
				name = "Shiny",
				text = {
					"Gains {C:money}$#1#{} of",
					"{C:attention}sell value{} at",
					"end of round",
				}
			},
			e_SEMBY_shiny_playing_card = {
				name = "Shiny",
				text = {
					"Grant {C:money}$#1#{} of",
					"{C:attention}sell value{} to a",
					"random {C:attention}Joker",
				}
			},
		},
		Other = {
			-- Artists:
			art_flowire = {
				name = "Artist",
				text = {
					"{C:SEMBY_flowire,s:1.1}Flowire",
					"{s:0.2} ",
					"I hope you're",
					"having fun with",
					"my Mod! {C:red}<3",
				}
			},
			art_unkokat = {
				name = "Artist",
				text = {
					"{C:SEMBY_unkokat,s:1.1}unkokat",
					"{s:0.2} ",
					"Hanging Chad",
					"best Joker",
				}
			},
			-- Art: Placeholders
			art_placeholder = {
				name = "No Artist",
				text = {
					"{C:dark_edition,s:1.1}Placeholder", "{s:0.2} ",
					"{C:attention}Your{} art", "could be here!",
				}
			},
			art_WIP = {
				name = "Art: WIP",
				text = {
					"Artwork in",
					"Progress, come",
					"back later!",
				}
			},
			-- Inspirations:
			inspired_buffoonery = {
				-- https://github.com/pinkmaggit-hub/Buffoonery
				name = "Inspired by",
				text = {
					"{C:legendary,s:1.1}Buffoonery",
					"{C:inactive,s:0.8}Pink Maggit",
					"{C:inactive,s:0.8}and BurAndBY",
				}
			},
			inspired_tetrapak = {
				-- https://github.com/tetraminus/Tetrapak
				name = "Inspired by",
				text = {
					"{C:legendary,s:1.1}Tetrapak",
					"{C:inactive,s:0.8}tetraminus",
				}
			},
			inspired_vio_undertale = {
				-- https://bsky.app/profile/viomarks.bsky.social/post/3lweldltlkk24
				name = "Inspired by",
				text = {
					"{C:legendary,s:1.1}Vio's {s:1.1}Undertale Mod",
					"{C:inactive,s:0.8}Dog Residue {C:inactive,s:0.8,E:2,u:inactive}not{C:inactive,s:0.8} included!",
				}
			},
			-- SEMBY:
			SEMBY_event_horizon = {
				name = "Event Horizon",
				text = {
					"Destroyed when",
					"it's {C:attention}Singularity",
					"is removed",
				}
			},
			SEMBY_forced_perishable = {
				name = "Degrading",
				text = {
					"Destroyed",
					"after {C:attention}#1#{} rounds",
					"{C:inactive}({C:attention}#2#{C:inactive} remaining)",
				}
			},
			SEMBY_lavish_buff = {
				name = "Lavish",
				text = {
					"Can't be",
					"debuffed",
				}
			},
			SEMBY_possessive = {
				name = "Possessive",
				text = {
					"Can't be sold",
				}
			},
			SEMBY_tmtrainer_sticker = {
				name = "TMTRAINER'd",
				text = {
					"Average {C:enhanced}Stats",
					"changed by {C:SEMBY_TMTRAINER}x#1#",
				}
			},
			--## Doubled for "Technical Limitations" (Skill issue)
			-- > Check Method up Top for Translation!
			SEMBY_parking_disc_1 = SEMBY_Translation_Helper({type = 'joker', key = 'parking_disc', index = 1 }),
			SEMBY_parking_disc_2 = SEMBY_Translation_Helper({type = 'joker', key = 'parking_disc', index = 2 }),
			SEMBY_parking_disc_3 = SEMBY_Translation_Helper({type = 'joker', key = 'parking_disc', index = 3 }),
			SEMBY_parking_disc_4 = SEMBY_Translation_Helper({type = 'joker', key = 'parking_disc', index = 4 }),
			SEMBY_parking_disc_5 = SEMBY_Translation_Helper({type = 'joker', key = 'parking_disc', index = 5 }),
			SEMBY_parking_disc_6 = SEMBY_Translation_Helper({type = 'joker', key = 'parking_disc', index = 6 }),
			SEMBY_parking_disc_7 = SEMBY_Translation_Helper({type = 'joker', key = 'parking_disc', index = 7 }),
			SEMBY_parking_disc_8 = SEMBY_Translation_Helper({type = 'joker', key = 'parking_disc', index = 8 }),
			SEMBY_parking_disc_9 = SEMBY_Translation_Helper({type = 'joker', key = 'parking_disc', index = 9 }),
			SEMBY_parking_disc_10 = SEMBY_Translation_Helper({type = 'joker', key = 'parking_disc', index = 10 }),
			SEMBY_parking_disc_11 = SEMBY_Translation_Helper({type = 'joker', key = 'parking_disc', index = 11 }),
			SEMBY_parking_disc_12 = SEMBY_Translation_Helper({type = 'joker', key = 'parking_disc', index = 12 }),
		},
	},
	misc = {
		labels = {
			SEMBY_event_horizon = "Event Horizon",
			SEMBY_forced_perishable = "Degrading",
			SEMBY_pearlescent = "Pearlescent",
			SEMBY_possessive = "Possessive",
			SEMBY_shiny = "Shiny",
			SEMBY_tmtrainer_sticker = "TMTRAINER'd",
		},
		dictionary = {
			SEMBY_acquired_ex = "Acquired!",
			SEMBY_bark_1 = "Bark!",
			SEMBY_bark_2 = "Bark?",
			SEMBY_bark_3 = "Woof!",
			SEMBY_bark_4 = "Bork!",
			SEMBY_bark_5 = "Meow!",
			SEMBY_bigg = "Huge",
			SEMBY_blocked_ex = "Blocked!",
			SEMBY_bonus_hand = "Bonus Hand",
			SEMBY_broken_ex = "Broken!",
			SEMBY_burn = "BURN",
			SEMBY_card_mined_ex = "Card Mined!",
			SEMBY_collapsed_ex = "Collapsed!",
			SEMBY_consumeable_none_1 = "Invalid",
			SEMBY_consumeable_none_2 = "None",
			SEMBY_consumeable_none_3 = "404",
			SEMBY_consumeable_plus = "+1 Consumable",
			SEMBY_desc_challenge = "Challenge-Jokers excluded!",
			SEMBY_desc_destroyed = "(Destroyed after use)",
			SEMBY_desc_ignore_eternal = "(Can change Eternal Cards)",
			SEMBY_desc_maintained = "(Maintained after use)",
			SEMBY_destroyed_ex = "Destroyed!",
			SEMBY_dog_overflow = 'Too many dogs!',
			SEMBY_downgrade_ex = "Downgrade!",
			SEMBY_durability_destroy = "Used up!",
			SEMBY_durability_refilled = "Refilled!",
			SEMBY_durability_repaired = "Repaired!",
			SEMBY_durability_revitalized = "Revitalized!",
			SEMBY_echoed_ex = "Echoed!",
			SEMBY_embraced_1 = "Warm",
			SEMBY_embraced_2 = "Comfy",
			SEMBY_embraced_3 = "Safe",
			SEMBY_embraced_4 = "Loved",
			SEMBY_emergency_meeting = "EMERGENCY MEETING",
			SEMBY_enhancement = "Enhancement",
			SEMBY_eternal_cleared = "Eternal Cleared",
			SEMBY_eval_cockroach = "Skitters",
			SEMBY_explode_1 = "BOOM!",
			SEMBY_explode_2 = "BAM!",
			SEMBY_explode_3 = "KAPOW!",
			SEMBY_failed_ex = "Failed!",
			SEMBY_goobert_1 = "I tried...",
			SEMBY_goobert_2 = "P-proud?",
			SEMBY_goobert_3 = "T-thoughts?",
			SEMBY_goobert_4 = "I-is good?",
			SEMBY_goobert_X = "Arrrghh!",
			SEMBY_hit_ex = "Hit!",
			SEMBY_hype_start = "Let's Go!",
			SEMBY_joker_slot_plus = "+1 Joker Slot",
			SEMBY_level_up_ex = "Level Up!",
			SEMBY_miss_ex = "Miss!",
			SEMBY_money_clean = "All Clean",
			SEMBY_money_dirty = "NOT CLEAN!!",
			SEMBY_nothing = "Nothing",
			SEMBY_oblivion_allowed = "Continue...",
			SEMBY_oblivion_removed = "Escaped...",
			SEMBY_overshot_ex = "Overshot!",
			SEMBY_parking_disc_boss_2 = "Additional Hands",
			SEMBY_parking_disc_boss_3 = "Reduce Blind Size",
			SEMBY_parking_disc_boss_4 = "Disable Boss Blind",
			SEMBY_perfect_ex = "Perfect!",
			SEMBY_pitch_shift = "Pitch Shift!",
			SEMBY_possessed_ex = "Possessed!",
			SEMBY_printed_ex = "Printed!",
			SEMBY_quest_abandoned = "Quest Abandoned!",
			SEMBY_quest_accepted = "Quest Accepted!",
			SEMBY_quest_active_beat = "Currently Active",
			SEMBY_quest_active_beat_reset = "Active next Blind",
			SEMBY_quest_active_shot = "Active in Blinds",
			SEMBY_quest_active_use = "Always Active",
			SEMBY_quest_completed = "Quest Complete!",
			SEMBY_quest_duplicated = "Duplicated!?",
			SEMBY_ritual_complete = "Complete!",
			SEMBY_ritual_inactive = "Inactive...",
			SEMBY_seal = "Seal",
			SEMBY_smoll = "Tiny",
			SEMBY_sorted_ex = "Sorted!",
			SEMBY_T3MPRR_1 = "FEELN GREAT",
			SEMBY_T3MPRR_2 = "DW C UR FACE",
			SEMBY_T3MPRR_3 = "MISS UR TASTE",
			SEMBY_T3MPRR_4 = "3 PACKS A DAY",
			SEMBY_target = "Target",
			SEMBY_this_edition = "(This Edition)",
			SEMBY_tides_high = "High Tides",
			SEMBY_tides_low = "Low Tides",
			SEMBY_TMTRAINER_BL = "Blacklist!",
			SEMBY_TMTRAINER_N1 = "Unchanged...",
			SEMBY_TMTRAINER_N2 = "Unchanged...",
			SEMBY_TMTRAINER_N3 = "ncha..Ugedn.",
			SEMBY_TMTRAINER_N4 = "ZZcZZnZZd...",
			SEMBY_TMTRAINER_Y1 = "Changed!",
			SEMBY_TMTRAINER_Y2 = "Changed!",
			SEMBY_TMTRAINER_Y3 = "han!Cedg",
			SEMBY_TMTRAINER_Y4 = "ZZaZZeZ!",
			SEMBY_unchanged = "Unchanged",
			-- Special Keys:
			SEMBY_NaN = "NaN", --> Not a Number
			-- Mod-Menu Keys:
			SEMBY_artist_tab = "Artists",
			SEMBY_artist_placeholder = "Placeholder",
			-- Flowire Extra Credits
            SEMBY_artist_other_1 = "Also created Blinds,",
            SEMBY_artist_other_2 = "Stickers and Tags.",
			-- unkokat Extra Credits
            SEMBY_artist_title_1 = "Is working on the",--"Also created Title",
			SEMBY_artist_title_2 = "WIP Jokers, Thank You!",--"Screen background.",
			-- NSFW-Link Warning
			SEMBY_artist_warn_0 = "Mature Content Warning",
			SEMBY_artist_warn_1 = "The Website you are about to",
			SEMBY_artist_warn_2 = "visit contains NSFW/18+ content!",
			SEMBY_artist_warn_3 = "Please proceed with caution.",
			-- Proceed
			SEMBY_artist_proceed = "Proceed",
			-- Sound Credits are all Hardcoded (in English);
			SEMBY_artist_sound = "Sounds",
		},
		v_dictionary = {
			SEMBY_consumeables = "+#1# Consumables",
			SEMBY_discards = "+#1# Discards",
			SEMBY_discards_minus = "-#1# Discards",
			SEMBY_durability_uses_eval = "#1#",
			SEMBY_left = "#1# Left",
			SEMBY_loop = "Loop #1#",
			SEMBY_minus = "-#1#",
			SEMBY_money = "$#1#",
			SEMBY_money_left = "$#1# Left",
			SEMBY_money_minus = "-$#1#",
			SEMBY_out_of = "#1#/#2#",
			SEMBY_parking_disc_boss_1 = "#1#x Effectiveness",
			SEMBY_percentage = "+#1#%",
			SEMBY_percentage_minus = "-#1#%",
			SEMBY_plus = "+#1#",
			SEMBY_spectrals = "+#1# Spectrals",
			SEMBY_up_blind_size = "+#1#% Size",
			SEMBY_up_chips = "+#1# Chips",
			SEMBY_up_payout = "+$#1# Payout",
		},
		challenge_names = {
			-- Page 1:
			c_SEMBY_berry_good_meal = "A Berry Good Meal",
			c_SEMBY_tool_for_every_joke = "A Tool for every Joke",
			c_SEMBY_perishable_fate = "Perishable Fate",
			c_SEMBY_countdown = "Countdown",
			c_SEMBY_shiny_hunt = "Shiny Hunt",
			c_SEMBY_hunter = "Hunter",
			c_SEMBY_hunted = "Hunted",
			c_SEMBY_done_deal = "Done Deal",
			c_SEMBY_the_last_unicorn = "The Last Unicorn",
			c_SEMBY_the_menagerie = "The Menagerie",
			-- Page 2:
			c_SEMBY_printty_good = "Printty Good",
			c_SEMBY_gaokao = "Gaokao",
			c_SEMBY_lavish_dreams = "Lavish Dreams",
			c_SEMBY_uses_left = "50 uses left",
			c_SEMBY_parking_roulette = "Parking Roulette",
			c_SEMBY_qwest = "Qwest?",
			c_SEMBY_emperor_calus = "Emperor Calus",
			c_SEMBY_speed_of_light = "Speed of Light",
			c_SEMBY_DELETE_THIS = "DELETE THIS",
			c_SEMBY_grandmaster_menagerie = "Grandmaster Menagerie",
			-- Page 3 (UNUSED):
			c_SEMBY_seven_years_luck = "Seven Years Luck",
			c_SEMBY_exodia = "Exodia",
		},
		v_text = {
			-- Misc.
			ch_c_SEMBY_space = { "{s:0.5} ", },
			-- Page 1 (Lore):
			ch_c_SEMBY_berry_good_meal = { "A tasty {C:blue}Tutorial{} for the {C:attention}Berry Jokers{}!" },
			ch_c_SEMBY_tool_for_every_joke = { "A handy {C:blue}Tutorial{} for the {C:attention}Tool Jokers{}!" },
			ch_c_SEMBY_perishable_fate = { "Age and {C:purple,E:2}Wither{}, don't turn bitter." },
			ch_c_SEMBY_countdown = { "{C:inactive}30:00... 29:59... 29:58... 29:57... 29:56..." },
			ch_c_SEMBY_shiny_hunt = { "Enjoy increased {C:money}Shiny{} spawns!" },
			ch_c_SEMBY_hunter = { "Welcome to {C:enhanced}Balatro{}, {C:attention}47{}." },
			ch_c_SEMBY_hunter_1 = { "{C:dark_edition,E:1}Win{} by beating a Blind" },
			ch_c_SEMBY_hunter_2 = { "with {C:attention}10 or less{} Cards" },
			ch_c_SEMBY_hunter_3 = { "in your full Deck!" },
			ch_c_SEMBY_hunted = { "{C:red}Target Acquired." },
			ch_c_SEMBY_hunted_1 = { "{C:red,E:2}Lose{} when beating a Blind" },
			ch_c_SEMBY_hunted_2 = { "with {C:attention}30 or less{} Cards" },
			ch_c_SEMBY_hunted_3 = { "in your full Deck!" },
			ch_c_SEMBY_done_deal = { "{C:attention}King{} of {C:dark_edition,E:1}Everything{}, {C:attention}King{} of {E:2}Nothing{}." },
			ch_c_SEMBY_the_last_unicorn = { "The Last Hunt." },
			ch_c_SEMBY_the_last_unicorn_1 = { "{C:dark_edition,E:1}Win{} by beating a Blind" },
			ch_c_SEMBY_the_last_unicorn_2 = { "without the {C:attention}Unicorn{}." },
			ch_c_SEMBY_the_menagerie = { "Pleasure and delight awaits {C:attention}You{}." },
			-- Page 2 (Lore):
			ch_c_SEMBY_printty_good = { "A productive {C:blue}Tutorial{} for the {C:attention}Copy Printer{}!" },
			ch_c_SEMBY_gaokao = { "An annual {C:blue}Tutorial{} for {C:attention}Jokebra{}!" },
			ch_c_SEMBY_lavish_dreams_1 = { '"Prove Your {E:1}Worth{}."' },
			ch_c_SEMBY_lavish_dreams_2 = { '            - {C:money}Lavish Joker' },
			ch_c_SEMBY_uses_left_1 = { "{C:attention}JOKER{} IS ETERNAL." },
			ch_c_SEMBY_uses_left_2 = { "{C:money}MONEY{} IS FUEL." },
			ch_c_SEMBY_uses_left_3 = { "{C:enhanced}BALATRO{} IS FULL." },
			ch_c_SEMBY_used_up_1 = { "{C:red,E:2}Lose{} when beating a" },
			ch_c_SEMBY_used_up_2 = { "Blind with {C:money}$0 {C:attention}or less{}!" },
			ch_c_SEMBY_parking_roulette = { "{C:attention,E:2}Three {C:red,E:2}Cherries{} = {C:blue,E:2}Parking Spot" },
			ch_c_SEMBY_qwest_1 = { "Epic {C:enhanced}Dungeons{}, Cool {C:legendary}Dragons{}..." },
			ch_c_SEMBY_qwest_2 = { "But no {C:red}Demons{}!" },
			ch_c_SEMBY_emperor_calus = { "{E:2}Grow Fat From {C:attention,E:2}Strength" },
			ch_c_SEMBY_speed_of_light = { "Reach the {C:attention}edge{} of the {C:dark_edition,E:1}Universe{}!" },
			ch_c_SEMBY_DELETE_THIS_1 = { "DELETETHISRESOURCENOTFOUNDDELETETHISRESOURCENOTFOUND" }, -- 2x "Delete This" and "Resource not found",
			ch_c_SEMBY_DELETE_THIS_2 = { "RESOURCENOTFOUNDDELETETHISRESOURCENOTFOUNDDELETETHIS" }, -- 2x "Delete This" and "Resource not found",
			ch_c_SEMBY_DELETE_THIS_3 = { "NOTFOUNDDELETETHISRESOURCENOTFOUNDDELETETHISRESOURCE" }, -- 2x "Delete This" and "Resource not found",
			ch_c_SEMBY_DELETE_THIS_4 = { "FOUNDDELETETHISRESOURCENOTFOUNDDELETETHISRESOURCENOT" }, -- 2x "Delete This" and "Resource not found",
			ch_c_SEMBY_grandmaster_menagerie = { "Sorrow and despair awaits {C:red}Us{}." },
			-- Page 3 (Lore)(UNUSED):
			ch_c_SEMBY_seven_years_luck_1 = { "{C:attention}Shatter{} every {C:enhanced}Mirror{}," },
			ch_c_SEMBY_seven_years_luck_2 = { "{C:attention}13{} is your {E:2}Lucky Number" },
			-- Modifiers:
			ch_c_SEMBY_aggressive_scaling = { "{C:red,E:2}X4.0{} base Blind size" },
			ch_c_SEMBY_countdown_mode = { "Don't regain {C:blue}Hands{} or {C:red}Discards" },
			ch_c_SEMBY_degrading = { "All Cards are {C:attention}Degraging", },
			ch_c_SEMBY_extra_bonus = { "Extra {C:blue}Hands{} earn {C:green}more{} money", },
			ch_c_SEMBY_gold_stake = { "Apply {C:money}Gold Stake{} difficulty" },
			ch_c_SEMBY_impossible_blinds = { "{C:red,E:1}Impossible{} Score-Requirements" },
			ch_c_SEMBY_menagerie_mode = { "{C:legendary,E:1}Multiplies{} Blind size by current Ante" },
			ch_c_SEMBY_no_showdown = { "No {C:attention}Showdown{} Blinds" },
			ch_c_SEMBY_no_win_ante = { "No {C:dark_edition,E:1}Winning{} Ante" },
			ch_c_SEMBY_quick_scaling = { "{C:red}X1.5{} base Blind size" },
			ch_c_SEMBY_remaining_discard_pay = { "{C:red}Pay {C:money}$1{} per remaining {C:red}Discard" },
			ch_c_SEMBY_remaining_hand_pay = { "{C:red}Pay {C:money}$2{} per remaining {C:blue}Hand" },
			ch_c_SEMBY_slow_scaling = { "{C:green}X0.5{} base Blind size" },
			ch_c_SEMBY_upgrade_pokerhands = { "Start with {C:green}better {E:2}Poker Hands" },
			-- Lovely Patched:
			ch_m_winning_ante = { "Winning Ante: {C:attention}#1#", },
		},
	},
}
