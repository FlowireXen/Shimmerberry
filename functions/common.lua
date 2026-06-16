--## SEMBY "Common" Events

-- Reset: Berry-Card Ranks
-- Berries are all equally tasty!~
local function SEMBY_reset_berry_ranks()
	-- Reset Variables
	G.GAME.current_round.SEMBY_berry_rank_one = { rank = 'King', id = 13 }
	G.GAME.current_round.SEMBY_berry_rank_two = { rank = 'Queen', id = 12 }

	-- Get All Valid Cards for Rank One
	local valid_berry_cards_one = {}
	for _, playing_card in ipairs(G.playing_cards) do
		if not SMODS.has_no_rank(playing_card) then
			valid_berry_cards_one[#valid_berry_cards_one + 1] = playing_card
		end
	end
	-- Determine Rank One
	local berry_rank_one = pseudorandom_element(valid_berry_cards_one, pseudoseed('SEMBY_berry_rank_one'))
	if berry_rank_one then
		G.GAME.current_round.SEMBY_berry_rank_one.rank = berry_rank_one.base.value
		G.GAME.current_round.SEMBY_berry_rank_one.id = berry_rank_one.base.id
	else
		return -- nothing valid found => abort!
	end

	-- Get All Valid Cards for Rank Two
	local valid_berry_cards_two = {}
	for i = 1, #valid_berry_cards_one do
		if not (valid_berry_cards_one[i].base.id == berry_rank_one.base.id) then
			valid_berry_cards_two[#valid_berry_cards_two + 1] = valid_berry_cards_one[i]
		end
	end
	-- Determine Rank Two
	local berry_rank_two = pseudorandom_element(valid_berry_cards_two, pseudoseed('SEMBY_berry_rank_two'))
	if berry_rank_two then
		-- Rank Two has it's own Number
		G.GAME.current_round.SEMBY_berry_rank_two.rank = berry_rank_two.base.value
		G.GAME.current_round.SEMBY_berry_rank_two.id = berry_rank_two.base.id
	else
		-- Rank Two and One are the same
		G.GAME.current_round.SEMBY_berry_rank_two.rank = berry_rank_one.base.value
		G.GAME.current_round.SEMBY_berry_rank_two.id = berry_rank_one.base.id
	end
end

-- Reset: Tool-Card Ranks
-- Tools are all useful >:3c
local function SEMBY_reset_tool_suit()
	G.GAME.current_round.SEMBY_tool_suit = { suit = 'Spades' }
    local valid_tool_cards = {}
    for _, playing_card in ipairs(G.playing_cards) do
        if not SMODS.has_no_suit(playing_card) then
            valid_tool_cards[#valid_tool_cards + 1] = playing_card
        end
    end
    local tool_card = pseudorandom_element(valid_tool_cards, 'SEMBY_tool_suit')
    if tool_card then
        G.GAME.current_round.SEMBY_tool_suit.suit = tool_card.base.suit
    end
end

-- Game Start and Reset Call
function SMODS.current_mod.reset_game_globals(run_start)
	if run_start then
		if G.GAME.challenge then
			SEMBY_Challenge_Generic()
			SEMBY_Challenge_Vanilla()
		end
		G.GAME.SEMBY_memory = { Buffer = {} }
		SEMBY_Global_BlindMod_Calculate()
		SEMBY_Global_ShopMod_Calculate()
		if SEMBY_Eden_Valid() then
			G.GAME.SEMBY_eden_checksum = Shimmerberry.config.eden_checksum
			if Shimmerberry.config.eden_infinite or SEMBY_Eden_Token() > 0 then
				G.E_MANAGER:add_event(Event({
					func = function()
						SMODS.add_card({
							set = 'Spectral', area = G.jokers,
							key = 'c_SEMBY_eden_spawner'
						})
						return true
					end
				}))
			end
		end
	end
    SEMBY_reset_berry_ranks()
	SEMBY_reset_tool_suit()
	G.GAME.current_round.SEMBY_shop_reroll = nil
	if G.GAME.current_round.SEMBY_shop_size and G.GAME.current_round.SEMBY_shop_size ~= 0 then
        change_shop_size(-G.GAME.current_round.SEMBY_shop_size)
		G.GAME.current_round.SEMBY_shop_size = 0
	end
end

-- Global Calculate Functions
SMODS.current_mod.calculate = function(self, context)
    if context.before then
		G.GAME.SEMBY_suit_count = context.scoring_hand and SEMBY_count_suits(context.scoring_hand) or 0
		if context.scoring_name and G.GAME.hands[context.scoring_name] then
			-- Get Highest Hand Level
			G.GAME.SEMBY_vintage_level = next(G.GAME.hands).level or 1
			local eqbalance = 0
        	for handname, _ in pairs(G.GAME.hands) do
				eqbalance = eqbalance ~= 0 and (eqbalance + G.GAME.hands[handname].level)/2 or G.GAME.hands[handname].level
        	    if SMODS.is_poker_hand_visible(handname) and G.GAME.hands[handname].level > G.GAME.SEMBY_vintage_level then
					G.GAME.SEMBY_vintage_level = G.GAME.hands[handname].level
				end
        	end
			-- All Levels are the same; Allow Vintage
			if G.GAME.SEMBY_vintage_level == eqbalance then
				G.GAME.SEMBY_vintage_level = G.GAME.SEMBY_vintage_level + 1
			end
		end
		return
    end
    if context.after then
		G.GAME.SEMBY_suit_count = nil
		G.GAME.SEMBY_vintage_level = nil
		if SMODS.last_hand_oneshot then
			G.GAME.SEMBY_any_hand_oneshot = true
		end
		return
    end
	if context.end_of_round and context.main_eval and SEMBY_Eden_Valid() then
		Shimmerberry.config.eden_checksum = math.random()
		G.GAME.SEMBY_eden_checksum = Shimmerberry.config.eden_checksum
	end
    if context.starting_shop then
		G.GAME.SEMBY_shop_active = true
		return
    end
	if context.ending_shop then
		G.GAME.SEMBY_shop_active = false
		return
    end
	if context.card_added and G.GAME.tags and next(G.GAME.tags) and context.card.ability.set == "Joker" and not context.card.SEMBY_duplitage then
		G.E_MANAGER:add_event(Event({
			func = function()
				local slots_used = 1 + (context.card.ability.extra_slots_used or 0) - (context.card.ability.card_limit or 0)
				G.GAME.joker_buffer = (G.GAME.joker_buffer or 0) --+ slots_used
				for key, tag in ipairs(G.GAME.tags) do
					if tag.key == "tag_SEMBY_adt_duplitage" then
						if #G.jokers.cards + G.GAME.joker_buffer + slots_used <= G.jokers.config.card_limit then
							G.GAME.joker_buffer = G.GAME.joker_buffer + slots_used
        		    		tag:yep('+', G.C.L_BLACK)
							G.E_MANAGER:add_event(Event({
								func = function()
									local copied_card = copy_card(context.card)
									copied_card.SEMBY_duplitage = true
									copied_card:add_to_deck()
									G.jokers:emplace(copied_card)
									copied_card:start_materialize()
									G.E_MANAGER:add_event(Event({
										func = function()
											copied_card.SEMBY_duplitage = nil
											return true
										end
									}))
									return true
								end
							}))
						end
					end
				end
				G.GAME.joker_buffer = 0
				return true
			end
		}))
		return
    end
end
