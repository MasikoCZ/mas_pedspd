ESX = nil

local CooldownActive = false

RegisterNetEvent('mas_pedspd:alertPd')
AddEventHandler('mas_pedspd:alertPd', function()
    local _source = source

    if not CooldownActive then
        if Config.CDdispatch then
            TriggerClientEvent('mas_pedspd:pdNotifyCD', _source)
        else
            TriggerClientEvent('mas_pedspd:pdNotify', _source)
        end
        TriggerClientEvent('esx:showNotification', _source, Lang['ring'])
        CooldownTimer()
    else
        TriggerClientEvent('esx:showNotification', _source, Lang['already_ring'])
    end

end)

function CooldownTimer()
    timeLeft = 1
    CooldownActive = true
	
	while true do
		Citizen.Wait(Config.Timer * 1000)
		timeLeft = timeLeft - 1

        if timeLeft <= 0 then
            CooldownActive = false
			break
		end
	end
end