SMODS.Challenge {
    key = 'SEMBY_emperor_calus',
    rules = {
        custom = {
            { id = 'SEMBY_emperor_calus' },
            { id = 'SEMBY_space' },
            { id = 'no_shop_jokers' },
        },
        modifiers = {
            { id = 'joker_slots', value = 4 },
            { id = 'dollars', value = -10 },
        }
    },
    restrictions = {
        banned_cards = {
            { id = 'c_wraith' },
            { id = 'c_ectoplasm' },
            { id = 'p_buffoon_normal_1', ids = { 'p_buffoon_normal_1', 'p_buffoon_normal_2', 'p_buffoon_jumbo_1', 'p_buffoon_mega_1' } },
        },
        banned_tags = {
            { id = 'tag_rare' },
            { id = 'tag_negative' },
            { id = 'tag_polychrome' },
            { id = 'tag_buffoon' },
            { id = 'tag_top_up' },
        },
    },
    jokers = {
        { id = 'j_SEMBY_opulent_skint', SEMBY_rental = true },
        { id = 'j_credit_card', edition = "SEMBY_shiny", SEMBY_perishable = true },
        { id = 'j_SEMBY_coupon', eternal = true },
    },
    consumeables = {
        { id = 'c_temperance' },
    },
    vouchers = {
        { id = 'v_hone' },
        { id = 'v_magic_trick' },
        { id = 'v_glow_up' },
        { id = 'v_illusion' },
    },
    deck = {
        type = 'Challenge Deck',
        cards = {
			{ s = 'S', r = 'K', e = 'm_gold' }, { s = 'H', r = 'K', e = 'm_gold' }, { s = 'C', r = 'K', e = 'm_gold' }, { s = 'D', r = 'K', e = 'm_gold' },
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
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			func = function()
                -- Discourage Skipping
			    local lavish_debt = Tag('tag_SEMBY_ngt_lavish')
			    lavish_debt.ability.lavish_percent = 1.0
                add_tag(lavish_debt)
                play_sound('highlight1', 1.2 + math.random() * 0.1, 0.5)
				return true
			end
		}))
	end,
    calculate = function(self, context)
        if context.starting_shop then
			local card = SMODS.add_voucher_to_shop('j_SEMBY_opulent_skint', false)
            card:add_sticker('rental', true)
        end
    end,
	button_colour = G.C.RED
}
