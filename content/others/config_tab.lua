--## SEMBY Config/Options

SMODS.current_mod.config_tab = function()
	local profile = 'P'..G.SETTINGS.profile
	Shimmerberry.config.eden_tokens[profile] = SEMBY_tonum(Shimmerberry.config.eden_tokens[profile] or 0)
    -- Config UI
	return {n = G.UIT.ROOT, config = {
		align = "tm", minw = 4, minh = 2, padding = 0.2, r = 0.1, colour = G.C.GREY
	}, nodes = {
        --[[
		{n=G.UIT.R, config={ align = "cm" }, nodes={
            -- Other Options here!
		}},
        {n=G.UIT.R, config={minh=0.1}},
        {n=G.UIT.R, config={minh = 0.04, minw = 4.5, colour = G.C.L_BLACK}},
        --]]
		{n=G.UIT.R, nodes={
            {n=G.UIT.C, config={ padding = 0.1, align = "cm" }, nodes={
                create_toggle({
                    label = localize('SEMBY_eden_active'),
                    info = localize('SEMBY_eden_active_desc'),
                    ref_table = Shimmerberry.config, ref_value = 'eden_enabled',
                    active_colour = G.C.SEMBY, right = true, w = 2
                }),
		    }},
            {n=G.UIT.C, config={ padding = 0.1, align = "cm" }, nodes={
                {n=G.UIT.R, config={align = "cm"}, nodes={
                    {n=G.UIT.T, config={
                        text = localize('SEMBY_eden_amount')..' ('..profile..'):',
                        scale = 0.4, colour = G.C.UI.TEXT_LIGHT
                    }},
                }},
                {n=G.UIT.R, config={align = "cm"}, nodes={
                    create_text_input({
                        max_length = 9,
                        SEMBY_num_only = true,
                        ref_table = Shimmerberry.config.eden_tokens, ref_value = profile,
                        prompt_text = localize('SEMBY_enter_number'),
                        colour = G.C.SEMBY,
                    }),
                }},
                {n=G.UIT.R, config={align = "cm"}, nodes={
                    create_toggle({
                        label = localize('SEMBY_eden_infinite'),
                        ref_table = Shimmerberry.config, ref_value = 'eden_infinite',
                        active_colour = G.C.SEMBY, right = true, w = 2
                    }),
                }},
		    }},
		}},
	}}
end
