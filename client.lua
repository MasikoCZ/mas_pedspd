ESX = nil
local AskPedText = nil
local fov_max = 200.0
local fov_min = 5.0
local fov = (fov_max+fov_min)*0.5
local FadeIn = 300
local FadeOut = 800
local cam = nil
local wasTalked = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

Citizen.CreateThread(function()
    
    local pedmodel = GetHashKey(Config.Ped.Pedmodel)
	RequestModel(pedmodel)
	while not HasModelLoaded(pedmodel) do
		Citizen.Wait(1)
	end

	for i, v in ipairs(Config.PedPos) do
		ped = CreatePed(1, pedmodel, v.x, v.y, v.z - 1.0, v.h, false, true)
		SetBlockingOfNonTemporaryEvents(ped, true)
		SetPedDiesWhenInjured(ped, false)
		SetPedCanPlayAmbientAnims(ped, true)
		SetPedCanRagdollFromPlayerImpact(ped, false)
		SetEntityInvincible(ped, true)
		FreezeEntityPosition(ped, true)
	end
end)
-------------------TALKPED-------------------
Citizen.CreateThread(function()

	local pedmodel = GetHashKey(Config.Ped.Pedmodel)
	RequestModel(pedmodel)
	while not HasModelLoaded(pedmodel) do
		Citizen.Wait(1)
	end	
	ped = CreatePed(1, pedmodel, Config.Ped.Pos.x, Config.Ped.Pos.y, Config.Ped.Pos.z - 1.0, Config.Ped.Pos.h, false, true)
	SetBlockingOfNonTemporaryEvents(ped, true)
	SetPedDiesWhenInjured(ped, false)
	SetPedCanPlayAmbientAnims(ped, true)
	SetPedCanRagdollFromPlayerImpact(ped, false)
	SetEntityInvincible(ped, true)
	FreezeEntityPosition(ped, true)
    PedGuardAnim()

    AskPedText = Config.Ped.AskPedText
    while true do

    local sleep = 500
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)

            if (#(coords - vector3(Config.Ped.Pos.x, Config.Ped.Pos.y, Config.Ped.Pos.z)) < 2.0) then
				sleep = 5
				if not wasTalked then
					ShowFloatingHelpNotification(Lang['talk_pd'], vector3(Config.Ped.Pos.x, Config.Ped.Pos.y, Config.Ped.Pos.z + 0.9))
					if IsControlJustReleased(0, Keys["E"]) then
						DoScreenFadeOut(FadeOut)
						Citizen.Wait(FadeOut)
						wasTalked = true
						cam = CreateCam("DEFAULT_SCRIPTED_FLY_CAMERA", true)
						AttachCamToEntity(cam, ped, 0.0, 0.0, 0.5, true)
						SetCamRot(cam, 0.0, 0.0, GetEntityHeading(ped))
						SetCamFov(cam, fov)
						RenderScriptCams(true, false, 0, 1, 0)
						FreezeEntityPosition(ped, true)
						Citizen.Wait(FadeIn)
						DoScreenFadeIn(FadeIn)
					end
				elseif wasTalked then
					DrawText3Ds(Config.Ped.Pos.x, Config.Ped.Pos.y, Config.Ped.Pos.z + 0.95, 'PD:')
					DrawText3Ds(Config.Ped.Pos.x, Config.Ped.Pos.y, Config.Ped.Pos.z + 0.90, AskPedText.text)
					DrawText2Ds(0.5, 0.88, AskPedText.ChooseText, 0.35)
					if IsControlJustReleased(0, Keys["E"]) then
						TriggerServerEvent('mas_pedspd:alertPd')
						DoScreenFadeOut(FadeOut)
						Citizen.Wait(FadeOut)
						ClearPedTasks(ped)
						PedGuardAnim()
						RenderScriptCams(false, false, 0, 1, 0)
						FreezeEntityPosition(ped, false)
						Citizen.Wait(FadeIn)
						DoScreenFadeIn(FadeIn)
						wasTalked = false
					elseif IsControlJustReleased(0, Keys["G"]) then
						DoScreenFadeOut(FadeOut)
						Citizen.Wait(FadeOut)
						ClearPedTasks(ped)
						PedGuardAnim()
						wasTalked = false
						RenderScriptCams(false, false, 0, 1, 0)
						FreezeEntityPosition(ped, false)
						Citizen.Wait(FadeIn)
						DoScreenFadeIn(FadeIn)
					end
				end
			end
        Citizen.Wait(sleep)
    end
end)


---------

function PedGuardAnim()
    RequestAnimDict("amb@world_human_stand_guard@male@idle_a")
    while (not HasAnimDictLoaded("amb@world_human_stand_guard@male@idle_a")) do
        Citizen.Wait(7)
    end
    TaskPlayAnim(ped, 'amb@world_human_stand_guard@male@idle_a', 'idle_a', 8.0, -8.0, -1, 2, 0, false, false, false)
end

function ShowFloatingHelpNotification(msg, coords)
	AddTextEntry('esxFloatingHelpNotification', msg)
	SetFloatingHelpTextWorldPosition(1, coords)
	SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
	BeginTextCommandDisplayHelp('esxFloatingHelpNotification')
	EndTextCommandDisplayHelp(2, false, false, -1)
end

function DrawText2Ds(x, y, text, scale)
    SetTextFont(4)
    SetTextProportional(7)
    SetTextScale(scale, scale)
    SetTextColour(255, 255, 255, 255)
    SetTextDropShadow(0.0, 0.0, 0.0, 0.0, 255)
    SetTextDropShadow()
    SetTextEdge(4, 0, 0, 0, 255)
    SetTextOutline()
	SetTextCentre(true)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end

function DrawText3Ds(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.025+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

RegisterNetEvent('mas_pedspd:pdNotifyCD')
AddEventHandler('mas_pedspd:pdNotifyCD', function()

	local data = exports['cd_dispatch']:GetPlayerInfo()
	TriggerServerEvent('cd_dispatch:AddNotification', {
		job_table = {'police'}, 
		coords = data.coords,
		title = 'Recepce',
		message = data.sex.. Lang['message'] ..data.street, 
		flash = 0,
		unique_id = tostring(math.random(0000000,9999999)),
		blip = {
			sprite = 480, 
			scale = 0.7, 
			colour = 2,
			flashes = false, 
			text = 'Recepce',
			time = (5*60*1000),
			sound = 1,
		}
	})
end)

RegisterNetEvent('mas_pedspd:pdNotify')
AddEventHandler('mas_pedspd:pdNotify', function()
	PlaySoundFrontend(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", 0)
	ESX.ShowAdvancedNotification("911 Dispatch", "Carthief", 'Carthief start run with car', 'CHAR_CALL911', 7)
	PlaySoundFrontend(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", 0)
end)
