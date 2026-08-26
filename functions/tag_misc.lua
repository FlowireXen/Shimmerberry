--## SEMBY Tag Misc. Functions

-- "Tag:yep()" for Tag-Durability
function Tag:SEMBY_Yap(yap_text, yap_colour, yap_function)
    stop_use()

    local uses = self.ability.uses or (self.config.extra and self.config.extra.uses) or 3 --> Fallback
    yap_text = yap_text or tostring(uses)
    self.ability.uses = uses - 1
    self.ability.used_up = self.ability.used_up or self.ability.uses <= 0

    G.E_MANAGER:add_event(Event({
        delay = 0.4,
        trigger = 'after',
        func = function()
            attention_text({
                text = yap_text,
                colour = G.C.WHITE,
                scale = 1, 
                hold = 0.3/G.SETTINGS.GAMESPEED,
                cover = self.HUD_tag,
                cover_colour = yap_colour or G.C.GREEN,
                align = 'cm',
            })
            play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
            play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
            return true
        end
    }))

    if self.ability.used_up then
        G.E_MANAGER:add_event(Event({
            func = (function()
                self.HUD_tag.states.visible = false
                return true
            end)
        }))
    end
    G.E_MANAGER:add_event(Event({
        func = yap_function
    }))

    self.triggered = true
    if self.ability.used_up then
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.7,
            func = (function()
                self:remove()
                return true
            end)
        }))
    else
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.7,
            func = function()
                self.triggered = false
                return true
            end
        }))
    end
end
