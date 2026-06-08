-- THX N'/nh6574: https://github.com/nh6574/JoyousSpring/blob/5ef54fa49bbb5a4450c78294fb7b2854134f5d44/src/others/Shaders.lua#L32
-- Official Wiki: https://github.com/Steamodded/smods/wiki/SMODS.CanvasSprite

-- Hardcoded Text: "Memory" Enhancement
local draw_memory = function(card, mem_suit)
    if not card["SEMBY_memory_canvas"] then
		card["SEMBY_memory_canvas"] = SMODS.CanvasSprite{ canvasScale = 2 }
	end
    local canvas = card["SEMBY_memory_canvas"]

	local update_suit = not canvas.cached_suit_text or canvas.cached_suit ~= mem_suit
	local update_memory = G.GAME.SEMBY_memory and G.GAME.SEMBY_memory[mem_suit] and canvas.cached_memory ~= G.GAME.SEMBY_memory[mem_suit]
	local update_mod = G.GAME.SEMBY_memory_mod and canvas.cached_mod ~= G.GAME.SEMBY_memory_mod or canvas.cached_mod and not G.GAME.SEMBY_memory_mod

	if update_suit or update_memory or update_mod then
	    love.graphics.push()
	    love.graphics.origin()

	    if update_suit then
			--print('suit')
	        canvas.cached_suit = mem_suit
	        canvas.cached_suit_text = love.graphics.newText(G.FONTS[1].FONT, {
				card.base.suit and G.C.SUITS[card.base.suit] or G.C.BLACK,
				card.base.suit and localize(card.base.suit, 'suits_plural') or localize('SEMBY_empty_memory')
			})
	    end

		if update_memory then
			--print('memory')
	    	canvas.cached_memory = G.GAME.SEMBY_memory[mem_suit]
	    	canvas.cached_memory_text = love.graphics.newText(G.FONTS[1].FONT, {
				G.C.CHIPS, -- MoarfBlue :3
				format_ui_value(canvas.cached_memory)
			})
		end

		if update_suit and not update_memory then
			--print('mem reset')
			canvas.cached_memory = nil
			canvas.cached_memory_text = nil
		end

		if update_mod then
			--print('mod')
	    	canvas.cached_mod = G.GAME.SEMBY_memory_mod
	    	canvas.cached_mod_text = canvas.cached_mod and love.graphics.newText(G.FONTS[1].FONT, {
				G.C.SEMBY_PERCENT,
				'x'..format_ui_value(canvas.cached_mod)
			}) or nil
		end

	    canvas.canvas:renderTo(
			function()
	        	love.graphics.clear(0, 0, 0, 0)
	        	if canvas.cached_suit_text then
	            	love.graphics.draw(canvas.cached_suit_text, 8 * canvas.canvasScale, 3.5 * canvas.canvasScale, 0, 0.08, 0.08)
	        	end
	        	if canvas.cached_memory_text then
					love.graphics.draw(canvas.cached_memory_text, 8 * canvas.canvasScale, 13 * canvas.canvasScale, 0, 0.08, 0.08)
	        	end
	        	if canvas.cached_mod_text then
					love.graphics.draw(canvas.cached_mod_text, 8 * canvas.canvasScale, 36.5 * canvas.canvasScale, 0, 0.08, 0.08)
	        	end
	    	end
		)

	    love.graphics.pop()
	end

    canvas.role.draw_major = card
    canvas:draw_shader('dissolve', nil, nil, nil, card.children.center)
end

-- Hardcoded Text: "Parking Disc" Joker
local draw_parking = function(card, text)
    if not card["SEMBY_parking_canvas"] then
		card["SEMBY_parking_canvas"] = SMODS.CanvasSprite{ canvasScale = 2 }
	end
    local canvas = card["SEMBY_parking_canvas"]

	if not canvas.cached_canvas or canvas.cached_text ~= text then
	    love.graphics.push()
	    love.graphics.origin()
		-- Cached Values
	    canvas.cached_text = text
	    canvas.cached_canvas = love.graphics.newText(G.FONTS[1].FONT, { HEX("4f6367"), canvas.cached_text }) --G.C.L_BLACK,
	    canvas.cached_outline = love.graphics.newText(G.FONTS[1].FONT, { HEX("ffffff"), canvas.cached_text }) --G.C.WHITE,
		-- Draw Cache
	    canvas.canvas:renderTo(
			function()
	        	love.graphics.clear(1, 1, 1, 0)
	        	if canvas.cached_canvas then
					-- Params.
					local pos_h = 36 * canvas.canvasScale
					local pos_v = 48.5 * canvas.canvasScale
					local tex_h = canvas.cached_canvas:getWidth() / 2
					local tex_v = canvas.cached_canvas:getHeight() / 2
					-- Outline
            		local offsets = { { 1, 1 }, { -1, 1 }, { 1, -1 }, { -1, -1 } }
            		for i = 1, 4 do
            		    local o = offsets[i]
            		    love.graphics.draw(canvas.cached_outline, pos_h + o[1], pos_v + o[2], 0, 0.16, 0.16, tex_h, tex_v)
            		end
					-- Text
	            	love.graphics.draw(canvas.cached_canvas, pos_h, pos_v, 0, 0.16, 0.16, tex_h, tex_v)
	        	end
	    	end
		)
	    love.graphics.pop()
	end

    canvas.role.draw_major = card
    canvas:draw_shader('dissolve', nil, nil, nil, card.children.center)
end

-- Semby Texts:
SMODS.DrawStep {
    key = 'SEMBY_TextGraphics',
    order = 25, --45,
    func = function(card, layer)
		if card and card.ability and card.ability.extra
		and type(card.ability.extra) == "table"
		and card.ability.extra.SEMBY_Graphics
		then -- Is a "SEMBY Graphic":
			if card.ability.extra.SEMBY_Graphics.Memory then
				draw_memory(card, card.base.suit or 'Empty')
			end
			if card.ability.extra.SEMBY_Graphics.Parking then
				draw_parking(card, card.ability.extra.SEMBY_Text or '?')
			end
		end
    end,
    conditions = { vortex = false, facing = 'front' },
}
