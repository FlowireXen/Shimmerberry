SMODS.Tag {
    key = "vouch_down",
	name = "SEMBY_vouch_down",
	atlas = "SEMBY_tags",
    min_ante = 2,
    pos = { x = 0, y = 0 },
    unlocked = true,
    discovered = false,
	config = {
		extra = {
			discount = 5
		}
	},
    loc_vars = function(self, info_queue, tag)
		--SEMBY_Queue_Artist(tag, info_queue)
        return { vars = {
			tag.config.extra.discount
		} }
    end,
    apply = function(self, tag, context)
        if context.type == 'shop_final_pass' and G.shop and G.shop_vouchers and G.shop_vouchers.cards and #G.shop_vouchers.cards > 0 then
			local valid_vouchers = {}
			for _, voucher in ipairs(G.shop_vouchers.cards) do
				if voucher.ability.SEMBY_price_prediction then
					if voucher.cost > voucher.ability.SEMBY_price_prediction then
						valid_vouchers[#valid_vouchers + 1] = voucher
					end
				else valid_vouchers[#valid_vouchers + 1] = voucher end
            end
			if #valid_vouchers > 0 then
				local voucher = pseudorandom_element(valid_vouchers, pseudoseed('SEMBY_vouch_down'))
				voucher.ability.SEMBY_price_prediction = (voucher.ability.SEMBY_price_prediction or 0) + tag.config.extra.discount
				tag:yep('+', G.C.SECONDARY_SET.Voucher, function()
					voucher.ability.SEMBY_price_mod = (voucher.ability.SEMBY_price_mod or 0) - tag.config.extra.discount
					voucher:set_cost()
					voucher:juice_up()
					return true
				end)
				tag.triggered = true
			end
            return true
        end
    end
}
