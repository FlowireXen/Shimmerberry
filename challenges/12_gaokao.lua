SMODS.Challenge {
    key = 'SEMBY_gaokao',
    rules = {
        custom = {
            { id = 'SEMBY_gaokao' },
            { id = 'SEMBY_space' },
            { id = 'SEMBY_impossible_blinds' },
        },
        modifiers = {
            { id = 'discards', value = 4 },
            { id = 'hand_size', value = 12 },
            { id = 'winning_ante', value = 6 },
        }
    },
    restrictions = {
        banned_cards = {
			{ id = 'c_SEMBY_ocean' },
            --{ id = 'j_SEMBY_alpha' },
            { id = 'j_SEMBY_anodized_steel' },
            { id = 'j_SEMBY_berry_shimmer' },
            { id = 'j_SEMBY_ceaseless_void' },
            { id = 'j_SEMBY_lavish_joker' },
            { id = 'j_SEMBY_melon' },
            { id = 'j_SEMBY_obscure_ritual' },
            { id = 'j_SEMBY_ouroboros' },
            { id = 'j_SEMBY_seven_wonders' },
            { id = 'j_SEMBY_t3mprr' },
            { id = 'v_SEMBY_mask_comedy' },
            { id = 'v_SEMBY_mask_tragedy' },
        },
        banned_tags = {
            { id = 'tag_boss' },
            { id = 'tag_SEMBY_intimidating' },
            { id = 'tag_SEMBY_pearlescent_skip' },
        },
        banned_other = {
            { id = 'bl_needle', type = 'blind' },
            { id = 'bl_water', type = 'blind' },
            { id = 'bl_eye', type = 'blind' },
            { id = 'bl_mouth', type = 'blind' },
        },
    },
    jokers = {
        { id = 'j_SEMBY_jokebra', eternal = true },
    },
    consumeables = {
        { id = 'c_empress' },
        { id = 'c_heirophant' },
    },
    vouchers = {
        { id = 'v_blank' },
        { id = 'v_directors_cut' },
    },
    deck = {
        type = 'Challenge Deck',
        cards = {
			{ s = 'S', r = 'A' }, { s = 'H', r = 'A' }, { s = 'C', r = 'A' }, { s = 'D', r = 'A' },
            { s = 'S', r = 'T' }, { s = 'H', r = 'T' }, { s = 'C', r = 'T' }, { s = 'D', r = 'T' },
            { s = 'S', r = '9' }, { s = 'H', r = '9' }, { s = 'C', r = '9' }, { s = 'D', r = '9' },
            { s = 'S', r = '8' }, { s = 'H', r = '8' }, { s = 'C', r = '8' }, { s = 'D', r = '8' },
            { s = 'S', r = '7' }, { s = 'H', r = '7' }, { s = 'C', r = '7' }, { s = 'D', r = '7' },
            { s = 'S', r = '6' }, { s = 'H', r = '6' }, { s = 'C', r = '6' }, { s = 'D', r = '6' },
            { s = 'S', r = '5' }, { s = 'H', r = '5' }, { s = 'C', r = '5' }, { s = 'D', r = '5' },
            { s = 'S', r = '4' }, { s = 'H', r = '4' }, { s = 'C', r = '4' }, { s = 'D', r = '4' },
            { s = 'S', r = '3' }, { s = 'H', r = '3' }, { s = 'C', r = '3' }, { s = 'D', r = '3' },
            { s = 'S', r = '2' }, { s = 'H', r = '2' }, { s = 'C', r = '2' }, { s = 'D', r = '2' },
        }
    },
	apply = function(self)
		-- "No Requirement":
		G.GAME.starting_params.ante_scaling = (G.GAME.starting_params.ante_scaling or 1) * 10000 --math.huge
		-- Your final Exam:
		for key, value in pairs(G.P_BLINDS) do
			if value.boss and value.boss.showdown then
				if not (value.key == "bl_final_acorn") then
					G.GAME.banned_keys[value.key] = true
					--print(value.key)
				end
			end
		end
		-- Other Bans:
		G.GAME.banned_keys["e_SEMBY_pearlescent"] = true
	end,
	button_colour = G.C.BLUE
}
