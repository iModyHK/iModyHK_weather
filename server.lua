local votes = {}

RegisterServerEvent('startNewVote')
AddEventHandler('startNewVote', function()
    TriggerClientEvent('chat:addMessage', -1, { args = { '^2' .. Config.ChatUserName, Config.Messages.NewVoteOpened } })
    TriggerClientEvent('startVoting', -1)
end)

RegisterServerEvent('voteWeather')
AddEventHandler('voteWeather', function(weather)
    local _source = source
    if not votes[weather] then
        votes[weather] = 0
    end
    votes[weather] = votes[weather] + 1
    TriggerClientEvent('chat:addMessage', -1, { args = { '^2' .. Config.ChatUserName, Config.Messages.VoteRegistered .. weather } })
    TriggerClientEvent('updateVotes', -1, votes)
end)

RegisterServerEvent('endVoting')
AddEventHandler('endVoting', function()
    local maxVotes = 0
    local winningWeather = nil

    for weather, count in pairs(votes) do
        if count > maxVotes then
            maxVotes = count
            winningWeather = weather
        end
    end

    if winningWeather then
        TriggerClientEvent('updateWeather', -1, winningWeather)
        TriggerClientEvent('chat:addMessage', -1, { args = { '^2' .. Config.ChatUserName, Config.Messages.VotingEnded .. winningWeather } })
        votes = {} -- Reset votes after changing weather
        TriggerClientEvent('updateVotes', -1, votes)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(60000) -- Check every minute
        TriggerClientEvent('startVoting', -1)
        Citizen.Wait(Config.CooldownTime * 1000) -- Wait for cooldown time before starting a new vote
    end
end)