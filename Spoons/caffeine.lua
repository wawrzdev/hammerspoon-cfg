-- Replication of caffeine to keep computer awake
local caffeine = {}

-- Constants
local ID = 'caffeine'
local STATUS = {
    IDLE = 'displayIdle'
}

local menu = nil

--Enable Caffeine and Dis-allow Sleep
function caffeine.enable()
    hs.caffeinate.set(STATUS.IDLE, true)
    menu:setIcon(caffeine.cfg.icons.on)
end

--Disable Caffeine and Allow Sleep
function caffeine.disable()
    hs.caffeinate.set(STATUS.IDLE, false)
    menu:setIcon(caffeine.cfg.icons.off)
end

function caffeine.setState(state)
    if state then 
        caffeine.enable()
    else
        caffeine.disable()
    end
    return hs.caffeinate.get(STATUS.IDLE)
end

--Toggle State of Caffeine
function caffeine.toggle()
    local state = caffeine.setState(not hs.caffeinate.get(STATUS.IDLE))
    hs.alert.show(state and 'Caffeine ON' or 'Caffeine OFF', 1)
end

--Start Spoon
function caffeine.start()
    menu = hs.menubar.new()
  
    if menu then
      menu:setClickCallback(caffeine.toggle)
      caffeine.setState(false)
      --If we want to setup a timer and give notifications that caffiene is still active
      hs.notify.register(ID, onNotificationClick)
    end

end
  
--Stop Spoon
function caffeine.stop()
    if menu then menu:delete() end
    hs.caffeinate.set(K.IDLE, false)
    menu = nil
end


return caffeine