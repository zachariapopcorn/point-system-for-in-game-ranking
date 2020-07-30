local dbService = game:GetService('DataStoreService')
local pointDb = dbService:GetDataStore("points")

game.Players.PlayerAdded:Connect(function(plr)
	local plrId = plr.UserId
	local amountOfPointsUserHas
	local success, err = pcall(function()
		amountOfPointsUserHas = pointDb:GetAsync(plrId .. '-points')
	end)
	if(err) then
		warn(plr.Name .. "'s points couldn't load! Here's the error message: " .. err)
	end
	local leaderstats = Instance.new("Folder", plr)
	leaderstats.Name = "leaderstats"
	local points = Instance.new("IntValue", leaderstats)
	points.Name = "Points"
	points.Value = amountOfPointsUserHas
end)

game.Players.PlayerRemoving:Connect(function(plr)
	local plrId = plr.UserId
	local amountOfPointsUserHas = plr.leaderstats.Points.Value
	local success, err = pcall(function()
		pointDb:SetAsync(plrId .. '-points', amountOfPointsUserHas)
	end)
	if(err) then
		warn(plr.Name .. "'s points couldn't save! Here's the error message: " .. err)
	end
end)
