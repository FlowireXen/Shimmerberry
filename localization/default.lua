local alt = math.random() < 0.1 --> Alt. Descriptions
--## Translations:
return {
	descriptions = {
        Mod = {
            SEMBY = {
                name = "Shimmerberry",
                text = {
					"{s:0.5} ",
					"Welcome to {C:SEMBY_flowire,s:1.1,E:1}Shimmerberry{}!",
					"{s:0.2} {}",
					"{C:SEMBY_flowire}Shimmerberry{} adds {C:dark_edition}Custom{},",
					"{C:legendary}Fluffy{} and {C:attention}Vanilla-Like{} content:",
					"{s:0.2} {}",
					"{C:attention}90{} Jokers, {C:blue}20{} Challenges, {C:tarot}4{} Vouchers,",
					"{C:red}3{} Decks {C:inactive,s:0.9}(& Sleeves){}, {C:spectral}3{} Consumables",
					"and {C:dark_edition,E:1}more{}!",
                    " ",
                    "Programming by {C:SEMBY_flowire}Flowire{}.",
                    "Art by {C:SEMBY_unkokat}unkokat{} and {C:SEMBY_flowire}Flowire{}.",
                    " ",
					"Check the {C:attention}Collection{}-View or the",
					"{C:SEMBY_unkokat}Credits{}-Tab for detailed credits!",
					" ",
					"{s:1.2}Have fun! {C:red,s:1.2}<3",
					--"{u:inactive}                                   ",
                    --"{s:0.5} ",
                    --"Leave Feedback or Report Bugs here:",
					--"{C:enhanced,u:enhanced,s:0.9}https://{C:enhanced,s:0.9}g{C:enhanced,u:enhanced,s:0.9}ithub.com/FlowireXen/Shimmerberr{C:enhanced,s:0.9}y",
					----> https://github.com/FlowireXen/Shimmerberry
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
					"{C:SEMBY_debuff}Debuff{} a random suit",
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
				name = alt and "Toby Fox" or "Annoying Dog",
				text = {
					"{s:0.2} {}",
					"{X:mult,C:white}X#1#{} Mult",
					"{s:0.2} {}",
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
			j_SEMBY_arcoex = {
				name = { "A.C.E.", "{C:inactive,s:0.6}Arbitrary Code Execution", },
				text = {
					"Add the next {C:attention}#1# to #2#{}",
					"playing cards from",
					"Deck to scoring hand",
				}
			},
			j_SEMBY_balloon = {
				name = "Balloon",
				text = {{
					"{X:mult,C:white}X#1#{} Mult",
				}, {
					"{C:red,E:2}Self destructs{}",
					"when highlighting",
					"{C:attention}#2# or more{} cards",
				}}
			},
			j_SEMBY_barmy_joker = {
				name = "Barmy Joker",
				text = {
					"{C:mult}+#1#{} Mult if poker",
					"hand contains",
					"{C:attention}#2#{} different suits",
				}
			},
			j_SEMBY_benthic_bloom = {
				name = "Benthic Bloom",
				text = {
					"Retrigger all",
					"{C:enhanced}Enhanced Cards",
					"{s:0.2} {}",
					"{C:enhanced}Enhanced Cards{} have",
					"a {C:green}#1# in #2#{} chance to",
					"shatter like {C:attention}Glass",
					"{s:0.2} {}",
					"{C:SEMBY_possessive,E:2}Possessive",
				}
			},
			j_SEMBY_berry_blue = {
				name = "Blueberry",
				text = {{
					"Each scored",
					"{C:attention}#1#{} or {C:attention}#2#",
					"gives {C:chips}+#3#{} Chips",
					"{s:0.1} ",
					"{C:inactive}Ranks change",
					"{C:inactive}every round",
				}, {
					"{s:0.9}Gets {C:red,s:0.9,E:2}Eaten{s:0.9} when",
					"{s:0.9}no {C:attention,s:0.9}#1#{s:0.9} or {C:attention,s:0.9}#2#",
					"{s:0.9}scored this round",
				}}
			},
			j_SEMBY_berry_golden = {
				name = "Goldenberry",
				text = {{
					"Each scored",
					"{C:attention}#1#{} or {C:attention}#2#",
					"earns {C:money}$#3#{}",
					"{s:0.1} ",
					"{C:inactive}Ranks change",
					"{C:inactive}every round",
				}, {
					"{s:0.9}Gets {C:red,s:0.9,E:2}Eaten{s:0.9} when",
					"{s:0.9}no {C:attention,s:0.9}#1#{s:0.9} or {C:attention,s:0.9}#2#",
					"{s:0.9}scored this round",
				}}
			},
			j_SEMBY_berry_shimmer = {
				name = "Shimmerberry",
				text = {{
					"Each scored",
					"{C:attention}#1#{} or {C:attention}#2#",
					"{C:green}reduces {C:attention}Blind",
					"{C:attention}Size{} by {C:SEMBY_percent}#3#%",
					"{s:0.1} ",
					"{C:inactive}Ranks change",
					"{C:inactive}every round",
				}, {
					"{s:0.9}Gets {C:red,s:0.9,E:2}Eaten{s:0.9} when",
					"{s:0.9}no {C:attention,s:0.9}#1#{s:0.9} or {C:attention,s:0.9}#2#",
					"{s:0.9}scored this round",
				}}
			},
			j_SEMBY_berry_straw = {
				name = "Strawberry",
				text = {{
					"Each scored",
					"{C:attention}#1#{} or {C:attention}#2#",
					"gives {C:mult}+#3#{} Mult",
					"{s:0.1} ",
					"{C:inactive}Ranks change",
					"{C:inactive}every round",
				}, {
					"{s:0.9}Gets {C:red,s:0.9,E:2}Eaten{s:0.9} when",
					"{s:0.9}no {C:attention,s:0.9}#1#{s:0.9} or {C:attention,s:0.9}#2#",
					"{s:0.9}scored this round",
				}}
			},
			j_SEMBY_boosterpack_joker = {
				name = "Booster Pack",
				text = {{
					"{C:attention}#1#{} additional",
					"{C:attention}Booster Packs",
					"in each {C:money}Shop",
				}, {
					"{V:1}#2#{} uses left",
				}}
			},
			j_SEMBY_bound = {
				name = "Bound Joker",
				text = {
					"When obtaining or",
					"destroying this card,",
					"apply {C:SEMBY_debuff}Bound{} to",
					"{C:attention}#1#{} random Jokers",
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
					"Adds {C:attention}#1#{} times the sell",
					"value of all other",
					"owned {C:attention}Jokers{} to {C:chips}Chips",
					"{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)",
				}
			},
			j_SEMBY_bunburrow = {
				name = "Bunburrow",
				text = {
					"Gain {C:money}$#1#{} every",
					"{C:attention}#2# {C:green}Rerolls{}",
					"{C:inactive}(#3# remaining){}",
				}
			},
			j_SEMBY_butterfly = {
				name = "Butterfly",
				text = {{
					"{C:chips}#1#{} Chips", -- No "+/-"!
				}, {
					"{C:green}Gains {C:chips}+#2#{} Chips",
					"if played hand",
					"contains a {C:attention}#4#{},",
					"{C:red}Loses {C:chips}#3#{} Chips",
					"if it doesn't",
				}}
			},
			j_SEMBY_cassette_beast = {
				name = "Cassette Beast",
				text = {
					"Retrigger scoring cards",
					"for {C:attention}each{} scoring suit",
					"beyond the first suit",
				}
			},
			j_SEMBY_ceaseless_void = {
				name = "Ceaseless Void",
				text = {{
					"When a Card is {C:attention}sold{}, gain",
					"{C:SEMBY_percent}+#1#%{} Blind Size, {X:mult,C:white}X#2#{} Mult",
					"or {X:chips,C:white}X#3#{} Chips for each",
					"{C:money}$#4#{} of sell value",
				}, {
					"When {C:attention}Blind{} is selected",
					"{C:red}increase{} Blind Size by {C:SEMBY_percent}#5#%",
					"{X:chips,C:white}X#6#{} Chips, {X:mult,C:white}X#7#{} Mult",
				}}
			},
			j_SEMBY_chrono_break = {
				name = "Chrono Break",
				text = {{
					"{C:legendary,E:1}Revive{} shattered",
					"{C:attention}playing cards",
				}, {
					"{C:attention}Shatter{C:green} #1# in #2#{}",
					"scoring cards",
				}}
			},
			j_SEMBY_cockroach = {
				name = "Cockroach",
				text = {
					"{C:green}Reduces{} Blind",
					"Sizes by {C:SEMBY_percent}#1#%{}",
					"{s:0.2} {}",
					"{C:attention}+#2#{} Ante when",
					"{C:attention}Boss Blind{}",
					"is defeated",
					"{s:0.2} {}",
					"{C:SEMBY_possessive,E:2}Possessive{}",
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
					"{s:0.2} {}",
					"Raise prices by {C:red}#2#%",
					"on every {C:green}Reroll",
				}
			},
			j_SEMBY_daffy_joker = {
				name = "Daffy Joker",
				text = {
					"{C:mult}+#1#{} Mult if poker",
					"hand contains",
					"{C:attention}#2#{} different suits",
				}
			},
			j_SEMBY_DATAMINER = {
				name = "DATAMINER",
				text = {
					"{C:SEMBY_TMTRAINER,E:1}Changes{} most",
					"{C:enhanced}Numbers{} on newly",
					"obtained {C:attention}Jokers{}",
					"by {C:red}X#1#{} or {C:green}X#2#{}",
				}
			},
			j_SEMBY_doomsday_device = {
				name = "Doomsday Device",
				text = {
					"{C:attention}Double{} the stored",
					"{C:chips}Memory Value{} every {C:attention}#1#{}",
					"scoring {C:enhanced}Memory Cards{}",
					"{C:inactive}(Currently {C:attention}#2#{C:inactive}/#1#){}",
				}
			},
			j_SEMBY_echoing_joker = {
				name = "Echoing Joker",
				text = {
					"Creates {C:attention}#1#{} {C:dark_edition}Negative{}",
					"copies of the next",
					"used {C:attention}Consumable{},",
					"{C:red,E:2}self destructs{}"
				}
			},
			j_SEMBY_eden_blessing = {
				name = "Eden's Blessing",
				text = {{
					"{X:SEMBY_eden,C:white}X#1#{} Chips or Mult,",
					"favours the small",
				}, {
					"Grants a",
					"{C:SEMBY_eden,E:1}Brighter Future{}",
					"when {C:attention}Boss Blind{}",
					"is defeated",
				}}
			},
			j_SEMBY_eden_blessing_alt = {
				name = "Eden's Blessing",
				text = {
					"{X:SEMBY_eden,C:white}X#1#{} Chips or Mult,",
					"favours the small",
				}
			},
			j_SEMBY_emergency_button = {
				name = "Emergency Button",
				text = {
					"Prevents Death and",
					"{C:green}Rerolls{} all {C:attention}Jokers{}",
					"and {C:attention}Consumables{}",
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
			j_SEMBY_fire_exint = {
				name = "Fire Exin't",
				text = {
					"Reduce Shop prices",
					"by {C:money}#1#%{} every played",
					"and {C:attention}unscored{} card,",
					"resets when {C:attention}Boss{}",
					"{C:attention}Blind{} is selected",
					"{C:inactive}(Currently {C:money}#2#%{C:inactive}/#3#%){}",
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
			j_SEMBY_foxie_plush = {
				name = "Fox Plush",
				text = {
					"{C:chips}+#1#{} Chips for",
					"each {C:attention}Joker{} and",
					"{C:mult}+#2#{} Mult for each",
					"empty {C:attention}Joker{} slot",
					"{C:inactive}({C:chips}+#3#{}{C:inactive} Chips, {}{C:mult}+#4#{}{C:inactive} Mult)",
				}
			},
			j_SEMBY_garden_gnome = {
				name = "Garden Gnome",
				text = {
					"{C:mult}+#1#{} Mult",
					"{C:attention}-#2#{} Hand size",
				}
			},
			j_SEMBY_ghostsalt_contract = {
				name = alt and "Evil Deal" or "Gambler's Contract",
				text = {
					"Shop Jokers have",
					"a {C:green}#1# in #2#{} chance to",
					"become {C:dark_edition}Negative{} and",
					"a {C:green}#3# in #4#{} chance to",
					"become {C:SEMBY_possessive,E:2}Possessive{}",
					"{C:inactive,s:0.9}(Fixed probabilities){}",
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
				text = {{
					"Discarded cards gain",
					"a random {C:dark_edition}Edition{},",
					"{C:enhanced}Enhancement{} or {C:attention}Seal{}",
				}, {
					"{V:1}#1#{} uses left",
					"{C:attention,s:0.9}-#2#{C:inactive,s:0.9} for first {C:attention,s:0.9}#3#{}",
					"{C:inactive,s:0.9}cards each discard{}",
				}}
			},
			j_SEMBY_hypetrain = {
				name = alt and "HYPETRAIN" or "Hypetrain",
				text = {
					"Level {X:mult,C:white}X#1#{}!",
					"Next stop in:",
					"{s:0.2} {}",
					"{C:mult}+#2#{} Mult",
					"{s:0.2} {}",
				}
			},
			j_SEMBY_hypetrain_info = {
				name = "Info Board",
				text = {
					"Your {C:attention}Joker{} arrives in:",
					"{s:0.2} {}",
					"{C:mult}+#1#{} Mult",
					"{s:0.2} {}",
				}
			},
			j_SEMBY_hypetrain_info_glitch = {
				name = "Info Board",
				text = {
					"Level {X:SEMBY_TMTRAINER,C:white}X#1#{E:1}?",
					"Next stop in:",
					"{s:0.2} {}",
					"{C:mult}+#2#{} Mult",
					"{s:0.2} {}",
				}
			},
			j_SEMBY_improv = {
				name = "Improv Show",
				text = {{
					"Converts unused",
					"{C:blue}Hands{} into {C:green}Points{}",
					"at end of round",
				}, {
					"When playing your",
					"{C:attention}final hand{}, convert",
					"{C:attention}#1# {C:green}Point{} into {C:attention}#2# {C:blue}Hand{}",
				}, {
					"Stored: {C:attention}#3# {C:green}Points{}",
					"{C:inactive}(Next point: #4#%)",
				}}
			},
			j_SEMBY_incinerator = {
				name = "Incinerator",
				text = {
					"{C:green}+#1#{} Discard Limit",
				}
			},
			j_SEMBY_inventation = {
				name = "Inven-Tation", -- Invent + Invite
				text = {
					"{C:enhanced}Vintage Cards{} have a",
					"{C:green}#1# in #2#{} chance to upgrade",
					"the played poker hand",
				}
			},
			j_SEMBY_jevil = {
				name = "JEV][L",
				text = {
					"Played {C:attention}Playing Cards{}",
					"evaluate {C:attention}twice{}",
				}
			},
			j_SEMBY_jokebra = {
				name = "Jokebra",
				text = {
					"When {C:attention}Blind{} is selected,",
					"set an additional {C:enhanced}Target",
					"{C:inactive}(Between {C:blue}#1#{C:inactive} and {C:blue}#2#{C:inactive})",
					"{s:0.2} {}",
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
				name = alt and "Lavish Chad" or "Lavish Joker",
				text = {{
					"Regain lost {C:money}Money{}",
					"at start of {C:attention}shop{}",
					"{C:inactive}(Currently {C:money}$#1#{C:inactive}){}",
				}, {
					"Each {C:money}$#2#{} regained",
					"{C:red}increases{} the next",
					"{C:attention}Blind Size{} by {C:SEMBY_percent}#3#%",
					"{C:inactive}(Currently {C:SEMBY_percent}+#4#%{C:inactive})",
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
					"Scoring {C:attention}non-face{} cards",
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
					"{C:inactive}(Currently {C:attention}#2#{C:inactive}/#1#)",
				}, {
					"{V:1}#3#{} uses left",
				}}
			},
			j_SEMBY_misery = {
				name = "Misery",
				text = {
					"{X:mult,C:white}X#1#{} Mult",
					"{s:0.2} {}",
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
					"{C:red}Increase{} shop",
					"prices by {C:money,E:1}#3#%",
				}}
			},
			j_SEMBY_nashi_pear = {
				name = "Nashi Pear",
				text = {
					"When Blind is selected,",
					"increase {C:attention}Round score{}",
					"by {C:SEMBY_percent}#1#{} and reduce",
					"this by {C:SEMBY_percent}#2#{}",
				}
			},
			j_SEMBY_nostalgia = {
				name = "Nostalgia",
				text = {{
					"When Blind is selected,",
					"take {C:money}$#1#{} of {C:attention}sell value{}",
					"from every {C:attention}Joker{} and",
					"{C:attention}Consumable{} card",
				}, {
					"Create a {C:attention}Memory{} card",
					"for every {C:money}$#2#{} taken",
					"{C:inactive}({C:money}$#3#{C:inactive} remaining){}",
				}}
			},
			j_SEMBY_oblivion = {
				name = "Oblivion",
				text = {{
					"When beating an {C:attention}Ante{}",
					"you may choose to",
					"{E:2}Loop back{} to Ante {C:attention}#1#{}",
				}, {
					"Gain {X:mult,C:white}X#2#{} Mult each",
					"Ante looped back",
					"{C:inactive}(Currently {X:mult,C:white}X#3#{C:inactive} Mult){}",
				}, {
					"When looping back,",
					"{E:2}permanently{C:red} increase{}",
					"all {C:attention}Blind Sizes{} by {C:SEMBY_percent}#4#%{}",
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
				text = {{
					"Sell this card to",
					"{C:attention}replace{} a random",
					"card in the Shop",
					"with this {C:attention}Joker{}",
				}, {
					"{C:green}#1# in #2#{} chance",
					"to transform into",
					"a {C:legendary,E:1}Legendary{} Joker",
					"when {C:attention}Bought{}",
				}}
			},
			j_SEMBY_ouroboros = {
				name = "Ouroboros",
				text = {
					"Each scored {C:attention}8{} gives",
					"{C:blue}+#1#{} Hand and {C:red}increases",
					"the {C:attention}Blind Size{} by {C:SEMBY_percent}#2#%",
				}
			},
			j_SEMBY_paper_swan = {
				name = "Paper Swan",
				text = {
					"{X:chips,C:white}X#1#{} Chips every",
					"{C:attention}#2#{} scoring cards",
					"{C:inactive}(Currently {C:attention}#3#{C:inactive}/#2#)",
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
					"each Hand"
				}
			},
			j_SEMBY_peculiar_joker = {
				name = "Peculiar Joker",
				text = {
					"{C:chips}+#1#{} Chips if poker",
					"hand contains",
					"{C:attention}#2#{} different suits",
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
                    "When {C:attention}Blind{} is selected",
                    "or skipped, spend {C:money}$#4#{} to",
                    "add {C:money}$#5#{} of {C:attention}sell value",
                }, {
                    "Starts with {C:money}$#6#",
                    "extra {C:attention}sell value",
				}, {
					"{X:mult,C:white}X#1#{} Mult for every",
					"{C:money}$#2#{} of {C:attention}sell value",
					"{C:inactive}(Currently {}{X:mult,C:white}X#3#{}{C:inactive} Mult)",
				}}
			},
			j_SEMBY_pinata = {
				name = alt and "Quick Brown Fox" or "Piñata",
				text = {{
					"{C:green}#1# in #2#{} chance to",
					"break open {C:attention}each",
					"{C:attention}hand{} played",
				}, {
					"Gain {C:attention}+#1#{} permanent",
					"{C:attention}Consumable{} slot and",
					"fill all Consumable",
					"slots when Joker",
					"gets destroyed",
				}, {
					"Won't appear again",
					"when destroyed",
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
					"{s:0.2} {}",
					"{C:attention}+#1#{} Consumable slots",
					"{s:0.2} {}",
				}
			},
			j_SEMBY_potted_flowers = {
				name = "Potted Flower",
				text = {
					"{X:chips,C:white}X#1#{} Chips if poker",
					"hand contains",
					"{C:attention}#2#{} different suits",
				}
			},
			j_SEMBY_pygmymall = {
				name = "Pygmymall",
				text = {
					"{C:attention}+#1#{} card slots",
					"available in shop",
					"every {C:attention}#2#{} shops",
					"{C:inactive}#3#",
				}
			},
			j_SEMBY_quest = {
				name = "Quest?",
				text = {
					"Start a {C:enhanced,E:2}Quest{}!",
					"{s:0.2} {}",
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
				-- Philosopher's Stone:
				name = alt and "Reagent" or "Red Lion",
				text = {
					"{X:mult,C:white}X#1#{} Mult",
					"{s:0.2} {}",
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
			j_SEMBY_replicator = {
				name = "Replicator",
				text = {
					"{C:attention}Destroys{} the next {C:attention}#1#{}",
					"playing cards added to",
					"the deck to {C:attention}Duplicate{}",
					"the rightmost Joker",
					"{C:red,E:2}self destructs{}",
					"{C:inactive}(Currently {C:attention}#2#{C:inactive}/#1#){}",
				}
			},
			j_SEMBY_ripped_joker = {
				name = "Ripped Joker",
				text = {
					"{C:chips}+#1#{} Chips if played",
					"hand contains",
					"exactly {C:attention}#2#{} cards",
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
					"{V:1}#1#{C:inactive}/#2#{} Hand size",
					"{s:0.2} {}",
					"When a {C:attention}Joker{} is {C:attention}sold{},",
					"gain {C:attention}+#3#{} Hand size for",
					"each {C:money}$#4#{} of sell value",
					"{s:0.2} {}",
					"{C:red}Lose {C:attention}#5#{} Hand size",
					"each {C:blue}Hand{} played",
				}
			},
			j_SEMBY_scav_prototype = {
				name = "Scav. Prototype",
				text = {{
					"When {C:attention}Blind{} is selected,",
					"destroy {C:attention}adjacent{} Jokers",
				}, {
					"{C:green}#1# in #2#{} chance to gain",
					"a {C:attention}Duplitage{} for each",
					"destroyed Joker",
				}}
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
					"{s:0.9,C:inactive}(Probability affected)",
				}
			},
			j_SEMBY_shrewd_joker = {
				name = "Shrewd Joker",
				text = {
					"{C:chips}+#1#{} Chips if poker",
					"hand contains",
					"{C:attention}#2#{} different suits",
				}
			},
			j_SEMBY_silver_mask = {
				name = "Silver Mask",
				text = {
					"{C:money}+$#1#{} for each {C:attention}missing{}",
					"Hand size below {C:attention}#2#{} at",
					"the end of the round",
					"{C:inactive}(Currently {C:money}$#3#{C:inactive}){}",
				}
			},
			j_SEMBY_singularity = {
				name = "Singularity",
				text = {{
					"Creates {C:attention}#1#{} copies",
					"of {C:attention}playing cards{}",
					"added to the deck",
				}, {
					"When this {C:attention}Joker{} gets",
					"removed, {C:red}Destroy{} all",
					"cards it has created",
				}, {
					"Occupies {C:attention}#2#{} Joker slots",
				}}
			},
			j_SEMBY_stern_teacher = {
				name = "Stern Teacher",
				text = {{
					"When {C:attention}Blind{} is selected,",
					"{C:SEMBY_debuff}Debuff{} adjacent Jokers",
					"for the current round",
				}, {
					"{C:mult}+#1#{} Mult for each",
					"{C:SEMBY_debuff}Debuffed{} Joker",
					"{C:inactive}(Currently {C:mult}+#2# {C:inactive}Mult)",
				}}
			},
			j_SEMBY_stylish_joker = {
				name = "Stylish Joker",
				text = {{
					"Earn {C:money}$#3#{} for every",
					"{C:attention}Consumable{} you keep",
					"at the end of round",
				}, {
					"{C:attention}+#2#{} consumable slots",
					"and {C:red}-#1#{} hand size",
				}}
			},
			j_SEMBY_stocked_shelves = {
				name = "Stocked Shelves",
				text = {{
					"{C:attention}Restocks{} bought",
					"Booster Packs, Cards",
					"and Vouchers in {C:money}Shop{}",
				}, {
					"{V:1}#1#{} uses left",
					"{C:attention,s:0.9}-#2#{C:inactive,s:0.9} for Vouchers{}",
				}}
			},
			j_SEMBY_swordswallower = {
				name = "Sword Swallower",
				text = {
					"{X:mult,C:white}X#1#{} Mult for each",
					"{X:common,C:white}Common{} Joker",
					"{C:inactive}(Currently {}{X:mult,C:white}X#2#{C:inactive} Mult){}",
				}
			},
			j_SEMBY_t3mprr = {
				name = "PUSH UR T3MPRR",
				text = {{
					"{C:attention,E:2}BLIND {E:2}SELECTED,",
					"{C:red,E:2}CLOCK IT UP {C:SEMBY_percent,E:2}#1#%",
				}, {
					"{C:attention,E:2}CARD {E:2,u:inactive}PLAYED{E:2},",
					"{C:green,E:2}PUSH IT DOWN {C:SEMBY_percent,E:2}#2#%",
				}}
			},
			j_SEMBY_tempered_glass = {
				name = "Tempered Glass",
                text = {
					"Every played {C:enhanced}Glass Card{}",
					"permanently decreases",
					"the chance of breaking",
					"by {C:attention}#1#{} when scored",
					"{C:inactive,s:0.9}(ex: {C:green,s:0.9}1 in #2#{C:inactive,s:0.9} -> {C:green,s:0.9}1 in #3#{C:inactive,s:0.9}){}",
				}
			},
			j_SEMBY_the_dwarf = {
				name = "The Dwarf",
				text = {
					"When {C:attention}Blind{} is selected,",
					"set hand size to {C:attention}#1#{} and",
					"add the {C:attention}difference",
					"to the {C:red}Discards {C:inactive}({C:red}#2#{C:inactive}){}",
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
					"obtained {C:attention}Jokers{}",
					"{s:0.2} {}",
					"Range: {C:red}#1#%{}-{C:green}#2#%{}",
					"{s:0.2} {}",
					"{C:attention}+#3#{} Joker slot",
				}
			},
			j_SEMBY_to_and_fro = {
				name = alt and "Fro n' To" or "To n' Fro",
				text = {
					"{s:0.2} {}",
					"Played cards swap",
					"{C:chips}Chips{} and {C:mult}Mult",
					"{u:inactive}before{} scoring",
					"{s:0.2} {}",
				}
			},
			j_SEMBY_fro_and_to = {
				name = alt and "Fro n' To" or "To n' Fro",
				text = {
					"{s:0.2} {}",
					"Played cards swap",
					"{C:mult}Mult{} and {C:chips}Chips",
					"{u:inactive}before{} scoring",
					"{s:0.2} {}",
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
					"All {C:attention}Jokers{} to the {C:attention}left{},",
					"that have a limited",
					"number of uses, are",
					"{C:green,E:2}repaired{} and regain",
					"up to {C:attention}#1#{} uses at the",
					"end of the round",
				}, {
					"{V:1}#2#{} uses left",
					"{C:inactive,s:0.9}Can't be repaired{}",
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
			j_SEMBY_vip_ticket = {
				name = "V.I.P. Ticket",
				text = {
					"{C:enhanced}Bonus Cards{} always",
					"shuffle to the top",
					"of the {C:attention}Deck{}",
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
				text = {{
					"Sort the Deck",
					"{C:attention,E:1}lowest to highest{}",
					"after drawing the",
					"first hand each round",
				}, {
					"Shuffles the Deck",
					"when using a {C:attention}Discard{}",
				}}
			},
			-- Vanilla Rework:
			j_SEMBY_flower_pot = {
				name = "Flower Pot",
				text = {
					"{X:mult,C:white}X#1#{} Mult if poker",
					"hand contains",
					"{C:attention}#2#{} different suits",
				}
			},
		},
		Back = {
			b_SEMBY_burning = {
				name = "Burned Deck",
				text = {
					"{C:red,E:2}Destroy{} the",
					"{C:attention}first{} scoring card",
					"every {C:blue}Hand{}",
				}
			},
			b_SEMBY_hopeless = {
				name = "Hopeless Deck",
				text = {
					"{C:dark_edition}Unknown{} Winning Ante",
					"{s:0.2} {}",
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
					"{s:0.2} {}",
					"Discard {C:red}#4#{} random cards",
					"after each hand played",
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
					"{C:red,E:2}Destroy{} the",
					"{C:attention}first{} scoring card",
					"every {C:blue}Hand{}",
				}
			},
			sleeve_SEMBY_burning_sl_alt = {
				name = "Burned Sleeve",
				text = {
					"{C:red,E:2}Destroy{} the",
					"{C:attention}leftmost{} discarded",
					"card every {C:red}Discard{}",
				}
			},
			sleeve_SEMBY_hopeless_sl = {
				name = "Hopeless Sleeve",
				text = {
					"{C:dark_edition}Unknown{} Winning Ante",
					"{s:0.2} {}",
					"Gain {C:attention}+#1#{} Joker Slot",
					"for every {C:attention}#2#{} Boss",
					"Blinds defeated",
				}
			},
			sleeve_SEMBY_hopeless_sl_alt = {
				name = "Hopeless Sleeve",
				text = {
					"{C:red}Increased{} Winning Ante",
					"{s:0.2} {}",
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
					"{s:0.2} {}",
					"Discard {C:red}#4#{} random cards",
					"after each hand played",
				}
			},
			sleeve_SEMBY_scartare_sl_alt = { --> "Skat"(ska:t)
				name = "Scartare Sleeve",
				text = {
					"{C:attention}+#1#{} Hand size",
					"{s:0.2} {}",
					"Discard {C:red}#2#{} additional",
					"cards after each",
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
					"Loading Stats: {V:1}#1#{V:2}#2#",
				}
			},
		},
		Blind = {
			bl_SEMBY_frog = {
				name = alt and "Tiny Guy" or "The Frog",
				text = {
					"{C:attention}-1{} hand size and",
					"{C:red}+1{} discard for",
					"each hand played",
				},
			},
    		bl_SEMBY_ghost = {
    		    name = alt and "Phanta" or "The Ghost",
    		    text = {
    		        "At start of the round,",
    		        "{C:red}increase{} Blind Size by {C:attention}25%{}", --C:SEMBY_percent
    		        "for each Joker you own",
    		    }
    		},
			bl_SEMBY_golden_egg = {
				name = alt and "The Egg" or "Golden Egg",
				text = {
					"Reward loses {C:money}$1{}",
					"each scoring card",
				}
			},
			bl_SEMBY_pencil = {
				name = alt and "Ink Scrawl" or "The Pencil",
				text = {
					"Debuff {C:attention}first{} played",
					"card every hand"
				}
			},
			bl_SEMBY_sharp_shooter = {
				name = alt and "Justice" or "Sharp Shooter",
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
                    "{C:green}+#1#{} Discard limit",
				}
			},
			v_SEMBY_urn_cursed = { -- Urn 2
				name = "Cursed Urn",
                text = {
                    "{C:green}+#1#{} Discard limit",
					"but {C:red}lose {C:attention}#2#{} Discard",
					"each round",
				},
                unlock = {
					"Discard a total",
					"of {C:attention}#1#{} cards",
					"{C:inactive}(#2#)",
                }
			},
		},
        Planet = {
            c_SEMBY_microcosm = {
                name = "Microcosm",
                text = {{
            		"Level {E:2}down{}",
            		"a selected",
            		"{C:attention}Poker Hand{}",
				}, {
            		"Enhances all",
            		"cards for the",
            		"{C:attention}Poker Hand{} to",
            		"{C:attention}Vintage Cards{}",
                }}
            },
            c_SEMBY_microcosm_highlighted = {
                name = "Microcosm",
                text = {{
                    "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level {E:2}down{}",
                    "{C:attention}#2#{}",
                    "{C:mult}-#3#{} Mult and",
                    "{C:chips}-#4#{} chips",
				}, {
            		"Enhances all {S:0.8,C:inactive}(#5#){}",
            		"cards for the",
            		"{C:attention}Poker Hand{} to",
            		"{C:attention}Vintage Cards{}",
                }}
            },
        },
		Spectral = {
			c_SEMBY_daybreak = {
				name = "Daybreak",
				text = {
    		        "Enhances each card",
    		        "in hand into a",
    		        "{C:attention}#1#{}",
				}
			},
			c_SEMBY_eden_spawner = {
				name = "", -- No Name
				text = {{
					"You currently own",
					"{C:attention}#1# {C:SEMBY_eden,E:1}Eden Tokens{}",
				}, {
					"{C:attention}Use{} this {C:SEMBY_eden,E:1}Eden Token{}",
					"to create a random",
					"{C:attention}Joker{} of {E:1}any{} rarity",
					"{C:inactive}(Must have room){}",
				},{
					"{C:red,E:2}Self destructs{} when",
					"{C:attention}Boss Blind{} is defeated",
				}}
			},
			c_SEMBY_eden_spawner_alt_1 = {
				name = "", -- No Name
				text = {
					"{C:SEMBY_eden,E:1}Eden Tokens{}",
					"are {C:red,E:2}Disabled{}",
					"in {C:attention}Mod-Config{}"
				}
			},
			c_SEMBY_eden_spawner_alt_2 = {
				name = "", -- No Name
				text = {
					"{C:SEMBY_eden,E:1}Eden Tokens{}",
					"are {C:red,E:2}Disabled{}",
					"in {C:attention}Challenges{}"
				}
			},
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
		Tarot = {
			c_SEMBY_backup = {
				name = "The Backup",
				text = {
        		    "Enhances {C:attention}#1#{}",
        		    "selected cards to",
        		    "{C:attention}Memory Cards{}",
				}
			},
			c_SEMBY_ocean = {
				name = "The Ocean",
				text = {
					"Add {C:dark_edition}Pearlescent",
					"or {C:dark_edition}Shiny{} to a",
					"random {C:attention}Joker",
					"or {C:attention}Playing Card",
					"in your hand"
				}
			},
		},
		Tag = {
			tag_SEMBY_adt_duplitage = {
				name = "Duplitage", --or "Dupli-Tag", like "Duplication Tag"
				text = {
        		    "Creates a copy",
					"of the next",
        		    "obtained {C:attention}Joker{}",
        		    "{C:inactive,s:0.9}(Must have room){}",
				}
			},
			tag_SEMBY_adt_intimidating = {
				name = "Intimidating Tag",
				text = {
					"{C:SEMBY_percent}-#1#% {C:attention}Blind Size",
					"next round",
				}
			},
			tag_SEMBY_bnt_discards = {
				name = "Recycling Tag",
				text = {
    		        "Gain {C:red}+1{} discard",
    		        "each round",
    		        "{C:inactive}({C:attention}#1#{C:inactive} uses left){}",
				}
			},
			tag_SEMBY_bnt_hands = {
				name = "Tag at Hand",
				text = {
    		        "Gain {C:blue}+1{} hand",
    		        "each round",
    		        "{C:inactive}({C:attention}#1#{C:inactive} uses left){}",
				}
			},
			tag_SEMBY_bnt_reroll = {
				name = "Spin Tag",
				text = {
    		        "{C:attention}First{} shop reroll",
    		        "costs {C:money}$#1#{} less",
    		        "{C:inactive}({C:attention}#2#{C:inactive} uses left){}",
				}
			},
			tag_SEMBY_bnt_shop = {
				name = "Kiosk Tag", --or "Shop Tag"
				text = {
    		        "{C:attention}+#1#{} card slot",
    		        "available in",
    		        "next shop",
				}
			},
			tag_SEMBY_bnt_vouch_down = {
				name = "Vouch-down Tag",
				text = {
					"Reduce the cost of a random",
					"{C:attention}Voucher{} by {C:money}$#1#{} next shop",
				}
			},
			tag_SEMBY_edt_pearlescent = {
				name = "Pearlescent Tag",
				text = {
					"Next base edition shop",
					"Joker is free and",
					"becomes {C:dark_edition}Pearlescent",
				}
			},
			tag_SEMBY_edt_shiny = {
				name = "Shiny Tag",
				text = {
					"Next base edition shop",
					"{C:attention}Consumable{} is free and",
					"becomes {C:dark_edition}Shiny",
				}
			},
			tag_SEMBY_ngt_doom = {
				name = "Doom",--Debt",
				text = {
					"{C:SEMBY_percent}+#1#% {C:attention}Blind Size{} for",
					"next {C:attention,E:1}Showdown Blind",
				}
			},
			tag_SEMBY_ngt_lavish = {
				name = "Lavish Debt",
				text = {
					"{C:SEMBY_percent}+#1#% {C:attention}Blind Size",
					"next round",
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
			e_SEMBY_resonance = {
				name = "Resonance",
				text = {
					"Can't be {C:SEMBY_debuff}Debuffed",
					"{s:0.2} {}",
					"{C:red}Increase {C:attention}Blind",
					"{C:attention}Size{} by {C:SEMBY_percent}#1#%",
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
		},
        Enhanced = {
			m_SEMBY_memory = {
				name = "Memory Card",
				text = {{
    		        "{V:1}#1#{} Memory:",
					"{C:chips}+#3#{} chips",
				}, {
					"{V:1}#2#{} Memories",
					"gain {C:chips}+#4#{} Chips,",
					"has no rank",
				}}
			},
			m_SEMBY_memory_desc = {
				name = "Memory Card",
				text = {
					"{C:inactive,s:0.8}[Suit]{} Memories",
					"gain {C:chips}+#1#{} Chips,",
					"has no rank",
				}
			},
			m_SEMBY_vintage = {
				name = "Vintage Card",
				text = {
        		    "Retrigger if played",
        		    "{C:attention}poker hand{} is {C:attention}not{} your",
        		    "{C:attention}highest-level{} hand"
				}
			},
		},
		Other = {
			-- Inspirations:
			inspired_buffoonery = {
				-- https://github.com/pinkmaggit-hub/Buffoonery
				name = "Inspired by",
				text = {
					"{C:legendary,s:1.1}Buffoonery",
					"{C:inactive,s:0.8}By Pink Maggit",
					"{C:inactive,s:0.8}and BurAndBY",
				}
			},
			inspired_phanta = {
				-- https://github.com/GhostSalt/Phanta
				name = "Inspired by",
				text = {
					"{C:legendary,s:1.1}Phanta",
					"{C:inactive,s:0.8}By GhostSalt",
				}
			},
			inspired_tetrapak = {
				-- https://github.com/tetraminus/Tetrapak
				name = "Inspired by",
				text = {
					"{C:legendary,s:1.1}Tetrapak",
					"{C:inactive,s:0.8}By tetraminus",
				}
			},
			inspired_vio_undertale = {
				-- https://bsky.app/profile/viomarks.bsky.social
				name = "Inspired by",
				text = {
					"{C:legendary,s:1.1}Vio's {s:1.1}Undertale Mod",
					"{C:inactive,s:0.8}Dog Residue {C:inactive,s:0.8,E:2,u:inactive}not{C:inactive,s:0.8} included!",
				}
			},
			-- SEMBY:
			SEMBY_bound = {
				name = "Bound",
				text = {
					"{C:attention}+#1#{} Joker slot",
					"{s:0.2} {}",
					"{C:green}#2# in #3#{} chance to",
					"{C:red}Debuff and Destroy{}",
					"this card at the",
					"end of the round",
				}
			},
			SEMBY_event_horizon = {
				name = "Event Horizon",
				text = {
					"Destroyed when",
					"it's {C:attention}Singularity",
					"is removed",
				}
			},
			SEMBY_degrading = {
				name = "Degrading",
				text = {
					"Destroyed",
					"after {C:attention}#1#{} rounds",
					"{C:inactive}({C:attention}#2#{C:inactive} remaining)",
				}
			},
			SEMBY_degrading_playing_card = {
				name = "Degrading", --{ "Degrading", "{s:0.7}Playing card" },
				text = {
					"{C:attention}Destroyed{} if this",
					"card is held in hand",
					"at end of round",
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
			SEMBY_shimmer_immune = {
				name = "Shimmer Immune",
				text = {
					"Can't be transformed",
					"by most other Jokers",
					"and Consumables",
				}
			},
			SEMBY_tmtrainer_sticker = {
				name = "TMTRAINER'd",
				text = {
					"Average {C:enhanced}Stats",
					"changed by {C:SEMBY_TMTRAINER}#1#",
				}
			},
			-- Infos
			SEMBY_eden_info = {
				name = "Eden Tokens",
				text = {
					"{C:dark_edition}Wins{} and {C:dark_edition}Blessings{}",
					"have granted you a",
					"{C:SEMBY_eden,E:1}Brighter Future{}",
				}
			},
			SEMBY_keep_info = {
				name = "Keep Info:",
				text = {
					"{C:inactive,s:0.9}(Keeps {C:dark_edition,s:0.9}Negative{C:inactive,s:0.9} on copy)",
				}
			},
			SEMBY_skip_info = {
				name = "Skip Info:",
				text = {
					"If {C:attention}Winning Ante",
					"is skipped, beat",
					"{C:attention}any{} higher Ante",
					"to {C:dark_edition}Win{} instead!",
				}
			},
			-- Misplaced Jokers:
			SEMBY_parking_disc_1 = {
				name = "Parking Disc: 1",
				text = {
					"{C:attention}+#1#{} Handsize",
				}
			},
			SEMBY_parking_disc_2 = {
				name = "Parking Disc: 2",
				text = {
					"{X:mult,C:white}X#1#{} Mult",
				}
			},
			SEMBY_parking_disc_3 = {
				name = "Parking Disc: 3",
				text = {
					"Copies ability of {C:attention}Joker",
					"to the left {C:attention}#1#{} times",
				}
			},
			SEMBY_parking_disc_4 = {
				name = "Parking Disc: 4",
				text = {
					"{C:red}+#1#{} Discard{C:inactive}(s)",
				}
			},
			SEMBY_parking_disc_5 = {
				name = "Parking Disc: 5",
				text = {
					"Scoring cards",
					"give {C:mult}+#1#{} Mult",
				}
			},
			SEMBY_parking_disc_6 = {
				name = "Parking Disc: 6",
				text = {
					"Create {C:attention}#1#{} Consumable{C:inactive}(s)",
					"each hand played",
					"{C:inactive}(Must have room)",
				}
			},
			SEMBY_parking_disc_7 = {
				name = "Parking Disc: 7",
				text = {
					"{X:chips,C:white}X#1#{} Chips",
				}
			},
			SEMBY_parking_disc_8 = {
				name = "Parking Disc: 8",
				text = {
					"Earn {C:money}$#1#{} each",
					"each hand played",
				}
			},
			SEMBY_parking_disc_9 = {
				name = "Parking Disc: 9",
				text = {
					"{C:green}Reduce {C:attention}Blind Size{} by {C:SEMBY_percent}#1#%",
					"each hand played",
				}
			},
			SEMBY_parking_disc_10 = {
				name = "Parking Disc: 10",
				text = {
					"{C:chips}+#1#{} Chips",
				}
			},
			SEMBY_parking_disc_11 = {
				name = "Parking Disc: 11",
				text = {
					"Retrigger all scoring",
					"cards {C:attention}#1#{} time{C:inactive}(s)",
				}
			},
			SEMBY_parking_disc_12 = {
				name = "Parking Disc: 12",
				text = {
					"{C:attention}Unknown {C:green}Effect",
					"with {C:dark_edition,E:1}Bonus Effect",
				}
			},
			SEMBY_parking_disc_XX = {
				name = "Parking Disc: ?",
				text = {
					"Next state",
					"{C:dark_edition,E:1}Unknown",
				}
			},
			-- Misplaced Editions:
			SEMBY_shiny_playing_card = {
				name = "Shiny", --{ "Shiny", "{s:0.7}Playing card" },
				text = {
					"Grant {C:money}$#1#{} of",
					"{C:attention}sell value{} to a",
					"random {C:attention}Joker",
				}
			},
		},
	},
	misc = {
		labels = {
			SEMBY_bound = "Bound",
			SEMBY_event_horizon = "Event Horizon",
			SEMBY_degrading = "Degrading",
			SEMBY_lavish_buff = "Lavish",
			SEMBY_pearlescent = "Pearlescent",
			SEMBY_possessive = "Possessive",
			SEMBY_resonance = "Resonance",
			SEMBY_shimmer_immune = "Shimmer Immune",
			SEMBY_shiny = "Shiny",
			SEMBY_tmtrainer_sticker = "TMTRAINER'd",
		},
		dictionary = {
			SEMBY_acquired_ex = "Acquired!",
			SEMBY_announce_doom = "Oblivion.",
			SEMBY_bark_1 = "Bark!",
			SEMBY_bark_2 = "Bark?",
			SEMBY_bark_3 = "Woof!",
			SEMBY_bark_4 = "Bork!",
			SEMBY_bark_5 = "Meow!",
			SEMBY_bigg = "Huge",
			SEMBY_blocked_ex = "Blocked!",
			SEMBY_bonus_hand = "Bonus Hand",
			SEMBY_bound_ex = "Bound!",
			SEMBY_broken_ex = "Broken!",
			SEMBY_burn_1 = "Burned",
			SEMBY_burn_2 = "Cinders",
			SEMBY_burn_3 = "Kindled",
			SEMBY_burn_4 = "Ignited",
			SEMBY_burn_5 = "Scorched",
			SEMBY_burn_6 = "Roasted",
			SEMBY_burn_7 = "Singed",
			SEMBY_burn_8 = "Charred",
			SEMBY_burn_9 = "Seared",
			SEMBY_captured = "Captured!",
			SEMBY_card_mined_ex = "Card Mined!",
			SEMBY_collapsed_ex = "Collapsed!",
			SEMBY_desc_destroyed = "(Destroyed after use)",
			SEMBY_desc_ignore_eternal = "(Can change Eternal Cards)",
			SEMBY_desc_maintained = "(Maintained after use)",
			SEMBY_destroyed_ex = "Destroyed!",
			SEMBY_dog_overflow = "Too many dogs!",
			SEMBY_downgrade_ex = "Downgrade!",
			SEMBY_durability_destroy = "Used up!",
			SEMBY_echoed_ex = "Echoed!",
			SEMBY_embraced_1 = "Warm",
			SEMBY_embraced_2 = "Comfy",
			SEMBY_embraced_3 = "Safe",
			SEMBY_embraced_4 = "Loved",
			SEMBY_emergency_meeting = "EMERGENCY MEETING",
			SEMBY_empty_memory = "Empty",
			SEMBY_enhancement = "Enhancement",
			SEMBY_escaped = "Escaped...",
			SEMBY_eternal_cleared = "Eternal Cleared",
			SEMBY_eval_cockroach = "Skitters",
			SEMBY_explode_1 = "BOOM!",
			SEMBY_explode_2 = "BAM!",
			SEMBY_explode_3 = "KAPOW!",
			SEMBY_failed_ex = "Failed!",
			SEMBY_ghostract_1 = "Cursed",
			SEMBY_ghostract_2 = "Blessed",
			SEMBY_ghostract_3 = "Done Deal",
			SEMBY_goobert_1 = "I tried...",
			SEMBY_goobert_2 = "P-proud?",
			SEMBY_goobert_3 = "T-thoughts?",
			SEMBY_goobert_4 = "I-is good?",
			SEMBY_goobert_X = "Arrrghh!",
			SEMBY_hit_ex = "Hit!",
			SEMBY_horse_says_1 = "Neigh!",
			SEMBY_horse_says_2 = "Neigh!", --> "Free Space" for Translators
			SEMBY_horse_says_3 = "Sigh..",
			SEMBY_hype_start = "Let's Go!",
			SEMBY_immune_ex = "Immune!",
			SEMBY_infinite = "Infinite",
			SEMBY_joker_slot_plus = "+1 Joker Slot",
			SEMBY_lavish_debt = "You owe me..",
			SEMBY_level_up_ex = "Level Up!",
			SEMBY_loop_back = { "Loop back", "Antes" }, -- "Loop back [X] Antes"
			SEMBY_loop_blind = { "Permanent", "Blind Sizes" }, -- "Permanent", "+[X]% Blind Sizes"
			SEMBY_loop_dont = { "Don't", "Loop back" }, --> Each entry is a new line
			SEMBY_lose_01_berry = "Out of Berries",
			SEMBY_lose_07_hunted = "Target Eliminated.",
			SEMBY_lose_12_gaokao = "Test Failed",
			SEMBY_lose_14_uses = "OUT OF FUEL",
			SEMBY_lose_xx_DELETE = "ERROR",
			SEMBY_lost_ex = "Lost!",
			SEMBY_miss_ex = "Miss!",
			SEMBY_money_clean = "All Clean",
			SEMBY_money_dirty = "NOT CLEAN!!",
			SEMBY_NaN = "NaN", --> Not a Number
			SEMBY_nothing = "Nothing",
			SEMBY_overshot_ex = "Overshot!",
			SEMBY_parking_disc_free = "Free Parking!",
			SEMBY_parking_disc_boss_2 = "Additional Hands",
			SEMBY_parking_disc_boss_3 = "Reduce Blind Size",
			SEMBY_parking_disc_boss_4 = "Disable Boss Blind",
			SEMBY_perfect_ex = "Perfect!",
			SEMBY_pitch_shift = "Pitch Shift!",
			SEMBY_printed_ex = "Printed!",
			SEMBY_QQQ = "???",
			SEMBY_quest_abandoned = "Quest Abandoned!",
			SEMBY_quest_accepted = "Quest Accepted!",
			SEMBY_quest_active_beat = "Currently Active",
			SEMBY_quest_active_beat_reset = "Active next Blind",
			SEMBY_quest_active_shot = "Active in Blinds",
			SEMBY_quest_active_use = "Always Active",
			SEMBY_quest_completed = "Complete!",
			SEMBY_restocked_ex = "Restocked!",
			SEMBY_ritual_complete = "Complete!",
			SEMBY_ritual_inactive = "Inactive...",
			SEMBY_seal = "Seal",
			SEMBY_shop_next = "Next shop",
			SEMBY_shop_this = "This shop!",
			SEMBY_shuffled_ex = "Shuffled!",
			SEMBY_smoll = "Tiny",
			--SEMBY_sort_asc = "highest to lowest",
			--SEMBY_sort_desc = "lowest to highest",
			SEMBY_sorted_ex = "Sorted!",
			SEMBY_T3MPRR_1 = "FEELN GREAT",
			SEMBY_T3MPRR_2 = "DW C UR FACE",
			SEMBY_T3MPRR_3 = "MISS UR TASTE",
			SEMBY_T3MPRR_4 = "3 PACKS A DAY",
			SEMBY_target = "Target",
			SEMBY_this_edition = "(This Edition)",
			SEMBY_tides_high = "High Tides",
			SEMBY_tides_low = "Low Tides",
			SEMBY_TMTRAINER_N1 = "Unchanged...",
			SEMBY_TMTRAINER_N2 = "Unchanged?",
			SEMBY_TMTRAINER_N3 = "ncha..Ugedn.",
			SEMBY_TMTRAINER_Y1 = "Changed!",
			SEMBY_TMTRAINER_Y2 = "Changed?",
			SEMBY_TMTRAINER_Y3 = "han!Cedg",
			SEMBY_value_down = "Value Down!",
			-- Joker Display:
			SEMBY_axed = "Axed",
			SEMBY_cards = "Cards",
			SEMBY_non_face = "Non-face",
			SEMBY_suits = "Suits",
			SEMBY_tokens = "Tokens",
			-- Config/System: Eden
			SEMBY_eden_active = 'Enable "Eden Tokens"',
			SEMBY_eden_active_desc = { "Start Runs with a Consumable that", "uses Tokens to spawn a Joker", },
			SEMBY_eden_amount = "Current Tokens", -- ex.: "Current Tokens (P1):"
			SEMBY_eden_infinite = "Infinite Tokens",
			SEMBY_eden_empty = "No Tokens!",
			SEMBY_eden_token = "Eden Token",
			-- Config: Generic
			SEMBY_enter_number = "Enter Number",
			-- Credits: NSFW-Link Warning
			SEMBY_artist_warn_title = "Content Warning",
			SEMBY_artist_warn_nsfw_1 = "The Website you are about to",
			SEMBY_artist_warn_nsfw_2 = "visit contains NSFW/18+ content!",
			SEMBY_artist_warn_nsfw_3 = "Please proceed with caution.",
			SEMBY_artist_warn_proceed = "Proceed",
			-- Special Keys:
			SEMBY_ART = "Art by ", -- ex.: "Art by Flowire"
		},
		v_dictionary = {
			SEMBY_consumeables = "+#1# Consumables",
			SEMBY_discards = "+#1# Discards",
			SEMBY_durability_refilled = "#1# Refilled!",
			SEMBY_durability_repaired = "#1# Repaired!",
			SEMBY_durability_uses_eval = "#1#",
			SEMBY_left = "#1# Left",
			SEMBY_loop = "Loop #1#",
			SEMBY_minus = "-#1#",
			SEMBY_money = "$#1#",
			SEMBY_money_minus = "-$#1#",
			SEMBY_money_plus = "+$#1#",
			SEMBY_out_of = "#1#/#2#",
			SEMBY_parking_disc_boss_1 = "X#1# Effectiveness",
			SEMBY_percentage = "+#1#%",
			SEMBY_percentage_minus = "-#1#%",
			SEMBY_plus = "+#1#",
			SEMBY_points = "+#1# Points",
			SEMBY_shop_in = "In #1# shops",
			SEMBY_spectrals = "+#1# Spectrals",
			SEMBY_up_blind_size = "+#1#% Size",
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
			c_SEMBY_uses_left = "100 uses left",
			c_SEMBY_parking_roulette = "Parking Roulette",
			c_SEMBY_qwest = "Qwest?",
			c_SEMBY_emperor_calus = "Emperor Calus",
			c_SEMBY_last_one_left = "Last One Left",
			c_SEMBY_speed_of_light = "Speed of Light",
			c_SEMBY_grandmaster_menagerie = "Grandmaster Menagerie",
			-- Page 3:
			c_SEMBY_DELETE_THIS = "DELETE THIS",
			c_SEMBY_exodia = "Exodia", --> Debug/Unused
		},
		v_text = {
			-- Misc.
			ch_c_SEMBY_space = { "{s:0.5} ", },
			-- Page 1 (Lore):
			ch_c_SEMBY_berry_good_meal = { "A tasty {C:blue}Tutorial{} for the {C:attention}Berry Jokers{}!" },
			ch_c_SEMBY_berry_eaten_1 = { "{C:red,E:2}Lose{} when beating a {C:attention}Blind" },
			ch_c_SEMBY_berry_eaten_2 = { "without a {C:attention}Berry Joker" },
			ch_c_SEMBY_tool_for_every_joke = { "A handy {C:blue}Tutorial{} for the {C:attention}Tool Jokers{}!" },
			ch_c_SEMBY_perishable_fate = { "Age and {C:purple,E:2}Wither{}, don't turn bitter." },
			ch_c_SEMBY_countdown = { "{C:inactive}24:00... 23:59... 23:58... 23:57... 23:56..." },
			ch_c_SEMBY_shiny_hunt = { "Enjoy increased {C:money}Shiny{} spawns!" },
			ch_c_SEMBY_hunter = { "Welcome to {C:enhanced}Balatro{}, {C:attention}47{}." },
			ch_c_SEMBY_hunter_1 = { "{C:dark_edition,E:1}Win{} by beating a {C:attention}Blind" },
			ch_c_SEMBY_hunter_2 = { "with {C:attention}10 or less{} Cards" },
			ch_c_SEMBY_hunter_3 = { "in your full Deck!" },
			ch_c_SEMBY_hunted = { "{C:red}Target Acquired." },
			ch_c_SEMBY_hunted_1 = { "{C:red,E:2}Lose{} when beating a {C:attention}Blind" },
			ch_c_SEMBY_hunted_2 = { "with {C:attention}45 or less{} Cards" },
			ch_c_SEMBY_hunted_3 = { "in your full Deck!" },
			ch_c_SEMBY_hunted_deal_1 = { "Discarding {C:attention}3{} cards {C:green}increases" },
			ch_c_SEMBY_hunted_deal_2 = { "hand size by {C:attention}2{} for the round." },
			ch_c_SEMBY_done_deal = { "{C:attention}King{} of {C:dark_edition,E:1}Everything{}, {C:attention}King{} of {E:2}Nothing{}." },
			ch_c_SEMBY_the_last_unicorn = { "The Last Hunt." },
			ch_c_SEMBY_the_last_unicorn_1 = { "{C:dark_edition,E:1}Win{} by beating a Blind" },
			ch_c_SEMBY_the_last_unicorn_2 = { "without the {C:attention}Unicorn{}." },
			ch_c_SEMBY_the_menagerie = { "Pleasure and delight awaits {C:attention}You{}." },
			-- Page 2 (Lore):
			ch_c_SEMBY_printty_good_1 = { "A productive {C:blue}Tutorial{}" },
			ch_c_SEMBY_printty_good_2 = { "for the {C:attention}Copy Printer{}!" },
			ch_c_SEMBY_printty_good_3 = { "{C:dark_edition,E:1}Win{} by beating a {C:attention}Blind{} with" },
			ch_c_SEMBY_printty_good_4 = { "{C:attention}9{} copies of the same {C:attention}Joker{}!" },
			ch_c_SEMBY_gaokao = { "An annual {C:blue}Tutorial{} for {C:attention}Jokebra{}!" },
			ch_c_SEMBY_lavish_dreams_1 = { '"Prove Your {E:1}Worth{}."' },
			ch_c_SEMBY_lavish_dreams_2 = { '            - {C:money}Lavish Joker' },
			ch_c_SEMBY_uses_left_1 = { "{C:attention}JOKER{} IS ETERNAL." },
			ch_c_SEMBY_uses_left_2 = { "{C:money}MONEY{} IS FUEL." },
			ch_c_SEMBY_uses_left_3 = { "{C:enhanced}BALATRO{} IS FULL." },
			ch_c_SEMBY_used_up = { "{C:red,E:2}Lose{} when money is {C:money}$0 {C:attention}or less{}." },
			ch_c_SEMBY_parking_roulette = { "{C:attention,E:2}Three {C:red,E:2}Cherries{} = {C:blue,E:2}Free Parking" },
			ch_c_SEMBY_parking_random = { "{C:attention}Parking Discs{} are {C:green,E:2}randomized" },
			ch_c_SEMBY_qwest_sprout = { "{s:2.0,E:1}Qwest!" },
			ch_c_SEMBY_qwest_tougher = { "{C:attention}Quests{} are tougher" },
			ch_c_SEMBY_emperor_calus = { "{E:2}Grow Fat From {C:attention,E:2}Strength{E:2}!" },
			ch_c_SEMBY_last_one_left_1 = { "{C:attention}I{} know where {C:attention}I'm{} supposed to be," },
			ch_c_SEMBY_last_one_left_2 = { "crushed my {C:red}Enemies{} long ago," },
			ch_c_SEMBY_last_one_left_3 = { "the last one left to go is {C:attention}Me{}." },
			ch_c_SEMBY_speed_of_light = { "Reach the {C:attention}edge{} of the {C:dark_edition,E:1}Universe{}!" },
			ch_c_SEMBY_grandmaster_menagerie = { "Sorrow and despair awaits {C:red}Us{}." },
			-- Page 3 (Lore):
			ch_c_SEMBY_DELETE_THIS_1 = { "::{C:SEMBY_TMTRAINER}UNKNOWN{} RULESET {X:blue,C:white}0x16b64e926" },
			ch_c_SEMBY_DELETE_THIS_2 = { "::{C:SEMBY_TMTRAINER}UNKNOWN{} RULESET {X:red,C:white}0x16b68f512" },
			ch_c_SEMBY_DELETE_THIS_3 = { "::{C:SEMBY_TMTRAINER}UNKNOWN{} RULESET {X:green,C:white}1x32b12c092" },
			ch_c_SEMBY_DELETE_THIS_4 = { "::{C:SEMBY_TMTRAINER}UNKNOWN{} RULESET {X:money,C:white}0x16b80c740" },
			ch_c_SEMBY_DELETE_THIS_5 = { "::{C:SEMBY_TMTRAINER}UNKNOWN{} RULESET {X:purple,C:white}1x32b04a335" },
			-- Modifiers:
			ch_c_SEMBY_countdown_mode = { "Don't regain {C:blue}Hands{} or {C:red}Discards" },
			ch_c_SEMBY_degrading = { "All Cards are {E:2,C:SEMBY_degrading}Degraging" },
			ch_c_SEMBY_doomed_cards = { "Gain {C:SEMBY_percent}2% {C:SEMBY_percent,E:2}Doom{} per card played" },
			ch_c_SEMBY_doomed_start = { "Start with {C:SEMBY_percent}100% {C:SEMBY_percent,E:2}Doom" },
			ch_c_SEMBY_extra_bonus = { "Extra {C:blue}Hands{} earn {C:green}more{} money" },
			ch_c_SEMBY_gold_stake = { "Apply {C:money}Gold Stake{} difficulty" },
			ch_c_SEMBY_no_showdown = { "No {C:attention}Showdown{} Blinds" },
			ch_c_SEMBY_no_win_ante = { "No {C:dark_edition,E:1}Winning{} Ante" },
			ch_c_SEMBY_pay_to_play = { "Pay {C:money}$1{} per card played" },
			ch_c_SEMBY_upgrade_pokerhands = { "Start with {C:green}better {E:2}Poker Hands" },
			-- Scaling Modifiers:
			ch_c_SEMBY_impossible_blinds = { "{C:red,E:1}Impossible{} Score-Requirements" },
			ch_c_SEMBY_menagerie_mode = { "{C:legendary,E:1}Multiplies{} Blind size by current Ante" },
			ch_c_SEMBY_scaling_05 = { "{C:green}X0.5{} base Blind size" },
			ch_c_SEMBY_scaling_15 = { "{C:red}X1.5{} base Blind size" },
			ch_c_SEMBY_scaling_20 = { "{C:red}X2.0{} base Blind size" },
			ch_c_SEMBY_scaling_40 = { "{C:red,E:2}X4.0{} base Blind size" },
			-- Lovely Patched:
			ch_m_winning_ante = { "Winning Ante: {C:attention}#1#", },
		},
		achievement_names = {
			ach_SEMBY_001 = "SCP-001",
			ach_SEMBY_all_challenge = "Flowire Loves You!",
			ach_SEMBY_hatched = "Coming Out",
		},
		achievement_descriptions = {
			ach_SEMBY_001 = { "Use Daybreak to remove", "all playing card ranks" },
			ach_SEMBY_all_challenge = { "Complete all", "Shimmerberry Challenges" },
			ach_SEMBY_hatched = { "Earn $0 from the", "Golden Egg Blind" },
		},
	},
}
