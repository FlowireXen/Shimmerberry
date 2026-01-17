--## SEMBY "Common" Events

-- Reset: Berry-Card Ranks
-- Berries are all equally tastie!~
local function reset_berry_ranks()
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
	for _, playing_card in ipairs(G.playing_cards) do
		if not SMODS.has_no_rank(playing_card) then
		    if not (playing_card.base.id == berry_rank_one.base.id) then
				valid_berry_cards_two[#valid_berry_cards_two + 1] = playing_card
			end
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
local function reset_tool_suit()
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

-- Calculate: Resonance
-- ··· · −·−· ·−· · − ···
local function calculate_resonance(run_start)
	if run_start then
		G.GAME.current_round.SEMBY_resonance = 0
	end
	for _, playing_card in ipairs(G.playing_cards) do
		if playing_card.edition and playing_card.edition.SEMBY_resonance then
			G.GAME.current_round.SEMBY_resonance = G.GAME.current_round.SEMBY_resonance + 1
		end
	end
	if G.GAME.current_round.SEMBY_resonance ~= 0 then
		local resonance_debt = Tag('tag_SEMBY_resonance_debt')
		resonance_debt.ability.resonance_percent = G.SEMBY.Resonance * G.GAME.current_round.SEMBY_resonance
		add_tag(resonance_debt)
        play_sound('highlight1', 1.2 + math.random() * 0.1, 0.5)
		G.GAME.current_round.SEMBY_resonance = 0
	end
end

-- Game Start and Reset Call
function SMODS.current_mod.reset_game_globals(run_start)
	if run_start then
		if G.P_CENTERS.m_glass.config.SEMBY_extra then
			G.P_CENTERS.m_glass.config.extra = G.P_CENTERS.m_glass.config.SEMBY_extra
			G.P_CENTERS.m_glass.config.SEMBY_extra = nil
		end
		if G.GAME.challenge then
			SEMBY_Challenge_Generic()
			SEMBY_Challenge_Vanilla()
		end
		G.GAME.SEMBY_blind_mod = (G.GAME.SEMBY_blind_mod or 1.0)
		G.GAME.SEMBY_shop_mod = (G.GAME.SEMBY_shop_mod or 1.0)
	end
	-- Every Round
    reset_berry_ranks()
	reset_tool_suit()
	calculate_resonance(run_start)
	-- Challenge Stuff
	if G.GAME.challenge then
		SEMBY_Challenge_Blind_Defeated()
	end
end
