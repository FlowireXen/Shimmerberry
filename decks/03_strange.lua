SMODS.Back{
	key = "strange",
	name = "SEMBY_strange",
	atlas = "SEMBY_decks",
	pos = { x = 1, y = 0 },
	config = {
		extra = {
			suits = 6,			-- starting deck: "possible suits"
			ranks = 20,			-- starting deck: "possible ranks"
			desc_min = -2,		-- desc. precentage min.
			desc_max = 102		-- desc. precentage max.
		}
	},
    loc_vars = function(self, info_queue, card)
		--SEMBY_Queue_Artist(back, info_queue)
		return {
			-- TODO: Have a changing Value like "Misprint" in V3.0
			vars = { 
				math.random(self.config.extra.desc_min, self.config.extra.desc_max),
				math.random(1, 5) == 1 and '#' or '%',
				colours = {
					math.random(1, 6) == 1 and G.C.BLUE or math.random(1, 6) == 1 and G.C.RED or G.C.ORANGE,
					math.random(1, 6) == 1 and G.C.BLUE or math.random(1, 6) == 1 and G.C.ORANGE or G.C.L_BLACK
				}
			}
		}
    end,
    apply = function(self)
		-- Create a heavily Biased Starting-Deck:
        G.E_MANAGER:add_event(Event({
            func = function()
				-- Seed
				local seed = (G.GAME.pseudorandom.seed or G.SEED)
				-- Limited Sets
				local suits = {}
				for i = 1, self.config.extra.suits do
					suits[#suits+1] = pseudorandom_element(SMODS.Suits, pseudorandom(seed)).key
				end
				local ranks = {}
				for i = 1, self.config.extra.ranks do
					ranks[#ranks+1] = pseudorandom_element(SMODS.Ranks, pseudorandom(seed)).key
				end
				-- Change Deck
				for i = #G.playing_cards, 1, -1 do
					local suit_choice = pseudorandom_element(suits, pseudorandom(seed))
					local rank_choice = pseudorandom_element(ranks, pseudorandom(seed))
					assert(SMODS.change_base( G.playing_cards[i], suit_choice, rank_choice ))
				end
                return true
            end
        }))
    end,
	calculate = function(self, back, context)
		if context.individual and context.cardarea == G.play then
			-- Randomize Played Card:
			local strange_card = context.other_card
			G.E_MANAGER:add_event(Event({
				func = function()
					strange_card:flip()
					return true
				end
			}))
			--delay(0.1)
			G.E_MANAGER:add_event(Event({
				func = function()
					strange_card:juice_up()
					play_sound('card1', math.random() + 0.8, 0.5)
					local suit_choice = pseudorandom_element(SMODS.Suits, (G.GAME.pseudorandom.seed or G.SEED)).key
					local rank_choice = pseudorandom_element(SMODS.Ranks, (G.GAME.pseudorandom.seed or G.SEED)).key
					assert(SMODS.change_base( strange_card, suit_choice, rank_choice ))
					strange_card:flip()
					return true
				end
			}))
			return nil, true
		end
    end,
	unlocked = false,
	unlock_condition = {type = 'win_deck', deck = 'b_erratic'},
}
