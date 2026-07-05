WIKIs

{| class="sortable wikitable" style="image-rendering:pixelated"
!Joker<br>Art & Name
!Effect & Infos
!Cost
!Rarity
!Type
!Artist &<br>Reference
!Alternative<br>Textures <!-- aka. "A.T." -->


|-
| {{captimg||Blueberry|imgsize=142px}}
|
Each scored {{ct|orange|[King]}} or {{ct|orange|[Queen]}}<br>gives {{ct|chips|+30}} Chips

{{ct|grey|[Ranks] change every round}}

Gets {{ct|red|Destroyed}} when displayed<br>[Ranks] didn't score this round
----
Part of the '''Food''' and '''Berry''' set.
| {{Ct|money|$4}}
| {{rarity|common}}
| {{jtype|+c}}
| '''unkokat'''
| - <!--A.T.-->


{{ct|orange|[King]}}

--##TODO## Laterrr:
{
-- Replace Number that have a range "1-5" with "[1-5]"
	j_SEMBY_ parking_disc = {
		name = "Parking Disc",
		text = {
			"{C:green}Effect{} changes each round,",
			"{C:dark_edition}Bonus Effect{} in {C:attention}Boss Blinds",
		}
	},
	j_SEMBY_ quest = {
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
}

-- Search Key(s):
-- #.*?#
-- \{.*?\}


return {
	descriptions = {
		Joker = {
			j_SEMBY_ abandoned_soul = {
				name = "Abandoned Soul",
				text = {
					"Gains {X:chips,C:white}X0.2{} Chips",
					"when a {C:attention}face{} card",
					"is destroyed",
					"{C:inactive}(Currently {X:chips,C:white}X1{C:inactive} Chips)",
				}
			},
			j_SEMBY_ adblocker = {
				name = "Adblocker",
				text = {{
					"When {C:attention}Blind{} is selected,",
					"{C:SEMBY_debuff}Debuff{} a random suit",
					"in your deck",
					"{C:inactive}(Debuffed: Nothing{C:inactive})",
				}, {
					"Played debuffed cards",
					"give {C:money}$2{} before scoring",
				}}
			},
			j_SEMBY_ afterimage = {
				name = "Afterimage",
				text = {
					"Copies ability of",
					"{C:attention}Joker{} to the left",
					"{C:dark_edition,E:1}3{} times",
				}
			},
			j_SEMBY_ agent_fourty_seven = {
				name = "Agent 47",
				text = {
					"When discarding",
					"exactly {C:attention}3{} cards,",
					"{C:red,E:2}eliminate{} {C:attention}one",
					"at random",
				}
			},
			j_SEMBY_ alpha = {
				name = "Alpha",
				text = {
					"{C:blue}+1{} Hand for",
					"{C:attention}first{} scoring",
					"{C:enhanced}Stone Card",
				}
			},
			j_SEMBY_ anchor = {
				name = "Anchor",
				text = {{
					"{X:chips,C:white}X2{} Chips",
				}, {
					"{C:red}Can't{} be",
					"{C:attention}Highlighted",
				}}
			},
			j_SEMBY_ annoying_dog = {
				name = alt and "Toby Fox" or "Annoying Dog",
				text = {
					"{s:0.2} {}",
					"{X:mult,C:white}X3.0{} Mult", -- Specifically WITH trailing 0
					"{s:0.2} {}",
					"{C:red}No{} consumable slots",
				}
			},
			j_SEMBY_ anodized_steel = {
				name = "Anodized Steel",
				text = {
					"Played {C:enhanced}Steel{} cards",
					"{C:green}reduce{} the {C:attention}Blind Size",
					"by {C:SEMBY_percent}5%{} when scored",
				}
			},
			j_SEMBY_ arcoex = {
				name = { "A.C.E.", "{C:inactive,s:0.6}Arbitrary Code Execution", },
				text = {
					"Add the next {C:attention}1 to 5{}",
					"playing cards from",
					"Deck to scoring hand",
				}
			},
			j_SEMBY_ balloon = {
				name = "Balloon",
				text = {{
					"{X:mult,C:white}X2{} Mult",
				}, {
					"{C:red,E:2}Self destructs{}",
					"when highlighting",
					"{C:attention}4 or more{} cards",
				}}
			},
			j_SEMBY_ barmy_joker = {
				name = "Barmy Joker",
				text = {
					"{C:mult}+12{} Mult if poker",
					"hand contains",
					"{C:attention}3{} different suits",
				}
			},
			j_SEMBY_ benthic_bloom = {
				name = "Benthic Bloom",
				text = {
					"Retrigger all",
					"{C:enhanced}Enhanced Cards",
					"{s:0.2} {}",
					"{C:enhanced}Enhanced Cards{} have",
					"a {C:green}1 in 4{} chance to",
					"shatter like {C:attention}Glass",
					"{s:0.2} {}",
					"{C:SEMBY_possessive,E:2}Possessive",
					"{s:0.2} {}",
				}
			},
			j_SEMBY_ berry_blue = {
				name = "Blueberry",
				text = {{
					"Each scored",
					"{C:attention}[King]{} or {C:attention}[Queen]",
					"gives {C:chips}+30{} Chips",
					"{s:0.1} ",
					"{C:inactive}Ranks change",
					"{C:inactive}every round",
				}, {
					"{s:0.9}Gets {C:red,s:0.9,E:2}Eaten{s:0.9} when",
					"{s:0.9}no {C:attention,s:0.9}[King]{s:0.9} or {C:attention,s:0.9}[Queen]",
					"{s:0.9}scored this round",
				}}
			},
			j_SEMBY_ berry_golden = {
				name = "Goldenberry",
				text = {{
					"Each scored",
					"{C:attention}[King]{} or {C:attention}[Queen]",
					"earns {C:money}$1{}-{C:money}$2",
					"{s:0.1} ",
					"{C:inactive}Ranks change",
					"{C:inactive}every round",
				}, {
					"{s:0.9}Gets {C:red,s:0.9,E:2}Eaten{s:0.9} when",
					"{s:0.9}no {C:attention,s:0.9}[King]{s:0.9} or {C:attention,s:0.9}[Queen]",
					"{s:0.9}scored this round",
				}}
			},
			j_SEMBY_ berry_shimmer = {
				name = "Shimmerberry",
				text = {{
					"Each scored",
					"{C:attention}[King]{} or {C:attention}[Queen]",
					"{C:green}reduces {C:attention}Blind",
					"{C:attention}Size{} by {C:SEMBY_percent}5%",
					"{s:0.1} ",
					"{C:inactive}Ranks change",
					"{C:inactive}every round",
				}, {
					"{s:0.9}Gets {C:red,s:0.9,E:2}Eaten{s:0.9} when",
					"{s:0.9}no {C:attention,s:0.9}[King]{s:0.9} or {C:attention,s:0.9}[Queen]",
					"{s:0.9}scored this round",
				}}
			},
			j_SEMBY_ berry_straw = {
				name = "Strawberry",
				text = {{
					"Each scored",
					"{C:attention}[King]{} or {C:attention}[Queen]",
					"gives {C:mult}+8{} Mult",
					"{s:0.1} ",
					"{C:inactive}Ranks change",
					"{C:inactive}every round",
				}, {
					"{s:0.9}Gets {C:red,s:0.9,E:2}Eaten{s:0.9} when",
					"{s:0.9}no {C:attention,s:0.9}[King]{s:0.9} or {C:attention,s:0.9}[Queen]",
					"{s:0.9}scored this round",
				}}
			},
			j_SEMBY_ boosterpack_joker = {
				name = "Booster Pack",
				text = {{
					"{C:attention}3{} additional",
					"{C:attention}Booster Packs",
					"in each {C:money}Shop",
				}, {
					"{C:green}3{C:inactive}/3{} uses left",
				}}
			},
			j_SEMBY_ bound = {
				name = "Bound Joker",
				text = {
					"When obtaining or",
					"destroying this card,",
					"apply {C:SEMBY_debuff}Bound{} to",
					"{C:attention}3{} random Jokers",
				}
			},
			j_SEMBY_ broken_record = {
				name = "Broken Record",
				text = {
					"Randomly add {C:attention}2{} to {C:attention}3{}",
					"retriggers to any",
					"scoring cards",
				}
			},
			j_SEMBY_ buccaneer = {
				name = "Buccaneer",
				text = {
					"Adds {C:attention}thrice{} the sell",
					"value of all other",
					"owned {C:attention}Jokers{} to {C:chips}Chips",
					"{C:inactive}(Currently {C:chips}+0{C:inactive} Chips)",
				}
			},
			j_SEMBY_ bunburrow = {
				name = "Bunburrow",
				text = {
					"Gain {C:money}$12{} every",
					"{C:attention}4 {C:green}Rerolls{}",
					"{C:inactive}(4 remaining){}",
				}
			},
			j_SEMBY_ butterfly = {
				name = "Butterfly",
				text = {{
					"{C:chips}0{} Chips", -- No "+/-"!
				}, {
					"{C:green}Gains {C:chips}+8{} Chips",
					"if played hand",
					"contains a {C:attention}Pair{},",
					"{C:red}Loses {C:chips}4{} Chips",
					"if it doesn't",
				}}
			},
			j_SEMBY_ cassette_beast = {
				name = "Cassette Beast",
				text = {
					"Retrigger scoring cards",
					"for {C:attention}each{} scoring suit"
				}
			},
			j_SEMBY_ ceaseless_void = {
				name = "Ceaseless Void",
				text = {{
					"When a Card is {C:attention}sold{}, gain",
					"{C:SEMBY_percent}+3%{} Blind Size, {X:mult,C:white}X0.02{} Mult",
					"or {X:chips,C:white}X0.02{} Chips for each",
					"{C:money}$1{} of sell value",
				}, {
					"When {C:attention}Blind{} is selected",
					"{C:red}increase{} Blind Size by {C:SEMBY_percent}0%",
					"{X:chips,C:white}X1{} Chips, {X:mult,C:white}X1{} Mult",
				}}
			},
			j_SEMBY_ chrono_break = {
				name = "Chrono Break",
				text = {{
					"{C:legendary,E:1}Revive{} shattered",
					"{C:attention}playing cards",
				}, {
					"{C:attention}Shatter{} all",
					"scoring cards",
					"each hand",
				}}
			},
			j_SEMBY_ cockroach = {
				name = "Cockroach",
				text = {
					"{C:attention}+1{} Ante when",
					"{C:attention}Boss Blind",
					"is defeated",
					"{s:0.2} {}",
					"{C:SEMBY_possessive,E:2}Possessive",
					"{s:0.2} {}",
				}
			},
			j_SEMBY_ common_denominator = {
				name = {
					"{u:white}  Common  ",
					"Denominator",
				},
				text = {{
					"Copies abilities of",
					"{C:attention}all {X:common,C:white}Common{} Jokers",
				}, {
					"{C:common}Commons{}: 0",
					"{C:green}Compatible{}: 0",
					"{C:red}Incompatible{}: 0",
				}}
			},
			j_SEMBY_ copy_printer = {
				name = "Copy Printer",
				text = {
					"At the end of the {C:attention}Shop",
					"convert the {C:attention}Joker{} to the {C:attention}left",
					"into the {C:attention}Joker{} to the {C:attention}right",
					"{C:inactive}(Destroyed/Maintained after use)"
				}
			},
			j_SEMBY_ coupon = {
				name = "Coupon",
				text = {
					"Shops are",
					"{C:money}20%{} cheaper",
				}
			},
			j_SEMBY_ coupon_booklet = {
				name = "Coupon Booklet",
				text = {
					"Shops are {C:money}50%{} cheaper",
					"{s:0.2} {}",
					"Raise prices by {C:red}10%",
					"on every {C:green}Reroll",
				}
			},
			j_SEMBY_ daffy_joker = {
				name = "Daffy Joker",
				text = {
					"{C:mult}+8{} Mult if poker",
					"hand contains",
					"{C:attention}2{} different suits",
				}
			},
			j_SEMBY_ DATAMINER = {
				name = "DATAMINER",
				text = {
					"{C:SEMBY_TMTRAINER,E:1}Changes{} most",
					"{C:enhanced}Numbers{} on newly",
					"obtained {C:attention}Jokers{}",
					"by {C:red}X0.5{} or {C:green}X2{}",
				}
			},
			j_SEMBY_ digitizon = {
				name = "Digitizon",
				text = {{
					"When Blind is selected,",
					"take {C:money}$1{} of {C:attention}sell value{}",
					"from every {C:attention}Joker{} and",
					"{C:attention}Consumable{} card",
				}, {
					"Create a {C:attention}Memory{} card",
					"for every {C:money}$3{} taken",
					"{C:inactive}({C:money}$3{C:inactive} remaining){}",
				}}
			},
			j_SEMBY_ doomsday_device = {
				name = "Doomsday Device",
				text = {
					"{C:attention}Double{} the stored",
					"{C:chips}Memory Value{} every {C:attention}20{}",
					"scoring {C:enhanced}Memory Cards{}",
					"{C:inactive}(Currently {C:attention}0{C:inactive}/20){}",
				}
			},
			j_SEMBY_ echoing_joker = {
				name = "Echoing Joker",
				text = {
					"Create {C:green}2{} {C:dark_edition}Negative{}",
					"copies of the {C:attention}next{}",
					"used {C:attention}Consumable{}",
					"{s:0.8,C:inactive}(Probability affected)",
					"{C:red,E:2}self destructs{}"
				}
			},
			j_SEMBY_ eden_blessing = {
				name = "Eden's Blessing",
				text = {{
					"{X:SEMBY_eden,C:white}X1.5{} Chips or Mult,",
					"favours the small",
				}, {
					"Grants a",
					"{C:SEMBY_eden,E:1}Brighter Future{}",
					"when {C:attention}Boss Blind{}",
					"is defeated",
				}}
			},
			j_SEMBY_ emergency_button = {
				name = "Emergency Button",
				text = {
					"Prevents Death and",
					"{C:green}Rerolls{} all {C:attention}Jokers{}",
					"and {C:attention}Consumables{}",
				}
			},
			j_SEMBY_ eternal_fortune = {
				name = "Eternal Fortune",
				text = {
					"{C:blue}+1{} Hand, {C:green}+1{} Luck",
				}
			},
			j_SEMBY_ fifty_seven_leaf_clover = {
				name = "57 Leaf Clover",
				text = {
					"Retrigger all",
					"{C:enhanced}Wild Cards",
					"{C:dark_edition}3{} times",
				}
			},
			j_SEMBY_ fire_exint = {
				name = "Fire Exin't",
				text = {
					"Reduce Shop prices",
					"by {C:money}1%{} every played",
					"and {C:attention}unscored{} card,",
					"resets when {C:attention}Boss{}",
					"{C:attention}Blind{} is selected",
					"{C:inactive}(Currently {C:money}0%{C:inactive}/50%){}",
				}
			},
			j_SEMBY_ fortune_cookie = {
				name = "Fortune Cookie",
				text = {{
					"Gains a new random",
					"{C:dark_edition}Edition{} at the start",
					"of every {C:attention}Blind",
				}, {
					"Sell this card to",
					"apply {C:dark_edition}(This Edition){} to",
					"a random Joker",
				}}
			},
			j_SEMBY_ foxie_plush = {
				name = "Fox Plush",
				text = {
					"{C:chips}+12{} Chips for",
					"each {C:attention}Joker{} and",
					"{C:mult}+5{} Mult for each",
					"empty {C:attention}Joker{} slot",
					"{C:inactive}({C:chips}+0{}{C:inactive} Chips, {}{C:mult}+0{}{C:inactive} Mult)",
				}
			},
			j_SEMBY_ garden_gnome = {
				name = "Garden Gnome",
				text = {
					"{C:mult}+30{} Mult",
					"{C:attention}-2{} Hand size",
				}
			},
			j_SEMBY_ ghostsalt_contract = {
				name = alt and "Evil Deal" or "Gambler's Contract",
				text = {
					"Shop Jokers have",
					"a {C:green}1 in 13{} chance to",
					"become {C:dark_edition}Negative{} and",
					"a {C:green}2 in 13{} chance to",
					"become {C:SEMBY_possessive,E:2}Possessive{}",
					"{C:inactive,s:0.9}(Fixed probabilities){}",
				}
			},
			j_SEMBY_ gold_bomb = {
				name = "Gold Bomb",
				text = {
					"Destroy all",
					"played cards",
					"in {C:attention}final hand",
					"of round",
				}
			},
			j_SEMBY_ goobert = {
				name = "Goobert",
				text = {{
					"Creates {C:green,E:2}imperfect",
					"copies of {C:attention}playing cards",
					"added to your deck",
				}, {
					"{C:green}10{C:inactive}/10{} uses left",
				}}
			},
			j_SEMBY_ hemoturgy = {
				name = "Hemoturgy",
				text = {
					"Discarded cards gain",
					"a random {C:dark_edition}Edition{},",
					"{C:enhanced}Enhancement{} or {C:attention}Seal",
					"{s:0.2} {}",
					"{C:red}-2{} Discard Limit",
				}
			},
			j_SEMBY_ hypetrain = {
				name = alt and "HYPETRAIN" or "Hypetrain",
				text = {
					"Level {X:mult,C:white}X1{}!",
					"Next stop in:",
					"{s:0.2} {}",
					"{C:mult}+20{} Mult",
					"{s:0.2} {}",
				}
			},
			j_SEMBY_ hypetrain_info = {
				name = "Info Board",
				text = {
					"Your {C:attention}Joker{} arrives in:",
					"{s:0.2} {}",
					"{C:mult}+20{} Mult",
					"{s:0.2} {}",
				}
			},
			j_SEMBY_ improv = {
				name = "Improv Show",
				text = {{
					"Converts unused",
					"{C:blue}Hands{} into {C:green}Points{}",
					"at end of round",
				}, {
					"When playing your",
					"{C:attention}final hand{}, convert",
					"{C:attention}1 {C:green}Point{} into {C:attention}1 {C:blue}Hand{}",
				}, {
					"Stored: {C:attention}0 {C:green}Points{}",
					"{C:inactive}(Next point: 0%)",
				}}
			},
			j_SEMBY_ incinerator = {
				name = "Incinerator",
				text = {
					"{C:green}+1{} Discard Limit",
				}
			},
			j_SEMBY_ inventation = {
				name = "Inven-Tation", -- Invent + Invite
				text = {
					"{C:enhanced}Vintage Cards{} have a",
					"{C:green}1 in 8{} chance to upgrade",
					"the played poker hand",
				}
			},
			j_SEMBY_ jevil = {
				name = "JEV][L",
				text = {
					"Played {C:attention}Playing Cards{}",
					"evaluate {C:attention}twice{}",
				}
			},
			j_SEMBY_ jokebra = {
				name = "Jokebra",
				text = {
					"When {C:attention}Blind{} is selected,",
					"set an additional {C:enhanced}Target",
					"{C:inactive}(Between {C:blue}100{C:inactive} and {C:blue}1000{C:inactive})",
					"{s:0.2} {}",
					"Beat the {C:attention}Blind{} when",
					"the Round score",
					"{u:inactive}matches{} the {C:enhanced}Target",
				}
			},
			j_SEMBY_ jokebra_active = {
				name = "Jokebra",
				text = {
					"Beat the {C:attention}Blind{} by",
					"{u:inactive}matching{} the {C:enhanced}Target{}:",
					"{s:1.5,C:blue,E:2}[100-1000]",
				}
			},
			j_SEMBY_ jokebra_failed = {
				name = "Jokebra",
				text = {
					"Round score",
					"{C:red}missed{} the",
					"{C:enhanced}Target{}:",
					"{s:1.5,C:blue,E:2}[100-1000]",
				}
			},
			j_SEMBY_ lavish_joker = {
				name = alt and "Lavish Chad" or "Lavish Joker",
				text = {{
					"Regain lost {C:money}Money{}",
					"at start of {C:attention}shop{}",
					"{C:inactive}(Currently {C:money}$0{C:inactive}){}",
				}, {
					"Each {C:money}$1{} regained",
					"{C:red}increases{} the next",
					"{C:attention}Blind Size{} by {C:SEMBY_percent}5%",
					"{C:inactive}(Currently {C:SEMBY_percent}+0%{C:inactive})",
				}}
			},
			j_SEMBY_ lost_constellation = {
				name = "Lost Constellation",
				text = {
					"{C:green}1 in 3 {C:planet}Planet{} cards",
					"upgrade poker hand",
					"{C:attention}2{} additional times",
				}
			},
			j_SEMBY_ lottery_ticket = {
				name = "Lottery Ticket",
				text = {
					"Scoring {C:attention}non-face{} cards",
					"have a {C:green}1 in 4{} chance",
					"to give {C:mult}+2.5{} Mult or",
					"{C:chips}+12{} Chips otherwise",
				}
			},
			j_SEMBY_ melon = {
				name = "Melon",
				text = {{
					"When {C:attention}Blind{} is selected,",
					"{C:green}reduce {C:attention}Blind Size{} by {C:SEMBY_percent}50%",
				}, {
					"{C:attention}Destroyed{} when",
					"{C:attention}Boss Blind{} is defeated",
				}}
			},
			j_SEMBY_ mineshaft = {
				name = "Mineshaft",
				text = {{
					"Every {C:attention}3{} scoring",
					"cards, add a {C:enhanced}Stone{},",
					"{C:enhanced}Steel{} or {C:enhanced}Gold{} card",
					"to the deck",
					"{C:inactive}(Currently {C:attention}0{C:inactive}/3)",
				}, {
					"{C:green}50{C:inactive}/50{} uses left",
				}}
			},
			j_SEMBY_ misery = {
				name = "Misery",
				text = {
					"{X:mult,C:white}X0.5{} Mult",
					"{s:0.2} {}",
					"{X:chips,C:white}X4.0{} Chips for {C:attention}first",
					"{C:attention}hand{} of round",
				}
			},
			j_SEMBY_ money_laundering = {
				name = "Money Laundering",
				text = {{
					"When {C:attention}Blind{} is selected,",
					"gain {C:blue}+2{} Hands and",
					"{C:red}+2{} Discards",
				}, {
					"{C:red}Increase{} shop",
					"prices by {C:money,E:1}100%",
				}}
			},
			j_SEMBY_ nashi_pear = {
				name = "Nashi Pear",
				text = {
					"When Blind is selected,",
					"increase {C:attention}Round score{}",
					"by {C:SEMBY_percent}10.000{} and reduce",
					"this by {C:SEMBY_percent}2000{}",
				}
			},
			j_SEMBY_ oblivion = {
				name = "Oblivion",
				text = {{
					"When beating Ante {C:attention}1+",
					"{E:2}Loop{} back to Ante {C:attention}1",
				}, {
					"Every {E:2}Loop{} {C:red}increases",
					"all {C:attention}Blind Sizes{} by {C:SEMBY_percent}50%",
					"{C:inactive}(Currently {C:SEMBY_percent}+0%{C:inactive})",
				}, {
					"Every {E:2}Loop{} {C:green}increases",
					"{C:attention}Boss{} payouts by {C:money}$3",
					"{C:inactive}(Currently {C:money}$0{C:inactive})",
				}}
			},
			j_SEMBY_ obscure_ritual = {
				name = "Obscure Ritual",
				text = {
					"{C:green}Reduce {C:attention}Blind Size",
					"by {C:SEMBY_percent}66.6{} when drawing",
					"the {C:attention}last{} card",
				}
			},
			j_SEMBY_ opulent_skint = {
				name = "Opulent Skint",
				text = {{
					"Sell this card to",
					"{C:attention}replace{} a random",
					"card in the Shop",
					"with this {C:attention}Joker{}",
				}, {
					"{C:green}1 in 256{} chance",
					"to transform into",
					"a {C:legendary,E:1}Legendary{} Joker",
					"when {C:attention}Bought{}",
				}}
			},
			j_SEMBY_ ouroboros = {
				name = "Ouroboros",
				text = {
					"Each scored {C:attention}8{} gives",
					"{C:blue}+1{} Hand and {C:red}increases",
					"the {C:attention}Blind Size{} by {C:SEMBY_percent}8%",
				}
			},
			j_SEMBY_ paper_swan = {
				name = "Paper Swan",
				text = {
					"{X:chips,C:white}X2{} Chips every",
					"{C:attention}5{} scoring cards",
					"{C:inactive}(Currently {C:attention}0{C:inactive}/5)",
				}
			},
			j_SEMBY_ pay_two_win = {
				name = "P2W",
				text = {
					"Spend {C:money}$2{} to",
					"gain {C:mult}+30{} Mult",
				}
			},
			j_SEMBY_ peculiar_joker = {
				name = "Peculiar Joker",
				text = {
					"{C:chips}+100{} Chips if poker",
					"hand contains",
					"{C:attention}3{} different suits",
				}
			},
			j_SEMBY_ perfect_pitch = {
				name = "Perfect Pitch",
				text = {{
					"{X:mult,C:white}X2{} Mult when {C:attention}scoring",
					"exactly {C:attention}[1-5]{} card(s)",
					"{C:inactive,s:0.8}(Amount changes every hand)",
				}, {
					"Gain {X:mult,C:white}X1{} Mult",
					"after {C:attention}5{} successful",
					"hands in a row",
					"{C:inactive}(Currently {C:attention}0{C:inactive}/5)",
				}}
			},
			j_SEMBY_ pet_plastic = {
				name = "P.E.T.",
				text = {
					"This Joker gains",
					"{C:mult}+2{} Mult for every card",
					"discarded this round",
					"{C:inactive}(Currently {}{C:mult}+0{}{C:inactive} Mult)",
				}
			},
			j_SEMBY_ piggy_bank = {
				name = "Piggy Bank",
                text = {{
                    "When {C:attention}Blind{} is selected",
                    "or skipped, spend {C:money}$2{} to",
                    "add {C:money}$1{} of {C:attention}sell value",
                }, {
                    "Starts with {C:money}$2",
                    "extra {C:attention}sell value",
				}, {
					"{X:mult,C:white}X0.2{} Mult for every",
					"{C:money}$4{} of {C:attention}sell value",
					"{C:inactive}(Currently {}{X:mult,C:white}X1{}{C:inactive} Mult)",
				}}
			},
			j_SEMBY_ pinata = {
				name = alt and "Quick Brown Fox" or "Piñata",
				text = {{
					"{C:green}1 in 5{} chance to",
					"break open {C:attention}each",
					"{C:attention}hand{} played",
				}, {
					"Gain {C:attention}+1{} and fill",
					"all {C:attention}Consumable",
					"slots when Joker",
					"gets destroyed",
				}}
			},
			j_SEMBY_ plastic_key = {
				name = "Plastic Key",
				text = {
					"{C:attention}Destroy{} this card and",
					"create {C:attention}2 {C:spectral}Spectral{} cards",
					"when {C:attention}Boss Blind{} is defeated",
					"{C:inactive}(Must have room)",
				}
			},
			j_SEMBY_ pocket_dimension = {
				name = "Pocket Dimension",
				text = {
					"Cards in your",
					"{C:attention}Consumable{} area",
					"give {X:mult,C:white}X1.5{} Mult",
					"{s:0.2} {}",
					"{C:attention}+3{} Consumable slots",
					"{s:0.2} {}",
				}
			},
			j_SEMBY_ potted_flowers = {
				name = "Potted Flower",
				text = {
					"{X:chips,C:white}X4{} Chips if poker",
					"hand contains",
					"{C:attention}4{} different suits",
				}
			},
			j_SEMBY_ pygmymall = {
				name = "Pygmymall",
				text = {
					"{C:attention}+2{} card slots",
					"available in shop",
					"every {C:attention}3{} shops",
					"{C:inactive}In 3 shops", -- "Next Shop", "This Shop!"
				}
			},
			j_SEMBY_ reagent = {
				-- Philosopher's Stone:
				name = alt and "Reagent" or "Red Lion",
				text = {
					"{X:mult,C:white}X2.5{} Mult",
					"{s:0.2} {}",
					"Loses {X:mult,C:white}X0.1{} Mult",
					"for each {C:enhanced}Enhanced",
					"card in your deck",
				}
			},
			j_SEMBY_ red_mask = {
				name = "Red Mask",
				text = {
					"This Joker gains {C:chips}+10{} Chips",
					"when adding or removing",
					"a {C:attention}playing card",
					"{C:inactive}(Currently {}{C:chips}+0{}{C:inactive} Chips)",
				}
			},
			j_SEMBY_ replicator = {
				name = "Replicator", 
				text = {
					"{C:attention}Destroys{} the next {C:attention}20{}",
					"played cards to {C:attention}Duplicate{}",
					"the rightmost Joker",
					"{C:red,E:2}self destructs{}",
					"{C:inactive}(Currently {C:attention}0{C:inactive}/20){}",
				}
			},
			j_SEMBY_ ripped_joker = {
				name = "Ripped Joker",
				text = {
					"{C:chips}+200{} Chips if played",
					"hand contains",
					"{C:attention}3{} or fewer cards",
				}
			},
			j_SEMBY_ risky_joker = {
				name = "Risky Joker",
				text = {
					"Scoring cards {C:red}take",
					"{C:chips}6{} Chips and {C:mult}1{} Mult",
					"and increase the",
					"Blind Payout by {C:money}$1",
					"{C:inactive}(Next payout {C:money}+$0{C:inactive})",
				}
			},
			j_SEMBY_ scaffolding = {
				name = "Scaffolding",
				text = {
					"{C:attention}+0{} Hand size",
					"{s:0.2} {}",
					"When {C:attention}Blind{} is selected",
					"{C:green}gain {C:attention}1{} Hand size for",
					"every other {C:attention}Joker",
					"{s:0.2} {}",
					"{C:red}Lose {C:attention}3{} Hand size",
					"each {C:blue}Hand{} played",
				}
			},
			j_SEMBY_ scav_prototype = {
				name = "Scav. Prototype",
				text = {{
					"When {C:attention}Blind{} is selected,",
					"destroy {C:attention}adjacent{} Jokers",
				}, {
					"{C:green}1 in 4{} chance to gain",
					"a {C:attention}Duplitage{} for each",
					"destroyed Joker",
				}}
			},
			j_SEMBY_ seven_wonders = {
				name = "7 Wonders",
				text = {
					"When {C:attention}Blind{} is selected",
					"{C:green}reduce{} the {C:attention}Blind Size",
					"by {C:SEMBY_percent}2%{} for each {C:attention}7{} in",
					"your {C:attention}full deck",
					"{C:inactive}(Currently {C:SEMBY_percent}0%{C:inactive}/50%)",
				}
			},
			j_SEMBY_ shooting_star = {
				name = "Shooting Star",
				text = {
					"When {C:attention}Boss Blind{} is",
					"defeated, upgrade",
					"every {C:legendary,E:1}Poker Hand",
					"by {C:green}1{} level{C:inactive}(s)",
					"{s:0.8,C:inactive}(Probability affected)",
				}
			},
			j_SEMBY_ shrewd_joker = {
				name = "Shrewd Joker",
				text = {
					"{C:chips}+50{} Chips if poker",
					"hand contains",
					"{C:attention}2{} different suits",
				}
			},
			j_SEMBY_ silver_mask = {
				name = "Silver Mask",
				text = {
					"Earn {C:money}$20{} at the",
					"end of the round",
					"{s:0.2} {}",
					"Earn {C:money}$2 {C:attention}less{} for",
					"each Hand size",
				}
			},
			j_SEMBY_ singularity = {
				name = "Singularity",
				text = {{
					"Create a copy of {E:1}every",
					"{C:attention}scoring card{} without an",
					"{C:purple,E:2}Event Horizon{} sticker",
				}, {
					"When this {C:attention}Joker{} gets",
					"removed, {C:red}Destroy{} all",
					"cards it has created",
					"{C:inactive}(Can't be {C:SEMBY_debuff}Debuffed{C:inactive})",
				}, {
					"Occupies {C:attention}3{} Joker slots",
				}}
			},
			j_SEMBY_ stern_teacher = {
				name = "Stern Teacher",
				text = {{
					"When {C:attention}Blind{} is selected,",
					"{C:SEMBY_debuff}Debuff{} adjacent Jokers",
					"for the current round",
				}, {
					"{C:mult}+25{} Mult for each",
					"{C:SEMBY_debuff}Debuffed{} Joker",
					"{C:inactive}(Currently {C:mult}+0 {C:inactive}Mult)",
				}}
			},
			j_SEMBY_ stylish_joker = {
				name = "Stylish Joker",
				text = {{
					"Earn {C:money}$1{} for every",
					"{C:attention}Consumable{} you keep",
					"at the end of round",
				}, {
					"{C:attention}+2{} consumable slots",
					"and {C:red}-1{} hand size",
				}}
			},
			j_SEMBY_ stocked_shelves = {
				name = "Stocked Shelves",
				text = {{
					"{C:attention}Restocks{} bought",
					"Booster Packs, Cards",
					"and Vouchers in {C:money}Shop{}",
				}, {
					"{C:green}8{C:inactive}/8{} uses left",
				}}
			},
			j_SEMBY_ swordswallower = {
				name = "Sword Swallower",
				text = {
					"{X:mult,C:white}X1{} Mult for each",
					"{X:common,C:white}Common{} Joker",
					"{C:inactive}(Currently {}{X:mult,C:white}X1{}{C:inactive} Mult)",
				}
			},
			j_SEMBY_ t3mprr = {
				name = "PUSH UR T3MPRR",
				text = {{
					"{C:attention,E:2}BLIND {E:2}SELECTED,",
					"{C:red,E:2}CLOCK IT UP {C:SEMBY_percent,E:2}200%",
				}, {
					"{C:attention,E:2}CARD {E:2,u:inactive}PLAYED{E:2},",
					"{C:green,E:2}PUSH IT DOWN {C:SEMBY_percent,E:2}6%",
				}}
			},
			j_SEMBY_ tempered_glass = {
				name = "Tempered Glass",
                text = {
					"{C:green}50%{} chance to",
					"{C:legendary,E:1}Revive{} destroyed",
					"{C:enhanced}Glass Cards{}",
					"{C:inactive,s:0.9}(Fixed probability)",
				}
			},
			j_SEMBY_ the_dwarf = {
				name = "The Dwarf",
				text = {
					"When {C:attention}Blind{} is selected,",
					"set hand size to {C:attention}5{} and",
					"add the {C:attention}difference",
					"to the {C:red}Discards",
				}
			},
			j_SEMBY_ the_giant = {
				name = "The Giant",
				text = {
					"When {C:attention}Blind{} is selected,",
					"{C:attention}lose all discards{} and",
					"gain {C:attention}as much{} hand size",
				}
			},
			j_SEMBY_ TMTRAINER = {
				name = "TMTRAINER",
				text = {
					"{C:SEMBY_TMTRAINER,E:1}Randomizes{} most",
					"{C:enhanced}Numbers{} on newly",
					"obtained {C:attention}Jokers{}",
					"{s:0.2} {}",
					"Range: {C:red}-15%{}-{C:green}255%{}",
					"{s:0.2} {}",
					"{C:attention}+1{} Joker slot",
				}
			},
			j_SEMBY_ to_and_fro = {
				name = alt and "Fro n' To" or "To n' Fro",
				text = {
					"{s:0.2} {}",
					"Played cards swap",
					"{C:chips}Chips{} and {C:mult}Mult",
					"{u:inactive}before{} scoring",
					"{s:0.2} {}",
				}
			},
			j_SEMBY_ fro_and_to = {
				name = alt and "Fro n' To" or "To n' Fro",
				text = {
					"{s:0.2} {}",
					"Played cards swap",
					"{C:mult}Mult{} and {C:chips}Chips",
					"{u:inactive}before{} scoring",
					"{s:0.2} {}",
				}
			},
			j_SEMBY_ tool_axe = {
				name = "Axe",
				text = {{
					"Each {C:inactive}[Suit]{} card",
					"held in hand has",
					"a {C:green}20%{} chance to",
					"be {C:attention}destroyed",
					"{s:0.1} ",
					"{C:inactive}Suit changes",
					"{C:inactive}every round",
				}, {
					"{C:green}80{C:inactive}/100{} uses left",
				}}
			},
			j_SEMBY_ tool_hoe = {
				name = "Hoe",
				text = {{
					"Each {C:inactive}[Suit]{} card",
					"held in hand",
					"gives {C:chips}+25{} Chips",
					"{s:0.1} ",
					"{C:inactive}Suit changes",
					"{C:inactive}every round",
				}, {
					"{C:green}250{C:inactive}/250{} uses left",
				}}
			},
			j_SEMBY_ tool_pickaxe = {
				name = "Pickaxe",
				text = {{
					"Each {C:inactive}[Suit]{} card",
					"held in hand has",
					"a {C:green}40%{} chance",
					"to give {C:money}$2",
					"{s:0.1} ",
					"{C:inactive}Suit changes",
					"{C:inactive}every round",
				}, {
					"{C:green}200{C:inactive}/200{} uses left",
				}}
			},
			j_SEMBY_ tool_shovel = {
				name = "Shovel",
				text = {{
					"Each {C:inactive}[Suit]{} card",
					"held in hand",
					"gives {X:mult,C:white}X1.2{} Mult",
					"{s:0.1} ",
					"{C:inactive}Suit changes",
					"{C:inactive}every round",
				}, {
					"{C:green}200{C:inactive}/200{} uses left",
				}}
			},
			j_SEMBY_ toolkit = {
				name = "Toolkit",
				text = {{
					"All {C:attention}Jokers{} to the {C:attention}left{},",
					"that have a limited",
					"number of uses, are",
					"{C:green,E:2}repaired{} and regain",
					"up to {C:attention}5{} uses at the",
					"end of the round",
				}, {
					"{C:green}200{C:inactive}/200{} uses left",
					"{C:inactive,s:0.8}Can't be repaired",
				}}
			},
			j_SEMBY_ twenty_to_die_for = {
				name = "20 to Die for",
				text = {
					"Quadruples all {C:attention}listed",
					"{C:green,E:1,S:1.1}probabilities",
					"{C:inactive}(ex: {C:green}1 in 3{C:inactive} -> {C:green}4 in 3{C:inactive})",
				}
			},
			j_SEMBY_ unicorn = {
				name = "Unicorn",
				text = {
					"{C:chips}+20{} Chips for each unique",
					"{C:dark_edition}Edition{}, {C:enhanced}Enhancement{} or",
					"{C:attention}Seal{} in your full deck",
					"{C:inactive}(Currently {C:chips}+0{C:inactive} Chips)",
				}
			},
			j_SEMBY_ vip_ticket = {
				name = "V.I.P. Ticket",
				text = {
					"{C:enhanced}Bonus Cards{} always",
					"shuffle to the top",
					"of the {C:attention}Deck{}",
				}
			},
			j_SEMBY_ warm_embrace = {
				name = "Warm Embrace",
				text = {
					"{C:chips}Chips{} and {C:mult}Mult{} are",
					"rounded up to the",
					"{C:attention}next{} multiple of {C:attention}10",
				}
			},
			j_SEMBY_ watching_forest = {
				name = "Watching Forest",
				text = {{
					"Sort the Deck",
					"{C:attention,E:1}lowest to highest{}", -- highest to lowest
					"after drawing the",
					"first hand each round",
				}, {
					"Change sort order",
					"every {C:attention}3{} hands played",
					"{C:inactive}2 remaining", -- "Active!"
				}}
			-- Vanilla Rework:
			j_SEMBY_ flower_pot = {
				name = "Flower Pot",
				text = {
					"{X:mult,C:white}X4{} Mult if poker",
					"hand contains",
					"{C:attention}4{} different suits",
				}
			},
		},


		Back = {
			b_SEMBY_hopeless = {
				name = "Hopeless Deck",
				text = {
					"{C:dark_edition}Unknown{} Winning Ante", --6-14
					"{s:0.2} {}",
					"Gain {C:attention}+1{} Joker Slot",
					"for every {C:attention}4{} Boss",
					"Blinds defeated",
				}
			},
			b_SEMBY_scartare = { --> "Skat"(ska:t)
				name = "Scartare Deck",
				text = {
					"Remove all Ranks below {C:attention}7",
					"{C:attention}+2{} Hand size, {C:red}-3{} Discards",
					"{s:0.2} {}",
					"Discard {C:red}3{} random cards",
					"after each hand played",
				}
			},
			b_SEMBY_strange = {
				name = "Strange Deck",
				text = {
					"Generating Deck...",
					--Scoring playing cards change suit and rank
				}
			},
		},
		Sleeve = {
			sleeve_SEMBY_burning_sl = {
				name = "Burned Sleeve",
				text = {
					"{C:red}Destroy{} the",
					"{C:attention}first{} scoring card",
					"every {C:blue}Hand",
				}
			},
			sleeve_SEMBY_hopeless_sl = {
				name = "Hopeless Sleeve",
				text = {
					"{C:dark_edition}Unknown{} Winning Ante", --8-16
					"{s:0.2} {}",
					"Gain {C:attention}+1{} Joker Slot",
					"for every {C:attention}4{} Boss",
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
					"Blinds by {C:attention}1",
				}
			},
			sleeve_SEMBY_scartare_sl = { --> "Skat"(ska:t)
				name = "Scartare Sleeve",
				text = {
					"Remove all Ranks below {C:attention}7",
					"{C:attention}+2{} Hand size, {C:red}-3{} Discards",
					"{s:0.2} {}",
					"Discard {C:red}3{} random cards",
					"after each hand played",
				}
			},
			sleeve_SEMBY_scartare_sl_alt = { --> "Skat"(ska:t)
				name = "Scartare Sleeve",
				text = {
					"{C:attention}+2{} Hand size",
					"{s:0.2} {}",
					"Discard {C:red}2{} additional",
					"cards after each",
					"hand played",
				}
			},
			sleeve_SEMBY_strange_sl = {
				name = "Strange Sleeve",
				text = {
					"Generating Sleeve...",
					--Scoring playing cards change suit and rank
				}
			},
			sleeve_SEMBY_strange_sl_alt = {
				name = "Strange Sleeve",
				text = {
					"Loading Stats...",
					--Scoring playing cards gain or lose chips and mult
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
					"Blind Sizes by {C:SEMBY_percent}20%",
					"{C:red}-1{} hand size",
				}
			},
			v_SEMBY_mask_tragedy = { -- Mask 2
				name = "Tragedy Mask",
				text = {
					"{C:green}Reduce{} all",
					"Blind Sizes by {C:SEMBY_percent}20%",
					"{C:red}-1{} hand size",
				},
                unlock = {
                    "Discover",
					"{C:attention}10{} Blinds",
                }
			},
			v_SEMBY_urn_old = { -- Urn 1
				name = "Old Urn",
                text = {
                    "{C:green}+1{} Discard limit",
				}
			},
			v_SEMBY_urn_cursed = { -- Urn 2
				name = "Cursed Urn",
                text = {
                    "{C:green}+2{} Discard limit",
					"but {C:red}lose {C:attention}1{} Discard",
					"each round",
				},
                unlock = {
					"Discard a total",
					"of {C:attention}1250{} cards",
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
                    "{S:0.8}({S:0.8,C:inactive}lvl.1{S:0.8}){} Level {E:2}down{}",
                    "{C:attention}[Poker Hand]{}",
                    "{C:mult}-?{} Mult and",
                    "{C:chips}-?{} chips",
				}, {
            		"Enhances all {S:0.8,C:inactive}(selected){}",
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
    		        "{C:attention}[Random Enhancement]{}",
				}
			},
			c_SEMBY_eden_spawner = {
				name = "", -- No Name
				text = {{
					"You currently own",
					"{C:attention}0/Infinite {C:SEMBY_eden,E:1}Eden Tokens{}",
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
					"{B:1,C:white,E:1}[Rarity]{} Soul Captured",
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
        		    "Enhances {C:attention}2{}",
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
        		    "Gives a copy of the",
        		    "next obtained {C:attention}Joker{}",
        		    "{C:inactive}(Must have room){}",
				}
			},
			tag_SEMBY_adt_intimidating = {
				name = "Intimidating Tag",
				text = {
					"{C:SEMBY_percent}-20% {C:attention}Blind Size",
					"next round",
				}
			},
			tag_SEMBY_bnt_discards = {
				name = "Recycling Tag",
				text = {
    		        "Gain {C:red}+1{} discard",
    		        "each round",
    		        "{C:inactive}({C:attention}5{C:inactive}/5 uses left){}",
				}
			},
			tag_SEMBY_bnt_hands = {
				name = "Tag at Hand",
				text = {
    		        "Gain {C:blue}+1{} hand",
    		        "each round",
    		        "{C:inactive}({C:attention}5{C:inactive}/5 uses left){}",
				}
			},
			tag_SEMBY_bnt_reroll = {
				name = "Spin Tag",
				text = {
    		        "{C:attention}First{} shop reroll",
    		        "costs {C:money}$2{} less",
    		        "{C:inactive}({C:attention}5{C:inactive}/5 uses left){}",
				}
			},
			tag_SEMBY_bnt_shop = {
				name = "Kiosk Tag",
				text = {
    		        "{C:attention}+1{} card slot",
    		        "available in",
    		        "next shop",
				}
			},
			tag_SEMBY_bnt_vouch_down = {
				name = "Vouch-down Tag",
				text = {
					"Reduce the cost of a random",
					"{C:attention}Voucher{} by {C:money}$5{} next shop",
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
					"{C:SEMBY_percent}+0% {C:attention}Blind Size{} for",
					"next {C:attention,E:1}Showdown Blind",
				}
			},
			tag_SEMBY_ngt_lavish = {
				name = "Lavish Debt",
				text = {
					"{C:SEMBY_percent}+0% {C:attention}Blind Size",
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
					"by {C:SEMBY_percent}5%",
				}
			},
			e_SEMBY_resonance = {
				name = "Resonance",
				text = {
					"Can't be {C:SEMBY_debuff}Debuffed",
					"{s:0.2} {}",
					"{C:red}Increase {C:attention}Blind",
					"{C:attention}Size{} by {C:SEMBY_percent}5%",
				}
			},
			e_SEMBY_shiny = {
				name = "Shiny",
				text = {
					"Gains {C:money}$2{} of",
					"{C:attention}sell value{} at",
					"end of round",
				}
			},
		},
        Enhanced = {
			m_SEMBY_memory = {
				name = "Memory Card",
				text = {{
    		        "{C:inactive}[Suit]{} Memory:",
					"{C:chips}+0{} chips",
				}, {
					"{C:inactive}[Suit]{} Memories",
					"gain {C:chips}+2{} Chips,",
					"has no rank",
				}}
			},
			m_SEMBY_memory_desc = {
				name = "Memory Card",
				text = {
					"{C:inactive,s:0.8}[Suit]{} Memories",
					"gain {C:chips}+2{} Chips,",
					"has no rank",
				}
			},
			m_SEMBY_vintage = {
				name = "Vintage Card",
				text = {
        		    "Retrigger if played",
        		    "{C:attention}poker hand{} is not your",
        		    "{C:attention}highest-level{} hand"
				}
			},
		},
		Other = {
			SEMBY_bound = {
				name = "Bound",
				text = {
					"{C:attention}+1{} Joker slot",
					"{s:0.2} {}",
					"{C:green}1 in 10{} chance to",
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
					"after {C:attention}5{} rounds",
					"{C:inactive}({C:attention}5{C:inactive} remaining)",
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
					"changed by {C:SEMBY_TMTRAINER}x??",
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








| Name | Effect | Cost | Rarity | Properties |
| ---- |:------:|:----:| ------ | ---------- |
| Flower Pot | X4 Mult if poker<br>hand contains<br>4 different suits | $6 | Rare | Nature, Vanilla |
| Abandoned Soul | Gains X0.2 Chips<br>when a face card<br>is destroyed<br>(Currently X1 Chips) | $6 | Uncommon | -- |
| A.C.E. | Add the next 1 to 5<br>playing cards from<br>Deck to scoring hand | $7 | Rare | -- |
| Adblocker | When Blind is selected,<br>Debuff a random suit<br>in your deck<br>(Debuffed: [Suit])<br>Played debuffed cards<br>give $2 before scoring | $8 | Rare | -- |
| Afterimage | Copies ability of<br>Joker to the left<br>3 times | $20 | Legendary | -- |
| Agent 47 | When discarding<br>exactly 3 cards,<br>eliminate one<br>at random | $6 | Uncommon | -- |
| Alpha | +1 Hand for<br>first scoring<br>Stone Card | $6 | Common | Magic |
| Anchor | X2 Chips<br>Can't be<br>Highlighted | $4 | Common | Ocean |
| Annoying Dog | X3.0 Mult<br>No consumable slots | $7 | Rare | Animal |
| Anodized Steel | Played Steel cards<br>reduce the Blind Size<br>by 5% when scored | $8 | Uncommon | -- |
| Axe | Each [Suit] card<br>held in hand has<br>a 20% chance to<br>be destroyed<br>Suit changes<br>every round<br>80/100 uses left | $6 | Common | Durability |
| Balloon | X2 Mult<br>Self destructs<br>when highlighting<br>4 or more cards | $4 | Common | -- |
| Barmy Joker | +12 Mult if poker<br>hand contains<br>3 different suits | $5 | Common | -- |
| Benthic Bloom | Retrigger all<br>Enhanced Cards<br>Enhanced Cards have<br>a 1 in 4 chance to<br>shatter like Glass<br>Possessive | $6 | Uncommon | Nature |
| Blueberry | Each scored<br>[King] or [Queen]<br>gives +30 Chips<br>Ranks change<br>every round<br>Gets Eaten when<br>no [King] or [Queen]<br>scored this round | $4 | Common | Berry, Food |
| Booster Pack | 3 additional<br>Booster Packs<br>in each Shop<br>3/3 uses left | $5 | Common | Durability |
| Bound Joker | When obtaining or<br>destroying this card,<br>apply Bound to<br>3 random Jokers | $6 | Uncommon | -- |
| Broken Record | Randomly add 2 to 3<br>retriggers to any<br>scoring cards | $4 | Common | Music |
| Buccaneer | Adds thrice the sell<br>value of all other<br>owned Jokers to Chips<br>(Currently +0 Chips) | $4 | Common | -- |
| Bunburrow | Gain $12 every<br>4 Rerolls<br>(4 remaining) | $4 | Common | Animal |
| Butterfly | 0 Chips<br>Gains +8 Chips<br>if played hand<br>contains a Pair,<br>Loses 4 Chips<br>if it doesn't | $6 | Common | Animal |
| Cassette Beast | Retrigger scoring cards<br>for each scoring suit | $8 | Rare | Animal, Music |
| Ceaseless Void | When a Card is sold, gain<br>+3% Blind Size, X0.02 Mult<br>or X0.02 Chips for each<br>$1 of sell value<br>When Blind is selected<br>increase Blind Size by 0%<br>X1 Chips, X1 Mult | $8 | Rare | Animal, Space |
| Chrono Break | Revive shattered<br>playing cards<br>Shatter all<br>scoring cards<br>each hand | $7 | Rare | Magic, Music |
| Cockroach | +1 Ante when<br>Boss Blind<br>is defeated<br>Possessive | $6 | Uncommon | Animal |
| Common Denominator | Copies abilities of<br>all Common Jokers<br>Commons: 0<br>Compatible: 0<br>Incompatible: 0 | $10 | Rare | -- |
| Copy Printer | At the end of the Shop<br>convert the Joker to the left<br>into the Joker to the right<br>(Conditional self destruct) | $12 | Rare | -- |
| Coupon | Shops are<br>20% cheaper | $6 | Common | -- |
| Coupon Booklet | Shops are 50% cheaper<br>Raise prices by 10%<br>on every Reroll | $6 | Uncommon | -- |
| Daffy Joker | +8 Mult if poker<br>hand contains<br>2 different suits | $5 | Common | -- |
| DATAMINER | Changes most<br>Numbers on newly<br>obtained Jokers<br>by X0.5 or X2 | $7 | Uncommon | -- |
| Digitizon | When Blind is selected,<br>take $1 of sell value<br>from every Joker and<br>Consumable card<br>Create a Memory card<br>for every $3 taken<br>($3 remaining) | $6 | Uncommon | Animal |
| Doomsday Device | Double the stored<br>Memory Value every 20<br>scoring Memory Cards<br>(Currently 0/20) | $6 | Uncommon | -- |
| Echoing Joker | Create 2 Negative<br>copies of the next<br>used Consumable<br>(Probability affected)<br>self destructs | $8 | Rare | -- |
| Eden's Blessing | X1.5 Chips or Mult,<br>favours the small<br>Grants a<br>Brighter Future<br>when Boss Blind<br>is defeated | $4 | Uncommon | Nature |
| Emergency Button | Prevents Death and<br>Rerolls all Jokers<br>and Consumables | $6 | Uncommon | -- |
| Eternal Fortune | +1 Hand, +1 Luck | $4 | Common | Nature |
| 57 Leaf Clover | Retrigger all<br>Wild Cards<br>3 times | $8 | Uncommon | Nature |
| Fire Exin't | Reduce Shop prices<br>by 1% every played<br>and unscored card,<br>resets when Boss<br>Blind is selected<br>(Currently 0%/50%) | $6 | Uncommon | -- |
| Fortune Cookie | Gains a new random<br>Edition at the start<br>of every Blind<br>Sell this card to<br>apply (This Edition) to<br>a random Joker | $6 | Common | Food |
| Fox Plush | +12 Chips for<br>each Joker and<br>+5 Mult for each<br>empty Joker slot<br>(+0 Chips, +0 Mult) | $6 | Common | Animal |
| Gambler's Contract | Shop Jokers have<br>a 1 in 13 chance to<br>become Negative and<br>a 2 in 13 chance to<br>become Possessive<br>(Fixed probabilities) | $7 | Rare | -- |
| Garden Gnome | +30 Mult<br>-2 Hand size | $5 | Common | -- |
| Gold Bomb | Destroy all<br>played cards<br>in final hand<br>of round | $5 | Uncommon | -- |
| Goldenberry | Each scored<br>[King] or [Queen]<br>earns $1-$2<br>Ranks change<br>every round<br>Gets Eaten when<br>no [King] or [Queen]<br>scored this round | $5 | Uncommon | Berry, Food |
| Goobert | Creates imperfect<br>copies of playing cards<br>added to your deck<br>10/10 uses left | $8 | Uncommon | Durability |
| Hemoturgy | Discarded cards gain<br>a random Edition,<br>Enhancement or Seal<br>-2 Discard Limit | $7 | Rare | Magic |
| Hoe | Each [Suit] card<br>held in hand<br>gives +25 Chips<br>Suit changes<br>every round<br>250/250 uses left | $5 | Common | Durability |
| Hypetrain<br>(Info Board) | Level X1!<br>Next stop in:<br>+20 Mult | $7 | Uncommon | -- |
| Improv Show | Converts unused<br>Hands into Points<br>at end of round<br>When playing your<br>final hand, convert<br>1 Point into 1 Hand<br>Stored: 0 Points<br>(Next point: 0%) | $8 | Rare | -- |
| Incinerator | +1 Discard Limit | $5 | Common | -- |
| Inven-Tation | Vintage Cards have a<br>1 in 8 chance to upgrade<br>the played poker hand | $5 | Uncommon | -- |
| JEV][L | Played Playing Cards<br>evaluate twice | $20 | Legendary | -- |
| Jokebra | When Blind is selected,<br>set an additional Target<br>(Between 100 and 1000)<br>Beat the Blind when<br>the Round score<br>matches the Target | $8 | Uncommon | -- |
| Lavish Joker | Regain lost Money<br>at start of shop<br>(Currently $0)<br>Each $1 regained<br>increases the next<br>Blind Size by 5%<br>(Currently +0%) | $0 | Rare | -- |
| Lost Constellation | 1 in 3 Planet cards<br>upgrade poker hand<br>2 additional times | $6 | Uncommon | Space |
| Lottery Ticket | Scoring non-face cards<br>have a 1 in 4 chance<br>to give +2.5 Mult or<br>+12 Chips otherwise | $5 | Common | -- |
| Melon | When Blind is selected,<br>reduce Blind Size by 50%<br>Destroyed when<br>Boss Blind is defeated | $6 | Uncommon | Food |
| Mineshaft | Every 3 scoring<br>cards, add a Stone,<br>Steel or Gold card<br>to the deck<br>(Currently 0/3)<br>50/50 uses left | $6 | Common | Durability |
| Misery | X0.5 Mult<br>X4.0 Chips for first<br>hand of round | $5 | Common | -- |
| Money Laundering | When Blind is selected,<br>gain +2 Hands and<br>+2 Discards<br>Increase shop<br>prices by 100% | $9 | Uncommon | -- |
| Nashi Pear | When Blind is selected,<br>increase Round score<br>by 10.000 and reduce<br>this by 2000 | $3 | Common | Food |
| Oblivion | When beating Ante 1+<br>Loop back to Ante 1<br>Every Loop increases<br>all Blind Sizes by 50%<br>(Currently +0%)<br>Every Loop increases<br>Boss payouts by $3<br>(Currently $0) | $20 | Legendary | -- |
| Obscure Ritual | Reduce Blind Size<br>by 66.6 when drawing<br>the last card | $5 | Uncommon | Magic |
| Opulent Skint | Sell this card to<br>replace a random<br>card in the Shop<br>with this Joker<br>1 in 256 chance<br>to transform into<br>a Legendary Joker<br>when Bought | $10 | Uncommon | Animal |
| Ouroboros | Each scored 8 gives<br>+1 Hand and increases<br>the Blind Size by 8% | $8 | Rare | Animal |
| Paper Swan | X2 Chips every<br>5 scoring cards<br>(Currently 0/5) | $5 | Common | Animal |
| Parking Disc | Effect changes each round,<br>Bonus Effect in Boss Blinds | $6 | Uncommon | Multistage* |
| Peculiar Joker | +100 Chips if poker<br>hand contains<br>3 different suits | $5 | Common | -- |
| Perfect Pitch | X2 Mult when scoring<br>exactly [1-5] card(s)<br>(Changes every hand)<br>Gain X1 Mult<br>after 5 successful<br>hands in a row<br>(Currently 0/5) | $6 | Uncommon | Music |
| P.E.T. | This Joker gains<br>+2 Mult for every card<br>discarded this round<br>(Currently +0 Mult) | $5 | Common | -- |
| Pickaxe | Each [Suit] card<br>held in hand has<br>a 40% chance<br>to give $2<br>Suit changes<br>every round<br>200/200 uses left | $5 | Common | Durability |
| Piggy Bank | When Blind is selected<br>or skipped, spend $2 to<br>add $1 of sell value<br>Starts with $2<br>extra sell value<br>X0.2 Mult for every<br>$4 of sell value<br>(Currently X1 Mult) | $5 | Common | Animal |
| Piñata | 1 in 5 chance to<br>break open each<br>hand played<br>Gain +1 and fill<br>all Consumable<br>slots when Joker<br>gets destroyed | $6 | Common | Animal, Food |
| Plastic Key | Destroy this card and<br>create 2 Spectral cards<br>when Boss Blind is defeated<br>(Must have room) | $6 | Uncommon | -- |
| Pocket Dimension | Cards in your<br>Consumable area<br>give X1.5 Mult<br>+3 Consumable slots | $8 | Rare | Magic, Space |
| Potted Flower | X4 Chips if poker<br>hand contains<br>4 different suits | $6 | Uncommon | Nature |
| P2W | Spend $2 to<br>gain +30 Mult | $4 | Common | -- |
| PUSH UR T3MPRR | BLIND SELECTED,<br>CLOCK IT UP 200%<br>CARD PLAYED,<br>PUSH IT DOWN 6% | $5 | Uncommon | Animal, Music |
| Pygmymall | +2 card slots<br>available in shop<br>every 3 shops<br>In 3 shops | $6 | Uncommon | -- |
| Quest? | Start a Quest!<br>Complete it to<br>Win the Game and<br>obtain a random<br>Legendary Joker | $7 | Uncommon | Multistage* |
| Red Lion | X2.5 Mult<br>Loses X0.1 Mult<br>for each Enhanced<br>card in your deck | $6 | Uncommon | -- |
| Red Mask | This Joker gains +10 Chips<br>when adding or removing<br>a playing card<br>(Currently +0 Chips) | $6 | Uncommon | -- |
| Replicator  | Destroys the next 20<br>played cards to Duplicate<br>the rightmost Joker<br>self destructs<br>(Currently 0/20) | $6 | Rare | -- |
| Ripped Joker | +200 Chips if played<br>hand contains<br>3 or fewer cards | $5 | Common | -- |
| Risky Joker | Scoring cards take<br>6 Chips and 2 Mult<br>and increase the<br>Blind Payout by $1<br>(Next payout +$0) | $6 | Common | -- |
| Scaffolding | +0 Hand size<br>When Blind is selected<br>gain 1 Hand size for<br>every other Joker<br>Lose 3 Hand size<br>each Hand played | $5 | Uncommon | -- |
| Scav. Prototype | When Blind is selected,<br>destroy adjacent Jokers<br>1 in 4 chance to gain<br>a Duplitage for each<br>destroyed Joker | $5 | Uncommon | Animal |
| 7 Wonders | When Blind is selected<br>reduce the Blind Size<br>by 2% for each 7 in<br>your full deck<br>(Currently 0%/50%) | $7 | Uncommon | -- |
| Shimmerberry | Each scored<br>[King] or [Queen]<br>reduces Blind<br>Size by 5%<br>Ranks change<br>every round<br>Gets Eaten when<br>no [King] or [Queen]<br>scored this round | $6 | Rare | Berry, Food |
| Shooting Star | When Boss Blind is<br>defeated, upgrade<br>every Poker Hand<br>by 1 level(s)<br>(Probability affected) | $7 | Uncommon | Space |
| Shovel | Each [Suit] card<br>held in hand<br>gives X1.2 Mult<br>Suit changes<br>every round<br>200/200 uses left | $6 | Common | Durability |
| Shrewd Joker | +50 Chips if poker<br>hand contains<br>2 different suits | $5 | Common | -- |
| Silver Mask | Earn $20 at the<br>end of the round<br>Earn $2 less for<br>each Hand size | $6 | Common | -- |
| Singularity | Create a copy of every<br>scoring card without an<br>Event Horizon sticker<br>When this Joker gets<br>removed, Destroy all<br>cards it has created<br>(Can't be Debuffed)<br>Occupies 3 Joker slots | $10 | Rare | Space |
| Stern Teacher | When Blind is selected,<br>Debuff adjacent Jokers<br>for the current round<br>+25 Mult for each<br>Debuffed Joker<br>(Currently +0 Mult) | $5 | Uncommon | -- |
| Stocked Shelves | Restocks bought<br>Booster Packs, Cards<br>and Vouchers in Shop<br>8/8 uses left | $4 | Common | Durability |
| Strawberry | Each scored<br>[King] or [Queen]<br>gives +8 Mult<br>Ranks change<br>every round<br>Gets Eaten when<br>no [King] or [Queen]<br>scored this round | $5 | Uncommon | Berry, Food |
| Stylish Joker | Earn $1 for every<br>Consumable you keep<br>at the end of round<br>+2 consumable slots<br>and -1 hand size | $5 | Uncommon | -- |
| Sword Swallower | X1 Mult for each<br>Common Joker<br>(Currently X1 Mult) | $8 | Rare | -- |
| Tempered Glass | 50% chance to<br>Revive destroyed<br>Glass Cards<br>(Fixed probability) | $4 | Common | -- |
| The Dwarf | When Blind is selected,<br>set hand size to 5 and<br>add the difference<br>to the Discards | $6 | Uncommon | Animal |
| The Giant | When Blind is selected,<br>lose all discards and<br>gain as much hand size | $6 | Uncommon | Animal |
| TMTRAINER | Randomizes most<br>Numbers on newly<br>obtained Jokers<br>Range: -15%-255%<br>+1 Joker slot | $9 | Rare | -- |
| To n' Fro | Played cards swap<br>Chips and Mult<br>before scoring | $5 | Common | -- |
| Toolkit | All Jokers to the left,<br>that have a limited<br>number of uses, are<br>repaired and regain<br>up to 5 uses at the<br>end of the round<br>200/200 uses left<br>Can't be repaired | $4 | Common | Durability |
| 20 to Die for | Quadruples all listed<br>probabilities<br>(ex: 1 in 3 -> 4 in 3) | $6 | Rare | Magic |
| Unicorn | +20 Chips for each unique<br>Edition, Enhancement or<br>Seal in your full deck<br>(Currently +0 Chips) | $6 | Common | Animal, Magic |
| V.I.P. Ticket | Bonus Cards always<br>shuffle to the top<br>of the Deck | $5 | Common | -- |
| Warm Embrace | Chips and Mult are<br>rounded up to the<br>next multiple of 10 | $5 | Common | Animal |
| Watching Forest | Sort the Deck<br>lowest to highest<br>after drawing the<br>first hand each round<br>Change sort order<br>every 3 hands played<br>2 remaining | $6 | Rare | Nature |

### Parking Disc
#### Main States
| State | Effect |
|:-----:|:------:|
| 0, ? | Effect changes each round,<br>Bonus Effect in Boss Blinds |
| 1 | +1 Handsize |
| 2 | X2 Mult |
| 3 | Copies ability ofJoker<br>to the left 2 times |
| 4 | +1 Discard(s) |
| 5 | Scoring cards<br>give +5 Mult |
| 6 | Create 1 Consumable(s)<br>each hand played<br>(Must have room) |
| 7 | X3 Chips |
| 8 | Earn $4 each<br>each hand played |
| 9 | Reduce Blind Size by 10%<br>each hand played |
| 10 | +100 Chips |
| 11 | Retrigger all scoring<br>cards 1 time(s) |
| 12 | Unknown Effect<br>with Bonus Effect |
#### Bonus States
| State | Effect | Note |
|:-----:|:------:| ---- |
| B1 | 2x Effectiveness | -- |
| B2 | Additional Hands | +2 Hands |
| B3 | Reduce Blind Size | -25% |
| B4 | Disable Boss Blind | -- |


### Quest?
| Type | Name | Quest | Active |
|:----:| ---- |:-----:| ------ |
| Hands | Honest Work | Play 60 Hands | Always Active |
| Hands | The Nail | Beat 6 Blinds in a row<br>with only One Hand played | Active until Failed<br>Resets next Blind |
| Hands | Super Speed | Play 8 Hands<br>in One Blind | Active in Blinds |
| Discards | Pollution | Discard 250 Cards | Always Active |
| Discards | The Anchor | Beat 9 Blinds in a row<br>without Discarding<br>any cards | Active until Failed<br>Resets next Blind |
| Discards | Anarchy | Discard 30 Cards<br>in One Blind | Active in Blinds |
| Money | Obliged Debt | Spend $300 | Always Active |
| Money | The Claw | Beat 6 Blinds in a row<br>without spending or<br>losing any Money | Active until Failed<br>Resets next Blind |
| Money | Big Bounty | Earn $100<br>in One Blind | Active in Blinds |
| Consumables | Consumerism | Use 100 Consumables | Always Active |
| Consumables | The Incentive | Beat 12 Blinds in a row<br>without using<br>any Consumables | Active until Failed<br>Resets next Blind |
| Consumables | Bullet Time | Use 10 Consumables<br>in One Blind | Active in Blinds |
| Jokers | Heartbeat | Skip 25 Buffoon Packs | Always Active |
| Jokers | The Soul | Beat 6 Blinds in a row<br>without adding or<br>selling any Jokers | Active until Failed<br>Resets next Blind |
| Jokers | Final Hunt | Sell 8 Jokers<br>in One Blind | Active in Blinds |


| Name | Effect | Spawns? | Source |
| ---- |:------:|:-------:| ------ |
| Duplitage | Gives a copy of the<br>next obtained Joker<br>(Must have room) | Yes | "Scav. Prototype"-Joker |
| Intimidating Tag | -20% Blind Size<br>next round | Yes | -- |
| Recycling Tag | Gain +1 discard<br>each round<br>(5/5 uses left) | Yes | -- |
| Tag at Hand | Gain +1 hand<br>each round<br>(5/5 uses left) | Yes | -- |
| Spin Tag | First shop reroll<br>costs $2 less<br>(5/5 uses left) | Yes | -- |
| Kiosk Tag | +1 card slot<br>available in<br>next shop | Yes | -- |
| Vouch-down Tag | Reduce the cost of a random<br>Voucher by $5 next shop | Yes | -- |
| Pearlescent Tag | Next base edition shop<br>Joker is free and<br>becomes Pearlescent | Yes | -- |
| Shiny Tag | Next base edition shop<br>Consumable is free and<br>becomes Shiny | Yes | -- |
| Doom | +?% Blind Size for<br>next Showdown Blind | No | Challenges |
| Lavish Debt | +?% Blind Size<br>next round | No | "Lavish Joker"-Joker,<br>Challenges |


| Name | Effect | Size | Reward | Showdown? |
| ---- |:------:|:----:|:------:| --------- |
| Golden Egg | Reward loses $1<br>each scoring card | X3.0 | $25 | No |
| The Frog | -1 hand size and<br>+1 discard for<br>each hand played | X2.0 | $5 | No, he's just<br>a tiny guy! |
| The Ghost | At start of the round,<br>increase Blind Size by 25%<br>for each Joker you own | X1.5 | $5 | No |
| The Pencil | Debuff first played<br>card every hand | X2.0 | $5 | No |
| Sharp Shooter | Five random Cards<br>debuffed every hand | X2.0 | $8 | Yes |


| Name | Effect | Details |   | Deck + Sleeve | Details |
| ---- |:------:| ------- | - |:-------------:| ------- |
| Burned Deck | Destroy the<br>first scoring card<br>every Hand | -- | | Destroy the<br>leftmost discarded<br>card each Discard | -- |
| Hopeless Deck | Unknown Winning Ante<br>Gain +1 Joker Slot<br>for every 4 Boss<br>Blinds defeated | Winning Ante<br>range: 6 - 14 | | Increased Winning Ante<br>Decrease amount<br>of needed Boss<br>Blinds by 1 | Winning Ante<br>range: 8 - 16 |
| Scartare Deck | Remove all Ranks below 7<br>+2 Hand size, -3 Discards<br>Discard 3 random cards<br>after each hand played | Affected by<br>"Discard Limit" | | +2 Hand size<br>Discard 2 additional<br>cards after each<br>hand played | -- |
| Strange Deck | "Generating Deck..."<br>Scoring playing cards<br>change suit and rank | -- | | "Loading Stats..."<br>Scoring playing cards<br>gain or lose chips & mult | Chips Min.: +2<br>Chips Max.: +11<br>Mult Min.: -1<br>Mult Max.: +2 |


| Name | Joker Effect | Card Effect |
| ---- |:------------:|:-----------:|
| Pearlescent | Reduce<br>Blind Size<br>by 5% | Reduce<br>Blind Size<br>by 5% |
| Resonance | Can't be Debuffed<br>Increase Blind<br>Size by 5% | Can't be Debuffed<br>Increase Blind<br>Size by 5% |
| Shiny | Gains $2 of<br>sell value at<br>end of round | Grant $1 of<br>sell value to a<br>random Joker |


| Base Name | Base Effect |   | Upgrade Name | Upgrade Effect | Unlock |   | Total Effect |
| --------- |:-----------:| - | ------------ |:--------------:|:------:| - |:------------:|
| Comedy Mask | Reduce all<br>Blind Sizes by 20%<br>-1 hand size | | Tragedy Mask | Reduce all<br>Blind Sizes by 20%<br>-1 hand size | Discover<br>10 Blinds | | Reduce all<br>Blind Sizes by 40%<br>-2 hand size |
| Old Urn | +1 Discard limit | | Cursed Urn | +2 Discard limit<br>but lose 1 Discard<br>each round | Discard a total<br>of 1250 cards | | +3 Discard limit<br>but lose 1 Discard<br>each round |


| Name | Effect | Type |
| ---- |:------:|:----:|
| Daybreak | Enhances each card<br>in hand into a<br>[Random Enhancement] | Spectral |
| Eden Token | You currently own<br>? Eden Tokens<br>Use this Eden Token<br>to create a random<br>Joker of any rarity<br>(Must have room)<br>Self destructs when<br>Boss Blind is defeated | Eden Token,<br>Spectral |
| Microcosm | Level down<br>a selected<br>Poker Hand<br>Enhances all<br>cards for the<br>Poker Hand to<br>Vintage Cards | Planet |
| Order | Replace all Jokers with<br>one random Joker in<br>your possession, the<br>new copies keep their<br>old Modifiers | Spectral |
| Soul Gem | Captures the<br>Soul of the next<br>defeated Blind | Spectral |
| The Backup | Enhances 2<br>selected cards to<br>Memory Cards | Tarot |
| The Ocean | Add Pearlescent<br>or Shiny to a<br>random Joker<br>or Playing Card<br>in your hand | Tarot |


| Name | Effect | Details |   | Deck + Sleeve | Details |
| ---- |:------:| ------- | - |:-------------:| ------- |
| Burned Deck | Destroy the<br>first scoring card<br>every Hand | -- | | Destroy the<br>leftmost discarded<br>card each Discard | -- |
| Hopeless Deck | Unknown Winning Ante<br>Gain +1 Joker Slot<br>for every 4 Boss<br>Blinds defeated | Winning Ante<br>range: 6 - 14 | | Increased Winning Ante<br>Decrease amount<br>of needed Boss<br>Blinds by 1 | Winning Ante<br>range: 8 - 16 |
| Scartare Deck | Remove all Ranks below 7<br>+2 Hand size, -3 Discards<br>Discard 3 random cards<br>after each hand played | Affected by<br>"Discard Limit" | | +2 Hand size<br>Discard 2 additional<br>cards after each<br>hand played | -- |
| Strange Deck | "Generating Deck..."<br>Scoring playing cards<br>change suit and rank | -- | | "Loading Stats..."<br>Scoring playing cards<br>gain or lose chips & mult | Chips Min.: +2<br>Chips Max.: +11<br>Mult Min.: -1<br>Mult Max.: +2 |

