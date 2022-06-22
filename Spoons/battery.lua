-- Battery Notifications
local battery = {}

local isCharged = hs.battery.isCharged()
local percentage = hs.battery.percentage()
local powerSource = hs.battery.powerSource()

local thresholds = {
    [20] = false,
    [15] = false,
    [10] = false,
    [5] = false,
}

local function notify(status, value)
    hs.notify.new({
        title = 'Battery',
        subTitle = status,
        informativeText = value,
        contentImage = battery.cfg.icon,
        hasActionButton = false,
        autoWithdraw = true,
    }):send()
end

local function batteryWatcher()
    local newIsCharged = hs.battery.isCharged()
    local newPercentage = hs.battery.percentage()
    local newPowerSource = hs.battery.powerSource()

    if newPercentage < 100 then
        isCharged = false
    end

    --Notify Fully Charged
    if newIsCharged ~= isCharged
        and newPercentage == 100
        and newPowerSource == 'AC Power'
    then
        notify('Fully Charged.')
        isCharged = newIsCharged
    end
    
    --Notify New Powersource
    if newPowerSource ~= powerSource then 
        notify('New Power Source:', newPowerSource)
        powerSource = newPowerSource
    end

    --Notify Thresholds Less Than or Equal To with Time Remaining
    for threshold, notified in pairs(thresholds) do
        if newPercentage > threshold then 
            -- reset
            thresholds[threshold] = false
        elseif not notified then 
            -- under threshold lets notify
            thresholds[threshold] = true
            notify('Time Remaining: ', hs.battery.timeRemaining())
        end
    end

end

function battery.start()
    battery.watcher = hs.battery.watcher.new(batteryWatcher)
    battery.watcher:start()
end

function battery.stop()
    battery.watcher:stop()
    battery.watcher = nil
end

return battery