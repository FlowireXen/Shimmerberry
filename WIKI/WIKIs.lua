WIKIs

https://balatromods.miraheze.org/wiki/Modded_Balatro_Wiki:Template_documentation/String_forms

Add to Joker Page while Changing Stuff:
{{incomplete|"Alternative Textures" and "Infos" will move to the Joker-Pages|##TODO##}}

Add to (Other) Pages till' updated:
{{incomplete|Missing information about New Update, check back later!|##TODO##}}


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
					"Can't be {C:perishable}Debuffed",
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





-- ##TODO## FIX : "ct|SEMBY[...]" -> These Colours don't exist, find alts.
-- ##TODO## FIX : "ct|??[...]" -> These Colours failed, find alts.
-- ##TODO## FIX : "<br> <small></small>" -> Remove.
-- ##TODO## REMOVE : "{{captimg||Target Plush|imgsize=142px}}" -> Target Plush is out of Date, remove/rename Page

-- ##TODO## : __TYPE__ --> https://balatromods.miraheze.org/wiki/Compendium/Joker_types
-- Add {{jtype|???}} to Jokers that have certain spawn conditions or unique spawn blocks (pinata)

-- ##TODO## DEFINE : Define in Header of Table that everything needs to be centered

== List of Jokers ==
<!-- Table Start -->
{| class="sortable wikitable" style="image-rendering:pixelated"
!Joker<br>Art & Name
!Effect & Infos
!Cost
!Rarity
!Type
!Artist &<br>Reference
!Alternative<br>Textures <!-- aka. "A.T." -->

|-
| {{captimg||Abandoned Soul|imgsize=142px}}
| Gains {{ct|xchips|X0.2}} Chips<br>when a {{ct|attention|face}} card<br>is destroyed<br>{{ct|inactive|(Currently {{ct|xchips|X1}} Chips)}}
| $6
| {{rarity|uncommon}}
| {{jtype|Xc}}
| '''unkokat'''

|-
| {{captimg||A.C.E.|imgsize=142px}} <small>{{ct|grey|Arbitrary Code Execution}}</small>
| Add the next {{ct|attention|1 to 5}}<br>playing cards from<br>Deck to scoring hand
| $7
| {{rarity|rare}}
| {{jtype|P!}}
| '''unkokat'''

|-
| {{captimg||Adblocker|imgsize=142px}}
| When {{ct|attention|Blind}} is selected,<br>{{ct|perishable|Debuff}} a random suit<br>in your deck<br>{{ct|inactive|(Debuffed: Nothing}}{{ct|inactive|)}}<br>Played debuffed cards<br>give {{ct|money|$2}} before scoring
| $8
| {{rarity|rare}}
| {{jtype|+$}}<br>{{jtype|XX}}
| '''unkokat'''

|-
| {{captimg||Afterimage|imgsize=142px}}
| Copies ability of<br>{{ct|attention|Joker}} to the left<br>{{ct|darkedition|3}} times
| $20
| {{rarity|legendary}}
| {{jtype|!!}} {{jtype|!!}} {{jtype|!!}}
| '''unkokat'''

|-
| {{captimg||Agent 47|imgsize=142px}}
| When discarding<br>exactly {{ct|attention|3}} cards,<br>{{ct|red|eliminate}} {{ct|attention|one}}<br>at random
| $6
| {{rarity|uncommon}}
| {{jtype|[X]}}
| '''unkokat'''

|-
| {{captimg||Alpha|imgsize=142px}}
| {{ct|blue|+1}} Hand for<br>{{ct|attention|first}} scoring<br>{{ct|enhanced|Stone Card}}
| $6
| {{rarity|common}}
| {{jtype|#!}}
| '''unkokat'''

|-
| {{captimg||Anchor|imgsize=142px}}
| {{ct|xchips|X2}} Chips<br>{{ct|red|Can't}} be<br>{{ct|attention|Highlighted}}
| $4
| {{rarity|common}}
| {{jtype|Xc}}
| '''unkokat'''

|-
| {{captimg||Annoying Dog|imgsize=142px}} {{ct|grey|Toby Fox}}
| {{ct|xmult|X3.0}} Mult<br>{{ct|red|No}} consumable slots
| $7
| {{rarity|rare}}
| {{jtype|Xm}}<br>{{jtype|XX}}
| '''Gappie'''

|-
| {{captimg||Anodized Steel|imgsize=142px}}
| Played {{ct|enhanced|Steel}} cards<br>{{ct|green|reduce}} the {{ct|attention|Blind Size}}<br>by {{ct|darkpurple|5%}} when scored
| $8
| {{rarity|uncommon}}
| {{jtype|~B}}
| '''unkokat'''

|-
| {{captimg||Axe|imgsize=142px}}
| Each {{ct|inactive|[Suit]}} card<br>held in hand has<br>a {{ct|green|20%}} chance to<br>be {{ct|attention|destroyed}}<br>{{ct|inactive|Suit changes}}<br>{{ct|inactive|every round}}<br>{{ct|green|80}}{{ct|inactive|/100}} uses left
| $6
| {{rarity|common}}
| {{jtype|[X]}}
| '''unkokat'''

|-
| {{captimg||Balloon|imgsize=142px}}
| {{ct|xmult|X2}} Mult<br>{{ct|red|Self destructs}}<br>when highlighting<br>{{ct|attention|4 or more}} cards
| $4
| {{rarity|common}}
| {{jtype|Xm}}
| '''unkokat'''

|-
| {{captimg||Barmy Joker|imgsize=142px}}
| {{ct|mult|+12}} Mult if poker<br>hand contains<br>{{ct|attention|3}} different suits
| $5
| {{rarity|common}}
| {{jtype|+m}}
| '''unkokat'''

|-
| {{captimg||Benthic Bloom|imgsize=142px}}
| Retrigger all<br>{{ct|enhanced|Enhanced Cards}}<br>{{ct|enhanced|Enhanced Cards}} have<br>a {{ct|green|1 in 4}} chance to<br>shatter like {{ct|attention|Glass}}<br>{{ct|burgundy|Possessive}}
| $6
| {{rarity|uncommon}}
| {{jtype|...}}<br>{{jtype|[X]}}
| '''unkokat'''

|-
| {{captimg||Blueberry|imgsize=142px}}
| Each scored<br>{{ct|attention|[King]}} or {{ct|attention|[Queen]}}<br>gives {{ct|chips|+30}} Chips<br>{{ct|inactive|[Ranks] change}}<br>{{ct|inactive|every round}}<br><small>Gets {{ct|red|Eaten}} when</small><br><small>no {{ct|attention|[King]}} or {{ct|attention|[Queen]}}</small><br><small>scored this round</small>
| $4
| {{rarity|common}}
| {{jtype|+c}}
| '''unkokat'''

|-
| {{captimg||Booster Pack|imgsize=142px}}
| {{ct|attention|3}} additional<br>{{ct|attention|Booster Packs}}<br>in each {{ct|money|Shop}}<br>{{ct|green|3}}{{ct|inactive|/3}} uses left
| $5
| {{rarity|common}}
| {{jtype|#!}}
| '''Flowire'''

|-
| {{captimg||Bound Joker|imgsize=142px}}
| When obtaining or<br>destroying this card,<br>apply {{ct|perishable|Bound}} to<br>{{ct|attention|3}} random Jokers
| $6
| {{rarity|uncommon}}
| {{jtype|[!]}}
| '''Flowire'''

|-
| {{captimg||Broken Record|imgsize=142px}}
| Randomly add {{ct|attention|2}} to {{ct|attention|3}}<br>retriggers to any<br>scoring cards
| $4
| {{rarity|common}}
| {{jtype|...}}
| '''unkokat'''

|-
| {{captimg||Buccaneer|imgsize=142px}}
| Adds {{ct|attention|thrice}} the sell<br>value of all other<br>owned {{ct|attention|Jokers}} to {{ct|chips|Chips}}<br>{{ct|inactive|(Currently {{ct|chips|+0}} Chips)}}
| $4
| {{rarity|common}}
| {{jtype|+c}}
| '''unkokat'''

|-
| {{captimg||Bunburrow|imgsize=142px}}
| Bunburrow<br>Gain {{ct|money|$12}} every<br>{{ct|attention|4}} {{ct|green|Rerolls}}<br>{{ct|inactive|(4 remaining)}}
| $4
| {{rarity|common}}
| {{jtype|+$}}
| '''unkokat'''

|-
| {{captimg||Butterfly|imgsize=142px}}
| {{ct|chips|0}} Chips<br>{{ct|green|Gains}} {{ct|chips|+8}} Chips<br>if played hand<br>contains a {{ct|attention|Pair}},<br>{{ct|red|Loses}} {{ct|chips|4}} Chips<br>if it doesn't
| $6
| {{rarity|common}}
| {{jtype|+c}}<br>{{jtype|~c}}
| '''unkokat'''

|-
| {{captimg||Cassette Beast|imgsize=142px}}
| Retrigger scoring cards<br>for {{ct|attention|each}} scoring suit
| $8
| {{rarity|rare}}
| {{jtype|...}}
| '''unkokat'''

|-
| {{captimg||Ceaseless Void|imgsize=142px}}
| When a Card is {{ct|attention|sold}}, gain<br>{{ct|darkpurple|+3%}} Blind Size, {{ct|xmult|X0.02}} Mult<br>or {{ct|xchips|X0.02}} Chips for each<br>{{ct|money|$1}} of sell value<br>When {{ct|attention|Blind}} is selected<br>{{ct|red|increase}} Blind Size by {{ct|darkpurple|0%}}<br>{{ct|xchips|X1}} Chips, {{ct|xmult|X1}} Mult
| $8
| {{rarity|rare}}
| {{jtype|XB}}<br>{{jtype|Xc}}<br>{{jtype|Xm}}
| '''unkokat'''

|-
| {{captimg||Chrono Break|imgsize=142px}}
| {{ct|legendary|Revive}} shattered<br>{{ct|attention|playing cards}}<br>{{ct|attention|Shatter}} all<br>scoring cards<br>each hand
| $7
| {{rarity|rare}}
| {{jtype|[+]}}<br>{{jtype|[X]}}
| '''Flowire'''

|-
| {{captimg||Cockroach|imgsize=142px}}
| {{ct|attention|+1}} Ante when<br>{{ct|attention|Boss Blind}}<br>is defeated<br>{{ct|burgundy|Possessive}}
| $6
| {{rarity|uncommon}}
| {{jtype|!!}}
| '''unkokat'''

|-
| {{captimg||Common Denominator|imgsize=142px}}
| Copies abilities of<br>{{ct|attention|all}} {{ct|??X1??|Common}} Jokers<br>{{ct|common|Commons}}: 0<br>{{ct|green|Compatible}}: 0<br>{{ct|red|Incompatible}}: 0
| $10
| {{rarity|rare}}
| {{jtype|!!}}
| '''unkokat'''

|-
| {{captimg||Copy Printer|imgsize=142px}}
| At the end of the {{ct|attention|Shop}}<br>convert the {{ct|attention|Joker}} to the {{ct|attention|left}}<br>into the {{ct|attention|Joker}} to the {{ct|attention|right}}<br>{{ct|inactive|(Destroyed/Maintained after use)}}
| $12
| {{rarity|rare}}
| {{jtype|!!}}
| '''unkokat'''

|-
| {{captimg||Coupon|imgsize=142px}}
| Shops are<br>{{ct|money|20%}} cheaper
| $6
| {{rarity|common}}
| {{jtype|!!}}<br>{{jtype|~$}}
| '''unkokat'''

|-
| {{captimg||Coupon Booklet|imgsize=142px}}
| Shops are {{ct|money|50%}} cheaper<br>Raise prices by {{ct|red|10%}}<br>on every {{ct|green|Reroll}}
| $6
| {{rarity|uncommon}}
| {{jtype|!!}}<br>{{jtype|~$}}
| '''unkokat'''

|-
| {{captimg||Daffy Joker|imgsize=142px}}
| {{ct|mult|+8}} Mult if poker<br>hand contains<br>{{ct|attention|2}} different suits
| $5
| {{rarity|common}}
| {{jtype|+m}}
| '''unkokat'''

|-
| {{captimg||DATAMINER|imgsize=142px}}
| {{ct|codegreen|Changes}} most<br>{{ct|enhanced|Numbers}} on newly<br>obtained {{ct|attention|Jokers}}<br>by {{ct|red|X0.5}} or {{ct|green|X2}}
| $7
| {{rarity|uncommon}}
| {{jtype|[!]}}
| '''unkokat'''

|-
| {{captimg||Digitizon|imgsize=142px}}
| When Blind is selected,<br>take {{ct|money|$1}} of {{ct|attention|sell value}}<br>from every {{ct|attention|Joker}} and<br>{{ct|attention|Consumable}} card<br>Create a {{ct|attention|Memory}} card<br>for every {{ct|money|$3}} taken<br>{{ct|inactive|({{ct|money|$3}} remaining)}}
| $6
| {{rarity|uncommon}}
| {{jtype|~$}}<br>{{jtype|[+]}}
| '''unkokat'''

|-
| {{captimg||Doomsday Device|imgsize=142px}}
| {{ct|attention|Double}} the stored<br>{{ct|chips|Memory Value}} every {{ct|attention|20}}<br>scoring {{ct|enhanced|Memory Cards}}<br>{{ct|inactive|(Currently {{ct|attention|0}}/20)}}
| $6
| {{rarity|uncommon}}
| {{jtype|[!]}}
| '''unkokat'''

|-
| {{captimg||Echoing Joker|imgsize=142px}}
| Create {{ct|green|2}} {{ct|darkedition|Negative}}<br>copies of the {{ct|attention|next}}<br>used {{ct|attention|Consumable}}<br><small>{{ct|inactive|(Probability affected)}}</small><br>{{ct|red|self destructs}}
| $8
| {{rarity|rare}}
| {{jtype|[+]}}
| '''Flowire'''

|-
| {{captimg||Eden's Blessing|imgsize=142px}}
| {{ct|xmultchips|X1.5}} Chips or Mult,<br>favours the small<br>Grants a<br>{{ct|xmultchips|Brighter Future}}<br>when {{ct|attention|Boss Blind}}<br>is defeated
| $4
| {{rarity|uncommon}}
| {{jtype|Xc}}<br>{{jtype|Xm}}
| '''lanedarushpy'''

|-
| {{captimg||Emergency Button|imgsize=142px}}
| Prevents Death and<br>{{ct|green|Rerolls}} all {{ct|attention|Jokers}}<br>and {{ct|attention|Consumables}}
| $6
| {{rarity|uncommon}}
| {{jtype|!!}}<br>{{jtype|[!]}}
| '''Flowire'''

|-
| {{captimg||Eternal Fortune|imgsize=142px}}
| {{ct|blue|+1}} Hand, {{ct|green|+1}} Luck
| $4
| {{rarity|common}}
| {{jtype|%!}}<br>{{jtype|#!}}
| '''unkokat'''

|-
| {{captimg||57 Leaf Clover|imgsize=142px}}
| Retrigger all<br>{{ct|enhanced|Wild Cards}}<br>{{ct|darkedition|3}} times
| $8
| {{rarity|uncommon}}
| {{jtype|...}}
| '''unkokat'''

|-
| {{captimg||Fire Exin't|imgsize=142px}}
| Reduce Shop prices<br>by {{ct|money|1%}} every played<br>and {{ct|attention|unscored}} card,<br>resets when {{ct|attention|Boss}}<br>{{ct|attention|Blind}} is selected<br>{{ct|inactive|(Currently {{ct|money|0%}}/50%)}}
| $6
| {{rarity|uncommon}}
| {{jtype|~$}}<br>{{jtype|???}}
| '''unkokat'''

|-
| {{captimg||Fortune Cookie|imgsize=142px}}
| Gains a new random<br>{{ct|darkedition|Edition}} at the start<br>of every {{ct|attention|Blind}}<br>Sell this card to<br>apply {{ct|darkedition|(This Edition)}} to<br>a random Joker
| $6
| {{rarity|common}}
| {{jtype|[!]}}
| '''unkokat'''

|-
| {{captimg||Fox Plush|imgsize=142px}}
| {{ct|chips|+12}} Chips for<br>each {{ct|attention|Joker}} and<br>{{ct|mult|+5}} Mult for each<br>empty {{ct|attention|Joker}} slot<br>{{ct|inactive|(}}{{ct|chips|+0}} {{ct|inactive|Chips,}} {{ct|mult|+0}} {{ct|inactive|Mult)}}
| $6
| {{rarity|common}}
| {{jtype|+c}}<br>{{jtype|+m}}
| '''unkokat'''

|-
| {{captimg||Gambler's Contract|imgsize=142px}} {{ct|grey|Evil Deal}}
| Shop Jokers have<br>a {{ct|green|1 in 13}} chance to<br>become {{ct|darkedition|Negative}} and<br>a {{ct|green|2 in 13}} chance to<br>become {{ct|burgundy|Possessive}}<br><small>{{ct|inactive|(Fixed probabilities)}}</small>
| $7
| {{rarity|rare}}
| {{jtype|[!]}}
| '''GhostSalt'''

|-
| {{captimg||Garden Gnome|imgsize=142px}}
| {{ct|mult|+30}} Mult<br>{{ct|attention|-2}} Hand size
| $5
| {{rarity|common}}
| {{jtype|+m}}<br>{{jtype|#!}}
| '''unkokat'''

|-
| {{captimg||Gold Bomb|imgsize=142px}}
| Destroy all<br>played cards<br>in {{ct|attention|final hand}}<br>of round
| $5
| {{rarity|uncommon}}
| {{jtype|[X]}}
| '''Flowire'''

|-
| {{captimg||Goldenberry|imgsize=142px}}
| Each scored<br>{{ct|attention|[King]}} or {{ct|attention|[Queen]}}<br>earns {{ct|money|$1}}-{{ct|money|$2}}<br>{{ct|inactive|[Ranks] change}}<br>{{ct|inactive|every round}}<br><small>Gets {{ct|red|Eaten}} when</small><br><small>no {{ct|attention|[King]}} or {{ct|attention|[Queen]}}</small><br><small>scored this round</small>
| $5
| {{rarity|uncommon}}
| {{jtype|+$}}
| '''unkokat'''

|-
| {{captimg||Goobert|imgsize=142px}}
| Creates {{ct|green|imperfect}}<br>copies of {{ct|attention|playing cards}}<br>added to your deck<br>{{ct|green|10}}{{ct|inactive|/10}} uses left
| $8
| {{rarity|uncommon}}
| {{jtype|[+]}}<br>{{jtype|[!]}}
| '''unkokat'''

|-
| {{captimg||Hemoturgy|imgsize=142px}}
| Discarded cards gain<br>a random {{ct|darkedition|Edition}},<br>{{ct|enhanced|Enhancement}} or {{ct|attention|Seal}}<br>{{ct|red|-2}} Discard Limit
| $7
| {{rarity|rare}}
| {{jtype|#!}}<br>{{jtype|[!]}}
| '''unkokat'''

|-
| {{captimg||Hoe|imgsize=142px}}
| Each {{ct|inactive|[Suit]}} card<br>held in hand<br>gives {{ct|chips|+25}} Chips<br>{{ct|inactive|Suit changes}}<br>{{ct|inactive|every round}}<br>{{ct|green|250}}{{ct|inactive|/250}} uses left
| $5
| {{rarity|common}}
| {{jtype|+c}}
| '''unkokat'''

|-
| {{captimg||Info Board|imgsize=142px}}
| Your {{ct|attention|Joker}} arrives in:<br>{{ct|mult|+20}} Mult
| $7
| {{rarity|uncommon}}
| {{jtype|+m}}<br>({{jtype|Xm}})
| '''unkokat'''

|-
| {{captimg||Hypetrain|imgsize=142px}}
| Level {{ct|xmult|X1}}!<br>Next stop in:<br>{{ct|mult|+20}} Mult
| $7
| {{rarity|uncommon}}
| {{jtype|+m}}<br>{{jtype|Xm}}
| '''unkokat'''

|-
| {{captimg||Improv Show|imgsize=142px}}
| Converts unused<br>{{ct|blue|Hands}} into {{ct|green|Points}}<br>at end of round<br>When playing your<br>{{ct|attention|final hand}}, convert<br>{{ct|attention|1}} {{ct|green|Point}} into {{ct|attention|1}} {{ct|blue|Hand}}<br>Stored: {{ct|attention|0}} {{ct|green|Points}}<br>{{ct|inactive|(Next point: 0%)}}
| $8
| {{rarity|rare}}
| {{jtype|#!}}
| '''unkokat'''

|-
| {{captimg||Incinerator|imgsize=142px}}
| {{ct|green|+1}} Discard Limit
| $5
| {{rarity|common}}
| {{jtype|#!}}
| '''unkokat'''

|-
| {{captimg||Inven-Tation|imgsize=142px}}
| {{ct|enhanced|Vintage Cards}} have a<br>{{ct|green|1 in 8}} chance to upgrade<br>the played poker hand
| $5
| {{rarity|uncommon}}
| {{jtype|!!}}
| '''unkokat'''

|-
| {{captimg||JEVIL|imgsize=142px}} {{ct|grey|JEV][L}}
| Played {{ct|attention|Playing Cards}}<br>evaluate {{ct|attention|twice}}
| $20
| {{rarity|legendary}}
| {{jtype|>>}}
| '''Flowire'''

|-
| {{captimg||Jokebra|imgsize=142px}}
| When {{ct|attention|Blind}} is selected,<br>set an additional {{ct|enhanced|Target}}<br>{{ct|inactive|(Between {{ct|blue|100 and 1000}})}}<br>Beat the {{ct|attention|Blind}} when<br>the Round score<br>matches the {{ct|enhanced|Target}}
| $8
| {{rarity|uncommon}}
| {{jtype|!!}}<br>({{jtype|~B}})
| '''Flowire'''

|-
| {{captimg||Lavish Joker|imgsize=142px}} {{ct|grey|Lavish Chad}}
| Regain lost {{ct|money|Money}}<br>at start of {{ct|attention|shop}}<br>{{ct|inactive|(Currently {{ct|money|$0}})}}<br>Each {{ct|money|$1}} regained<br>{{ct|red|increases}} the next<br>{{ct|attention|Blind Size}} by {{ct|darkpurple|5%}}<br>{{ct|inactive|(Currently {{ct|darkpurple|+0%}})}}
| $0
| {{rarity|rare}}
| {{jtype|+$}}<br>({{jtype|XB}})
| '''unkokat'''

|-
| {{captimg||Lost Constellation|imgsize=142px}}
| {{ct|green|1 in 3}} {{ct|planet|Planet}} cards<br>upgrade poker hand<br>{{ct|attention|2}} additional times
| $6
| {{rarity|uncommon}}
| {{jtype|!!}}
| '''Gappie'''

|-
| {{captimg||Lottery Ticket|imgsize=142px}}
| Scoring {{ct|attention|non-face}} cards<br>have a {{ct|green|1 in 4}} chance<br>to give {{ct|mult|+2.5}} Mult or<br>{{ct|chips|+12}} Chips otherwise
| $5
| {{rarity|common}}
| {{jtype|+c}}<br>{{jtype|+m}}
| '''unkokat'''

|-
| {{captimg||Melon|imgsize=142px}}
| When {{ct|attention|Blind}} is selected,<br>{{ct|green|reduce}} {{ct|attention|Blind Size}} by {{ct|darkpurple|50%}}<br>{{ct|attention|Destroyed}} when<br>{{ct|attention|Boss Blind}} is defeated
| $6
| {{rarity|uncommon}}
| {{jtype|~B}}
| '''unkokat'''

|-
| {{captimg||Mineshaft|imgsize=142px}}
| Every {{ct|attention|3}} scoring<br>cards, add a {{ct|enhanced|Stone}},<br>{{ct|enhanced|Steel}} or {{ct|enhanced|Gold}} card<br>to the deck<br>{{ct|inactive|(Currently {{ct|attention|0}}/3)}}<br>{{ct|green|50}}{{ct|inactive|/50}} uses left
| $6
| {{rarity|common}}
| {{jtype|[+]}}
| '''unkokat'''

|-
| {{captimg||Misery|imgsize=142px}}
| {{ct|xmult|X0.5}} Mult<br>{{ct|xchips|X4.0}} Chips for {{ct|attention|first}}<br>{{ct|attention|hand}} of round
| $5
| {{rarity|common}}
| {{jtype|Xc}}<br>{{jtype|Xm}}
| '''Flowire'''

|-
| {{captimg||Money Laundering|imgsize=142px}}
| When {{ct|attention|Blind}} is selected,<br>gain {{ct|blue|+2}} Hands and<br>{{ct|red|+2}} Discards<br>{{ct|red|Increase}} shop<br>prices by {{ct|money|100%}}
| $9
| {{rarity|uncommon}}
| {{jtype|#!}}<br>{{jtype|~$}}
| '''unkokat'''

|-
| {{captimg||Nashi Pear|imgsize=142px}}
| When Blind is selected,<br>increase {{ct|attention|Round score}}<br>by {{ct|darkpurple|10.000}} and reduce<br>this by {{ct|darkpurple|2000}}
| $3
| {{rarity|common}}
| {{jtype|+S}}
| '''unkokat'''

|-
| {{captimg||Oblivion|imgsize=142px}}
| When beating Ante {{ct|attention|1+}}<br>Loop back to Ante {{ct|attention|1}}<br>Every Loop {{ct|red|increases}}<br>all {{ct|attention|Blind Sizes}} by {{ct|darkpurple|50%}}<br>{{ct|inactive|(Currently {{ct|darkpurple|+0%}})}}<br>Every Loop {{ct|green|increases}}<br>{{ct|attention|Boss}} payouts by {{ct|money|$3}}<br>{{ct|inactive|(Currently {{ct|money|$0}})}}
| $20
| {{rarity|legendary}}
| {{jtype|O!}}<br>{{jtype|+$}}
| '''Flowire'''

|-
| {{captimg||Obscure Ritual|imgsize=142px}}
| {{ct|green|Reduce}} {{ct|attention|Blind Size}}<br>by {{ct|darkpurple|66.6}} when drawing<br>the {{ct|attention|last}} card
| $5
| {{rarity|uncommon}}
| {{jtype|~B}}
| '''unkokat'''

|-
| {{captimg||Opulent Skint|imgsize=142px}}
| Sell this card to<br>{{ct|attention|replace}} a random<br>card in the Shop<br>with this {{ct|attention|Joker}}<br>{{ct|green|1 in 256}} chance<br>to transform into<br>a {{ct|legendary|Legendary}} Joker<br>when {{ct|attention|Bought}}
| $10
| {{rarity|uncommon}}
| {{jtype|[!]}}<br>{{jtype|[+]}}
| '''unkokat'''

|-
| {{captimg||Ouroboros|imgsize=142px}}
| Each scored {{ct|attention|8}} gives<br>{{ct|blue|+1}} Hand and {{ct|red|increases}}<br>the {{ct|attention|Blind Size}} by {{ct|darkpurple|8%}}
| $8
| {{rarity|rare}}
| {{jtype|XB}}<br>{{jtype|#!}}
| '''unkokat'''

|-
| {{captimg||Paper Swan|imgsize=142px}}
| {{ct|xchips|X2}} Chips every<br>{{ct|attention|5}} scoring cards<br>{{ct|inactive|(Currently {{ct|attention|0}}/5)}}
| $5
| {{rarity|common}}
| {{jtype|Xc}}
| '''unkokat'''

|-
| {{captimg||P2W|imgsize=142px}}
| Spend {{ct|money|$2}} to<br>gain {{ct|mult|+30}} Mult<br>each Hand
| $4
| {{rarity|common}}
| {{jtype|+m}}<br>{{jtype|~$}}
| '''unkokat'''

|-
| {{captimg||Peculiar Joker|imgsize=142px}}
| {{ct|chips|+100}} Chips if poker<br>hand contains<br>{{ct|attention|3}} different suits
| $5
| {{rarity|common}}
| {{jtype|+c}}
| '''unkokat'''

|-
| {{captimg||Perfect Pitch|imgsize=142px}}
| {{ct|xmult|X2}} Mult when {{ct|attention|scoring}}<br>exactly {{ct|attention|[1-5]}} card(s)<br><small>{{ct|inactive|(Amount changes every hand)}}</small><br>Gain {{ct|xmult|X1}} Mult<br>after {{ct|attention|5}} successful<br>hands in a row<br>{{ct|inactive|(Currently {{ct|attention|0}}/5)}}
| $6
| {{rarity|uncommon}}
| {{jtype|Xm}}
| '''unkokat'''

|-
| {{captimg||P.E.T.|imgsize=142px}}
| This Joker gains<br>{{ct|mult|+2}} Mult for every card<br>discarded this round<br>{{ct|inactive|(Currently}} {{ct|mult|+0}} {{ct|inactive|Mult)}}
| $5
| {{rarity|common}}
| {{jtype|+m}}
| '''unkokat'''

|-
| {{captimg||Piggy Bank|imgsize=142px}}
| When {{ct|attention|Blind}} is selected<br>or skipped, spend {{ct|money|$2}} to<br>add {{ct|money|$1}} of {{ct|attention|sell value}}<br>Starts with {{ct|money|$2}}<br>extra {{ct|attention|sell value}}<br>{{ct|xmult|X0.2}} Mult for every<br>{{ct|money|$4}} of {{ct|attention|sell value}}<br>{{ct|inactive|(Currently}} {{ct|xmult|X1}} {{ct|inactive|Mult)}}
| $5
| {{rarity|common}}
| {{jtype|Xm}}<br>{{jtype|~$}}
| '''unkokat'''

|-
| {{captimg||Pickaxe|imgsize=142px}}
| Each {{ct|inactive|[Suit]}} card<br>held in hand has<br>a {{ct|green|40%}} chance<br>to give {{ct|money|$2}}<br>{{ct|inactive|Suit changes}}<br>{{ct|inactive|every round}}<br>{{ct|green|200}}{{ct|inactive|/200}} uses left
| $5
| {{rarity|common}}
| {{jtype|+$}}
| '''unkokat'''

|-
| {{captimg||Piñata|imgsize=142px}} {{ct|grey|Quick Brown Fox}}
| {{ct|green|1 in 5}} chance to<br>break open {{ct|attention|each}}<br>{{ct|attention|hand}} played<br>Gain {{ct|attention|+1}} permanent<br>{{ct|attention|Consumable}} slot and<br>fill all Consumable<br>slots when Joker<br>gets destroyed
| $6
| {{rarity|common}}
| {{jtype|#!}}<br>{{jtype|[+]}}<br>{{jtype|???}}
| '''unkokat'''

|-
| {{captimg||Plastic Key|imgsize=142px}}
| {{ct|attention|Destroy}} this card and<br>create {{ct|attention|2}} {{ct|spectral|Spectral}} cards<br>when {{ct|attention|Boss Blind}} is defeated<br>{{ct|inactive|(Must have room)}}
| $6
| {{rarity|uncommon}}
| {{jtype|[+]}}
| '''unkokat'''

|-
| {{captimg||Pocket Dimension|imgsize=142px}}
| Cards in your<br>{{ct|attention|Consumable}} area<br>give {{ct|xmult|X1.5}} Mult<br>{{ct|attention|+3}} Consumable slots
| $8
| {{rarity|rare}}
| {{jtype|Xm}}<br>{{jtype|#!}}
| '''unkokat'''

|-
| {{captimg||Potted Flower|imgsize=142px}}
| {{ct|xchips|X4}} Chips if poker<br>hand contains<br>{{ct|attention|4}} different suits
| $6
| {{rarity|uncommon}}
| {{jtype|Xc}}
| '''unkokat'''

|-
| {{captimg||Pygmymall|imgsize=142px}}
| {{ct|attention|+2}} card slots<br>available in shop<br>every {{ct|attention|3}} shops<br>{{ct|inactive|In 3 shops}}
| $6
| {{rarity|uncommon}}
| {{jtype|#!}}
| '''unkokat'''

|-
| {{captimg||Red Lion|imgsize=142px}} {{ct|grey|Reagent}}
| {{ct|xmult|X2.5}} Mult<br>Loses {{ct|xmult|X0.1}} Mult<br>for each {{ct|enhanced|Enhanced}}<br>card in your deck
| $6
| {{rarity|uncommon}}
| {{jtype|Xm}}
| '''unkokat'''

|-
| {{captimg||Red Mask|imgsize=142px}}
| This Joker gains {{ct|chips|+10}} Chips<br>when adding or removing<br>a {{ct|attention|playing card}}<br>{{ct|inactive|(Currently}} {{ct|chips|+0}} {{ct|inactive|Chips)}}
| $6
| {{rarity|uncommon}}
| {{jtype|+c}}
| '''unkokat'''

|-
| {{captimg||Replicator|imgsize=142px}}
| {{ct|attention|Destroys}} the next {{ct|attention|10}}<br>played cards to {{ct|attention|Duplicate}}<br>the rightmost Joker<br>{{ct|red|self destructs}}<br>{{ct|inactive|(Currently {{ct|attention|0}}/20)}}
| $6
| {{rarity|rare}}
| {{jtype|[X]}}<br>{{jtype|[+]}}<br>{{jtype|???}}
| '''unkokat'''

|-
| {{captimg||Ripped Joker|imgsize=142px}}
| {{ct|chips|+100}} Chips if played<br>hand contains<br>{{ct|attention|3}} or fewer cards
| $5
| {{rarity|common}}
| {{jtype|+c}}
| '''Flowire'''

|-
| {{captimg||Risky Joker|imgsize=142px}}
| Scoring cards {{ct|red|take}}<br>{{ct|chips|6}} Chips and {{ct|mult|1}} Mult<br>and increase the<br>Blind Payout by {{ct|money|$1}}<br>{{ct|inactive|(Next payout {{ct|money|+$0}})}}
| $6
| {{rarity|common}}
| {{jtype|~c}}<br>{{jtype|~m}}<br>{{jtype|+$}}
| '''unkokat'''

|-
| {{captimg||Scaffolding|imgsize=142px}}
| {{ct|inactive|{{ct|attention|0}}/5}} Hand size<br>When a {{ct|attention|Joker}} is {{ct|attention|sold}},<br>gain {{ct|attention|+1}} Hand size for<br>each {{ct|money|$1}} of sell value<br>{{ct|red|Lose}} {{ct|attention|2}} Hand size<br>each {{ct|blue|Hand}} played
| $5
| {{rarity|uncommon}}
| {{jtype|#!}}
| '''unkokat'''

|-
| {{captimg||Scav. Prototype|imgsize=142px}}
| When {{ct|attention|Blind}} is selected,<br>destroy {{ct|attention|adjacent}} Jokers<br>{{ct|green|1 in 4}} chance to gain<br>a {{ct|attention|Duplitage}} for each<br>destroyed Joker
| $5
| {{rarity|uncommon}}
| {{jtype|[X]}}<br>{{jtype|!!}}
| '''unkokat'''

|-
| {{captimg||7 Wonders|imgsize=142px}}
| When {{ct|attention|Blind}} is selected<br>{{ct|green|reduce}} the {{ct|attention|Blind Size}}<br>by {{ct|darkpurple|2%}} for each {{ct|attention|7}} in<br>your {{ct|attention|full deck}}<br>{{ct|inactive|(Currently {{ct|darkpurple|0%}}/50%)}}
| $7
| {{rarity|uncommon}}
| {{jtype|~B}}
| '''unkokat'''

|-
| {{captimg||Shimmerberry|img=Shimmerberry_Joker_(Shimmerberry).png|imgsize=142px}}
| Each scored<br>{{ct|attention|[King]}} or {{ct|attention|[Queen]}}<br>{{ct|green|reduces}} {{ct|attention|Blind}}<br>{{ct|attention|Size}} by {{ct|darkpurple|5%}}<br>{{ct|inactive|[Ranks] change}}<br>{{ct|inactive|every round}}<br><small>Gets {{ct|red|Eaten}} when</small><br><small>no {{ct|attention|[King]}} or {{ct|attention|[Queen]}}</small><br><small>scored this round</small>
| $6
| {{rarity|rare}}
| {{jtype|~B}}
| '''unkokat'''

|-
| {{captimg||Shooting Star|imgsize=142px}}
| When {{ct|attention|Boss Blind}} is<br>defeated, upgrade<br>every {{ct|legendary|Poker Hand}}<br>by {{ct|green|1}} level{{ct|inactive|(s)}}<br><small>{{ct|inactive|(Probability affected)}}</small>
| $7
| {{rarity|uncommon}}
| {{jtype|#!}}
| '''unkokat'''

|-
| {{captimg||Shrewd Joker|imgsize=142px}}
| {{ct|chips|+50}} Chips if poker<br>hand contains<br>{{ct|attention|2}} different suits
| $5
| {{rarity|common}}
| {{jtype|+c}}
| '''unkokat'''

|-
| {{captimg||Silver Mask|imgsize=142px}}
| Earn {{ct|money|$2}} each {{ct|attention|missing}}<br>Hand size below {{ct|attention|10}} at<br>the end of the round<br>{{ct|inactive|(Currently {{ct|money|+$20}})}}
| $6
| {{rarity|common}}
| {{jtype|+$}}
| '''unkokat'''

|-
| {{captimg||Singularity|imgsize=142px}}
| Create a copy of every<br>{{ct|attention|scoring card}} without an<br>{{ct|purple|Event Horizon}} sticker<br>When this {{ct|attention|Joker}} gets<br>removed, {{ct|red|Destroy}} all<br>cards it has created<br>{{ct|inactive|(Can't be {{ct|perishable|Debuffed}})}}<br>Occupies {{ct|attention|3}} Joker slots
| $10
| {{rarity|rare}}
| {{jtype|[+]}}<br>{{jtype|[X]}}
| '''unkokat'''

|-
| {{captimg||Stern Teacher|imgsize=142px}}
| When {{ct|attention|Blind}} is selected,<br>{{ct|perishable|Debuff}} adjacent Jokers<br>for the current round<br>{{ct|mult|+25}} Mult for each<br>{{ct|perishable|Debuffed}} Joker<br>{{ct|inactive|(Currently {{ct|mult|+0}} Mult)}}
| $5
| {{rarity|uncommon}}
| {{jtype|+m}}<br>{{jtype|XX}}
| '''unkokat'''

|-
| {{captimg||Strawberry|imgsize=142px}}
| Each scored<br>{{ct|attention|[King]}} or {{ct|attention|[Queen]}}<br>gives {{ct|mult|+8}} Mult<br>{{ct|inactive|[Ranks] change}}<br>{{ct|inactive|every round}}<br><small>Gets {{ct|red|Eaten}} when</small><br><small>no {{ct|attention|[King]}} or {{ct|attention|[Queen]}}</small><br><small>scored this round</small>
| $5
| {{rarity|uncommon}}
| {{jtype|+m}}
| '''unkokat'''

|-
| {{captimg||Stylish Joker|imgsize=142px}}
| Earn {{ct|money|$1}} for every<br>{{ct|attention|Consumable}} you keep<br>at the end of round<br>{{ct|attention|+2}} consumable slots<br>and {{ct|red|-1}} hand size
| $5
| {{rarity|uncommon}}
| {{jtype|#!}}<br>{{jtype|+$}}
| '''unkokat'''

|-
| {{captimg||Stocked Shelves|imgsize=142px}}
| {{ct|attention|Restocks}} bought<br>Booster Packs, Cards<br>and Vouchers in {{ct|money|Shop}}<br>{{ct|green|8}}{{ct|inactive|/8}} uses left
| $4
| {{rarity|common}}
| {{jtype|[+]}}
| '''unkokat'''

|-
| {{captimg||Sword Swallower|imgsize=142px}}
| {{ct|xmult|X1}} Mult for each<br>{{ct|??X1??|Common}} Joker<br>{{ct|inactive|(Currently}} {{ct|xmult|X1}} {{ct|inactive|Mult)}}
| $8
| {{rarity|rare}}
| {{jtype|Xm}}
| '''unkokat'''

|-
| {{captimg||PUSH UR T3MPRR|imgsize=142px}}
| {{ct|attention|BLIND}} SELECTED,<br>{{ct|red|CLOCK IT UP}} {{ct|darkpurple|200%}}<br>{{ct|attention|CARD}} PLAYED,<br>{{ct|green|PUSH IT DOWN}} {{ct|darkpurple|6%}}
| $5
| {{rarity|uncommon}}
| {{jtype|XB}}<br>{{jtype|~B}}<br>{{jtype|XX}}
| '''Flowire'''

|-
| {{captimg||Tempered Glass|imgsize=142px}}
| Every played {{ct|enhanced|Glass Card}}<br>permanently decreases<br>the chance of breaking<br>by {{ct|attention|2}} when scored<br><small>{{ct|inactive|(ex:}} {{ct|green|1 in 4}} {{ct|inactive|->}} {{ct|green|1 in 6}}{{ct|inactive|)}}</small>
| $4
| {{rarity|common}}
| {{jtype|[!]}}
| '''Flowire'''

|-
| {{captimg||The Dwarf|imgsize=142px}}
| When {{ct|attention|Blind}} is selected,<br>set hand size to {{ct|attention|5}} and<br>add the {{ct|attention|difference}}<br>to the {{ct|red|Discards}}
| $6
| {{rarity|uncommon}}
| {{jtype|#!}}
| '''unkokat'''

|-
| {{captimg||The Giant|imgsize=142px}}
| When {{ct|attention|Blind}} is selected,<br>{{ct|attention|lose all discards}} and<br>gain {{ct|attention|as much}} hand size
| $6
| {{rarity|uncommon}}
| {{jtype|#!}}
| '''unkokat'''

|-
| {{captimg||TMTRAINER|imgsize=142px}}
| {{ct|codegreen|Randomizes}} most<br>{{ct|enhanced|Numbers}} on newly<br>obtained {{ct|attention|Jokers}}<br>Range: {{ct|red|-15%}}-{{ct|green|255%}}<br>{{ct|attention|+1}} Joker slot
| $9
| {{rarity|rare}}
| {{jtype|[!]}}<br>{{jtype|#!}}<br>{{jtype|???}}
| '''Flowire'''

|-
| {{captimg||To n' Fro|imgsize=142px}} {{ct|grey|Fro n' To}}
| Played cards swap<br>{{ct|chips|Chips}} and {{ct|mult|Mult}}<br>before scoring
| $5
| {{rarity|common}}
| {{jtype|~c}}<br>{{jtype|~m}}
| '''unkokat'''

|-
| {{captimg||Shovel|imgsize=142px}}
| Each {{ct|inactive|[Suit]}} card<br>held in hand<br>gives {{ct|xmult|X1.2}} Mult<br>{{ct|inactive|Suit changes}}<br>{{ct|inactive|every round}}<br>{{ct|green|200}}{{ct|inactive|/200}} uses left
| $6
| {{rarity|common}}
| {{jtype|Xm}}
| '''unkokat'''

|-
| {{captimg||Toolkit|imgsize=142px}}
| All {{ct|attention|Jokers}} to the {{ct|attention|left}},<br>that have a limited<br>number of uses, are<br>{{ct|green|repaired}} and regain<br>up to {{ct|attention|5}} uses at the<br>end of the round<br>{{ct|green|200}}{{ct|inactive|/200}} uses left<br><small>{{ct|inactive|Can't be repaired}}</small>
| $4
| {{rarity|common}}
| {{jtype|[!]}}<br>{{jtype|!!}}
| '''unkokat'''

|-
| {{captimg||20 to Die for|imgsize=142px}}
| Quadruples all {{ct|attention|listed}}<br><big>{{ct|green|probabilities}}</big><br>{{ct|inactive|(ex: {{ct|green|1 in 3 -> 4 in 3}})}}
| $6
| {{rarity|rare}}
| {{jtype|%!}}
| '''unkokat'''

|-
| {{captimg||Unicorn|imgsize=142px}}
| {{ct|chips|+20}} Chips for each unique<br>{{ct|darkedition|Edition}}, {{ct|enhanced|Enhancement}} or<br>{{ct|attention|Seal}} in your full deck<br>{{ct|inactive|(Currently {{ct|chips|+0}} Chips)}}
| $6
| {{rarity|common}}
| {{jtype|+c}}
| '''unkokat'''

|-
| {{captimg||V.I.P. Ticket|imgsize=142px}}
| {{ct|enhanced|Bonus Cards}} always<br>shuffle to the top<br>of the {{ct|attention|Deck}}
| $5
| {{rarity|common}}
| {{jtype|!!}}
| '''unkokat'''

|-
| {{captimg||Warm Embrace|imgsize=142px}}
| {{ct|chips|Chips}} and {{ct|mult|Mult}} are<br>rounded up to the<br>{{ct|attention|next}} multiple of {{ct|attention|10}}
| $5
| {{rarity|common}}
| {{jtype|~c}}<br>{{jtype|~m}}
| '''unkokat'''

|-
| {{captimg||Watching Forest|imgsize=142px}}
| Sort the Deck<br>{{ct|attention|lowest to highest}}<br>after drawing the<br>first hand each round<br>Change sort order<br>every {{ct|attention|3}} hands played<br>{{ct|inactive|2 remaining}}
| $6
| {{rarity|rare}}
| {{jtype|!!}}
| '''unkokat'''

|}
<!-- Table End -->
