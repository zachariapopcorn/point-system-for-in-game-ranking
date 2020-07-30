-- Configuration Varibles --
local pointValueForPromote = 100
local groupId = 123;
local requiredRank = 255;
local server = 'URL'
local key = 'key'
-- Configuration Varibles --

-- Standard Variables --
local HttpService = game:GetService('HttpService')
-- Standard Variables --

-- Main Code --
while true do
	wait(30)
	print('Starting check...')
	local arr = {}
	for i, p in pairs(game.Players:GetPlayers()) do
		local data = {
			plrName = p.Name,
			pointValue = p.leaderstats.Points.Value
		}
		table.insert(arr, data)
	end
	for i, v in pairs(arr) do
		if(v.pointValue >= pointValueForPromote) then
			print('Sending promote request to server...')
			local plrName = v.plrName
			local plrObj = game.Players:FindFirstChild(plrName)
			local res
			local success, err = pcall(function()
				res = HttpService:GetAsync(server..'promote?user='..plrName..'&key='..key..'&author=SYSTEM')
			end)
			if(err) then
				warn("There was an error while trying to connect to the server! Here's the error message: " .. err)
			else
				print("Sent promote request! Here's the response from the server: " .. res)
			end
		end
	end
	print('Finished check!')
	wait(30)
end
-- Main Code --
