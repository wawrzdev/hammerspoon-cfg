local bindings = {}

local hyper = {'F20'}

-- local pressedHyper = function() hyper:enter() end
-- local releasedHyper = function() hyper:exit() end

-- hs.hotkey.bind({}, 'F18', pressedHyper, releasedHyper)

function bindings.bind() 

    -- Binding Keys to App Activation
    hs.fnutils.each({
        {key = 'c',  app = 'Google Chrome'},
        {key = 'f',  app = 'Finder'},
        {key = 'm',  app = 'Messages'},
        {key = 's',  app = 'Spotify'},
        {key = 't',  app = 'iTerm'},
      }, function(item)
        local appActivation = function()
            hs.application.launchOrFocus(item.app)
            local app = hs.appfinder.appFromName(item.app)
            if app then
                app:activate()
                app:unhide()
            end
        end
        hs.hotkey.bind({'F20'}, item.key, appActivation)
    end)
    
    --Global Reload HS Config
    hs.hotkey.bind({'F20'}, 'R', function() 
        hammerSpoonReload()
    end
    )

    --Spoon Specific Keys
    hs.hotkey.bind({'F20'}, 'A', function()
        hsm.grid.show()
    end
    )

end

return bindings
