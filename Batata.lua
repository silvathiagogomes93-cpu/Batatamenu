local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Parent = player.PlayerGui
gui.Name = "BatataMenu"

local toggleButton = Instance.new("ImageButton")
toggleButton.Size = UDim2.new(0, 50, 0, 50)
toggleButton.Position = UDim2.new(0, 20, 0, 20)
toggleButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.BackgroundTransparency = 0
toggleButton.Image = "rbxassetid://131870768883291"
toggleButton.Parent = gui
toggleButton.Active = true
toggleButton.Selectable = true

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = toggleButton

local batataGrande = Instance.new("ImageLabel")
batataGrande.Size = UDim2.new(0, 300, 0, 300)
batataGrande.Position = UDim2.new(0.5, -150, 0.5, -150)
batataGrande.BackgroundTransparency = 1
batataGrande.Image = "rbxassetid://131870768883291"
batataGrande.ScaleType = Enum.ScaleType.Fit
batataGrande.Visible = false
batataGrande.Parent = gui

local isVisible = false
local dragging = false
local dragStart = nil
local buttonStart = nil

toggleButton.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		buttonStart = toggleButton.Position
	end
end)

toggleButton.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		local delta = Vector2.new(input.Position.X - dragStart.X, input.Position.Y - dragStart.Y)
		toggleButton.Position = UDim2.new(
			buttonStart.X.Scale,
			buttonStart.X.Offset + delta.X,
			buttonStart.Y.Scale,
			buttonStart.Y.Offset + delta.Y
		)
	end
end)

toggleButton.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = false
	end
end)

toggleButton.MouseButton1Click:Connect(function()
	if not dragging then
		isVisible = not isVisible
		batataGrande.Visible = isVisible
	end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		local delta = Vector2.new(input.Position.X - dragStart.X, input.Position.Y - dragStart.Y)
		local newPosX = math.clamp(buttonStart.X.Offset + delta.X, 0, gui.AbsoluteSize.X - toggleButton.AbsoluteSize.X)
		local newPosY = math.clamp(buttonStart.Y.Offset + delta.Y, 0, gui.AbsoluteSize.Y - toggleButton.AbsoluteSize.Y)
		
		toggleButton.Position = UDim2.new(
			buttonStart.X.Scale,
			newPosX,
			buttonStart.Y.Scale,
			newPosY
		)
	end
end)
