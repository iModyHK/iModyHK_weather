local isOpen = false
local votes = {}
local votingTime = Config.VotingTime
local cooldownTime = Config.CooldownTime
local canVote = true
local voteInProgress = false

RegisterCommand('toggleWeatherVote', function()
    if voteInProgress then
        isOpen = not isOpen
        SetNuiFocus(isOpen, isOpen)
        SendNUIMessage({ action = isOpen and 'open' or 'close' })
        if isOpen then
            SendNUIMessage({ action = 'updateVotes', votes = votes })
        end
    elseif canVote then
        TriggerServerEvent('startNewVote')
    else
        TriggerEvent('chat:addMessage', { args = { '^1' .. Config.ChatUserName, 'Voting is currently on cooldown. Please wait.' } })
    end
end, false)

RegisterNUICallback('voteWeather', function(data, cb)
    local weather = data.weather
    TriggerServerEvent('voteWeather', weather)
    cb('ok')
end)

RegisterNetEvent('updateVotes')
AddEventHandler('updateVotes', function(serverVotes)
    votes = serverVotes
    if isOpen then
        SendNUIMessage({ action = 'updateVotes', votes = votes })
    end
end)

RegisterNetEvent('startVoting')
AddEventHandler('startVoting', function()
    voteInProgress = true
    canVote = false
    Citizen.CreateThread(function()
        local timeLeft = votingTime
        while timeLeft > 0 do
            Citizen.Wait(1000)
            timeLeft = timeLeft - 1
            SendNUIMessage({ action = 'updateTimer', timeLeft = timeLeft })
        end
        TriggerServerEvent('endVoting')
        voteInProgress = false
        Citizen.Wait(cooldownTime * 1000)
        canVote = true
    end)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlJustReleased(0, 168) then -- F7 key
            ExecuteCommand('toggleWeatherVote')
        end
    end
end)