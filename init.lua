
local LOGLEVEL = 'debug'

-- List of Spoons to Register
local spoons = {
    'caffeine',
    'battery',
    'grid',
}

-- Global HammerSpoon Namespace
hsm = {}

-- Load Cfg Spoon
local cfg = require('cfg')
hsm.cfg = cfg.global

-- Global Logger
hsm.log = hs.logger.new(hs.host.localizedName(), LOGLEVEL)


local function loadSpoonByName(spoonName)
    hsm[spoonName] = require('Spoons.' .. spoonName)
    hsm[spoonName].name = spoonName
    hsm[spoonName].log = hs.logger.new(spoonName, LOGLEVEL)
    hsm.log.i(hsm[spoonName].name .. ': spoon loaded')
end

local function cfgSpoon(spoon)
    spoon.cfg = spoon.cfg or {}
    if(cfg[spoon.name]) then 
        for k,v in pairs(cfg[spoon.name]) do spoon.cfg[k] = v end
        hsm.log.i(spoon.name .. ': spoon configured.')
    end
end

local function startSpoon(spoon) 
    if spoon.start == nil then return end
    spoon.start()
    hsm.log.i(spoon.name .. ': spoon started.')
end

local function stopSpoon(spoon) 
    if spoon.stop == nil then return end
    spoon.stop()
    hsm.log.i(spoon.name .. ': spoon stopped.')
end

-- Load, Configure, and Start all Spoons
hs.fnutils.each(spoons, loadSpoonByName);
hs.fnutils.each(hsm, cfgSpoon);
hs.fnutils.each(hsm, startSpoon);



-- Global Reload HS Configuration
function hammerSpoonReload() 
    hs.fnutils.each(hsm, stopSpoon)
    hs.reload()
end

-- Load and Configure Key Bindings
local bindings = require('bindings')
-- bindings.bind()


hs.alert.show('Hammerspoon Config Loaded', 1)
