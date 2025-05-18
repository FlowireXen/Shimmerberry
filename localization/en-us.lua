return {
    descriptions = {
        Joker = {
			j_SEMBY_abandoned_soul = {
				name = "Abandoned Soul",
				text = {
					"This Joker gains {X:chips,C:white}X#1#{} Chips every",
					"time a {C:attention}Playing card{} is destroyed",
					"{C:inactive}(Currently {X:chips,C:white}X#2#{}{C:inactive} Chips){}"
				}
			},
			j_SEMBY_boosterpack_joker = {
				name = "Booster Pack",
				text = {
					"{C:attention}#1#{} additional",
					"{C:attention}Booster Packs{}",
					"in each {C:gold}Shop{}"
				},
			},
			j_SEMBY_bound = {
				-- Has it's own Lovely Patch
				name = "Bound Joker",
				text = {
					"{C:attention}+#1#{} Joker slots",
					"{C:red}Disable{} and {C:red}Destroy{}",
					"{C:attention}leftmost{} joker at",
					"beginning of round",
					"{C:inactive,s:0.75}(Doesn't need room){}"
					--> Joker Slots don't Matter, you can always get this
					--> It itself will still use up a Joker-Slot
					--> If you have a better way of describing this behaviour, please tell me!
				}
			},
			j_SEMBY_debugjoker = {
				-- Unused Joker, translation not needed.
				name = "DEBUGJOKER",
				text = {
					"{X:chips,C:white} X0.0 {} Chips, {X:mult,C:white} X0.0 {} Mult",
					"{C:blue}+1{} hand every hand",
					"{C:red}+1{} discard every discard",
				}
			},
			j_SEMBY_echoing_joker_one = {
				-- Amount changes depending on conditions
				name = "Echoing Joker",
				text = {
					"Create {C:green}1{} {C:dark_edition}Negative{} copy", -- 1 cop-y
					"of the next used {C:attention}Consumable{}"
				}
			},
			j_SEMBY_echoing_joker_multiple = {
				-- Amount changes depending on conditions
				name = "Echoing Joker",
				text = {
					"Create {C:green}#1#{} {C:dark_edition}Negative{} Copies", -- X cop-ies
					"of the next used {C:attention}Consumable{}"
				}
			},
			j_SEMBY_emergency_button = {
				name = "Emergency Button",
				text = {
					"Prevents Death and {C:legendary}Rerolls{}",
					"all {C:attention}Jokers{} and {C:attention}Consumables{}"
				}
			},
			j_SEMBY_chaos_jevil = {
				name = "JEV][L",
				text = {
					"Generates a random",
					"{C:dark_edition}Negative{} {C:attention}Consumable{}",
					"at beginning of round,",
					"{C:green}#1# in #2#{} to replace it",
					"with a random \"{C:spectral}Joker{}\"",
				}
			},
			j_SEMBY_loop_hero = {
				-- Reference: https://loophero.fandom.com/wiki/Oblivion
				name = "Oblivion",
				text = {
					"{C:attention}-#1#{} Ante when",
					"{C:attention}Boss Blind{}",
					"is defeated",
					"{C:inactive,s:0.75}Blinds slowly grow{}",
					"{C:inactive,s:0.75}stronger each loop{}"
				}
			},
			j_SEMBY_lost_constellation = {
				-- Tetrapak: https://github.com/tetraminus/Tetrapak
				name = "Lost Constellation",
				text = {
					"{C:green}#1# in #2#{} {C:planet}Planet{} cards",
					"upgrade hand {C:attention}#3# times{}",
					"{C:inactive,s:0.75}Inspired by Tetrapak!{}"
				}
			},
			j_SEMBY_misery = {
				name = "Misery",
				text = {
					"{X:mult,C:white} X#1# {} Mult",
					"{X:chips,C:white} X#2# {} Chips"
				}
			},
			j_SEMBY_money_laundering = {
				name = "Money Laundering",
				text = {
					"When {C:attention}Blind{} is selected, gain",
					"{C:blue}+#1#{} Hands and {C:red}+#2#{} Discards",
					"Shops are {C:attention}Expensive{}"
				}
			},
			j_SEMBY_potted_flowers = {
				name = "Potted Flowers",
				text = {
					"Gains {X:chips,C:white}X#1#{} Chips if",
					"poker hand contains a",
					"{C:diamonds}Diamond{} card, {C:clubs}Club{} card,",
					"{C:hearts}Heart{} card, and {C:spades}Spade{} card",
					"{C:inactive}(Currently {}{X:chips,C:white}X#2#{}{C:inactive} Chips){}"
				}
			},
			j_SEMBY_shooting_star_one = {
				-- Amount changes depending on conditions
				name = "Shooting Star",
				text = {
					"Upgrade every",
					"{C:legendary,E:1}Poker Hand{}",
					"by {C:green}1{} level", -- 1 level
					"when {C:attention}Boss Blind{}",
					"is defeated"
				}
			},
			j_SEMBY_shooting_star_multiple = {
				-- Amount changes depending on conditions
				name = "Shooting Star",
				text = {
					"Upgrade every",
					"{C:legendary,E:1}Poker Hand{}",
					"by {C:green}#1#{} levels", -- X level-s
					"when {C:attention}Boss Blind{}",
					"is defeated"
				}
			},
			j_SEMBY_swordswallower = {
				name = "Sword Swallower",
				text = {
					"{X:mult,C:white}X1{} Mult for each",
					"{X:blue,C:white}Common{} Joker",
					"{C:inactive}(Currently {}{X:mult,C:white}X#1#{}{C:inactive} Mult){}"
				}
			},
			j_SEMBY_tonfro_joker = {
				-- "To and Fro": https://dictionary.cambridge.org/dictionary/english/to-and-fro
				name = "To n' Fro",
				text = {
					"Played cards swap",
					"{C:chips}Chips{} and {C:mult}Mult{} when scored",
					"Earn {C:gold}$#1#{} every {C:attention}#2#{} swaps",
					"{C:inactive}(#3# Left){}"
				}
			},
			j_SEMBY_true_mystery = {
				name = "Mystery Joker?",
				text = { 
					"Sell for a {C:green}Random Joker{}",
					"{C:inactive,s:0.75}Who could it be? It's a {}{C:legendary,s:0.75}Mystery{}{C:inactive,s:0.75}!{}",
					"{C:inactive,s:0.75}Is this it, are you fooling me?{}",
					"{C:dark_edition,s:0.75}We shall see!{}"
				}
			},
		},
        Back = {
			b_SEMBY_skat = {
				-- German Localization can use "Skat"(ska:t) instead.
				name = "Scartare Deck",
				text = {
					"Remove all ranks below {C:attention}#1#{}",
					"{C:attention}+#2#{} hand size and {C:red}-#3#{} discards",
					"Discard {C:red}#4#{} random cards",
					"with each hand played"
				},
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
			bl_SEMBY_ten_pace = {
				name = 'Ten Paces',
				text = {
					'If scored {C:chips}chips{} are between',
					'{C:attention}#1#%{} and {C:attention}#2#%{} of required {C:chips}chips{},',
					'{C:attention}increase{} required {C:chips}chips{} by {C:legendary}#3#%{}'
				}
			},
		},
        Sleeve = {
            sl_SEMBY_skat = {
				-- German Localization can use "Skat"(ska:t) instead.
                name = "Scartare Sleeve",
                text = {
					"Remove all ranks below {C:attention}#1#{}",
					"{C:attention}+#2#{} hand size and {C:red}-#3#{} discards",
					"Discard {C:red}#4#{} random cards",
					"with each hand played"
				}
            },
			sl_SEMBY_skat_alt = {
				-- German Localization can use "Skat"(ska:t) instead.
                name = "Scartare Sleeve",
                text = {
					"Gain {C:blue}+#1#{} hand every round",
					"Discard an additional {C:red}#2#{} random",
					"cards with each hand played"
				}
            },
        }
    },
    misc = {
		dictionary = {
			SEMBY_eval_echoing_joker = "Echoed!",
			SEMBY_eval_emergency_button = "EMERGENCY MEETING", -- Reference: Among us
			SEMBY_eval_loop_hero = "Loop ", -- followed by a number
			SEMBY_eval_loop_hero_removed = "Escaped...",
			SEMBY_eval_money_laundering_clean = "All Clean",
			SEMBY_eval_money_laundering_dirty = "NOT CLEAN!!", --> 1/100
			SEMBY_eval_true_mystery_huh = "?", -- mystery unsolved
			SEMBY_eval_true_mystery_woa = "!", -- mystery solved
			SEMBY_eval_jevil_joker = "I CAN DO ANYTHING!!", -- Reference: Jevil from Deltarune
			SEMBY_eval_jevil_consumable = "A CHAOS, CHAOS!", -- Reference: Jevil from Deltarune
		}
    }
}
