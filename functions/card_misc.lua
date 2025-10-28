--## SEMBY Card Misc. Functions

-- Set Soul Position
function Card:set_soul_pos(atlas, soul_pos)
    if atlas and soul_pos then
        self.children.floating_sprite = Sprite(self.T.x, self.T.y, self.T.w, self.T.h, G.ASSET_ATLAS[atlas], soul_pos)
        self.children.floating_sprite.role.draw_major = self
        self.children.floating_sprite.states.hover.can = false
        self.children.floating_sprite.states.click.can = false
	end
end

-- Set Dissolve-Visuals to a certian Value
function Card:set_dissolve(dissolve_colours, dissolve_from, dissolve_to, dissolve_time_fac)
	self.dissolve = (dissolve_from or 0)
	self.dissolve_colours = dissolve_colours or {G.C.BLACK, G.C.ORANGE, G.C.RED, G.C.GOLD, G.C.JOKER_GREY}
	G.E_MANAGER:add_event(Event({
		trigger = 'ease', blockable = false,
		ref_table = self, ref_value = 'dissolve',
		ease_to = (dissolve_to or 0.5), delay = 0.7 * (dissolve_time_fac or 1),
		func = (function(t) return t end)
	}))
end

-- Visual + Sound
function Card:start_revive()
    local dissolve_time = 0.7
    self.states.visible = true
    self.states.hover.can = false
    self.dissolve = 1
    self.dissolve_colours = {{1,1,1,0.8}}
    self:juice_up()
    self.children.particles = Particles(0, 0, 0,0, {
        timer_type = 'TOTAL',
        timer = 0.007*dissolve_time,
        scale = 0.3,
        speed = 4,
        lifespan = 0.5*dissolve_time,
        attach = self,
        colours = self.dissolve_colours,
        fill = true
    })
    if not G.last_materialized or G.last_materialized +0.01 < G.TIMERS.REAL or G.last_materialized > G.TIMERS.REAL then
        G.last_materialized = G.TIMERS.REAL
        G.E_MANAGER:add_event(Event({
            blockable = false,
            func = (function()
					play_sound('SEMBY_revive'..math.random(1, 6), math.random()*0.2 + 0.9, 0.5)
					play_sound('generic1', math.random()*0.2 + 0.9, 0.5)
                return true end)
        }))
    end
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        blockable = false,
        delay =  0.5*dissolve_time,
        func = (function() if self.children.particles then self.children.particles.max = 0 end return true end)
    }))
    G.E_MANAGER:add_event(Event({
        trigger = 'ease',
        blockable = false,
        ref_table = self,
        ref_value = 'dissolve',
        ease_to = 0,
        delay =  1*dissolve_time,
        func = (function(t) return t end)
    }))
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        blockable = false,
        delay =  1.05*dissolve_time,
        func = (function() self.states.hover.can = true; if self.children.particles then self.children.particles:remove(); self.children.particles = nil end return true end)
    }))
end
