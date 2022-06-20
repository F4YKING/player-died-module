local module = {}
module.__index = module

function module.new(plr)
	if not plr then
		warn("no plr on param")
		return
	end

	local playerDied = Instance.new("BindableEvent")

	local self = setmetatable({
		Died = playerDied.Event
	}, module)

	plr.CharacterAdded:Connect(function(char)
		char:WaitForChild("Humanoid").Died:Connect(function()
			playerDied:Fire()
		end)
	end)

	if plr.Character then
		local hum = plr.Character:FindFirstChild("Humanoid")
		if hum then
			hum.Died:Connect(function()
				playerDied:Fire(plr)
			end)
		end
	end

	return self
end


return module
