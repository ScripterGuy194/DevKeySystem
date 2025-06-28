-- DevKeySystem.lua
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local HS = game:GetService("HttpService")

local setclipboard = setclipboard or writeclipboard or write_clipboard
local writefile = writefile or nil
local readfile = readfile or nil
local isfile = isfile or nil

local DevKeySystem = {}
DevKeySystem.__index = DevKeySystem

function DevKeySystem.new()
	local self = setmetatable({}, DevKeySystem)
	self.ClassName = "DevKeySystem"
	self.SaveKey = false
	self.KeyMatched = false
	self.KeyBox = nil
	self.Settings = {}
	self.ScreenGui = nil
	return self
end

local function MakeDraggable(topBar, frame)
	local dragging, dragInput, dragStart, startPos
	local function update(input)
		local delta = input.Position - dragStart
		local pos = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
		TweenService:Create(frame, TweenInfo.new(0.2), {Position = pos}):Play()
	end

	topBar.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			startPos = frame.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	topBar.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			dragInput = input
		end
	end)

	UIS.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)
end

function DevKeySystem:BuildUI()
	local gui = Instance.new("ScreenGui", Players.LocalPlayer:WaitForChild("PlayerGui"))
	gui.Name = "DevKeySystem"
	gui.ResetOnSpawn = false
	gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	self.ScreenGui = gui

	local main = Instance.new("Frame", gui)
	main.Size = UDim2.new(0, 400, 0, 220)
	main.Position = UDim2.new(0.5, -200, 0.5, -110)
	main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	main.BorderSizePixel = 0

	local title = Instance.new("TextLabel", main)
	title.Text = self.Settings.Title or "Dev Key System"
	title.Size = UDim2.new(1, 0, 0, 40)
	title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	title.TextColor3 = Color3.fromRGB(255, 255, 255)
	title.TextSize = 24
	title.Font = Enum.Font.SourceSansBold

	MakeDraggable(title, main)

	local desc = Instance.new("TextLabel", main)
	desc.Text = self.Settings.Description or "Enter your key below"
	desc.Position = UDim2.new(0, 0, 0, 45)
	desc.Size = UDim2.new(1, 0, 0, 40)
	desc.BackgroundTransparency = 1
	desc.TextColor3 = Color3.fromRGB(200, 200, 200)
	desc.TextSize = 18
	desc.Font = Enum.Font.SourceSans

	local keyBox = Instance.new("TextBox", main)
	keyBox.PlaceholderText = "Enter Key"
	keyBox.Position = UDim2.new(0.1, 0, 0.4, 0)
	keyBox.Size = UDim2.new(0.8, 0, 0, 40)
	keyBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	keyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
	keyBox.TextSize = 18
	keyBox.Font = Enum.Font.SourceSans
	self.KeyBox = keyBox

	local enterBtn = Instance.new("TextButton", main)
	enterBtn.Text = "Verify"
	enterBtn.Position = UDim2.new(0.1, 0, 0.65, 0)
	enterBtn.Size = UDim2.new(0.35, 0, 0, 40)
	enterBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
	enterBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
	enterBtn.Font = Enum.Font.SourceSansBold
	enterBtn.TextSize = 20

	local getBtn = Instance.new("TextButton", main)
	getBtn.Text = "Get Key"
	getBtn.Position = UDim2.new(0.55, 0, 0.65, 0)
	getBtn.Size = UDim2.new(0.35, 0, 0, 40)
	getBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
	getBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	getBtn.Font = Enum.Font.SourceSansBold
	getBtn.TextSize = 20

	enterBtn.MouseButton1Click:Connect(function()
		local inputKey = keyBox.Text
		local success, result = pcall(self.Settings.Verify or function() end, inputKey)
		if success and result then
			self.KeyMatched = true
			if self.SaveKey and writefile then
				local file = (self.Settings.Title or "devkey"):gsub("%s", ""):lower() .. ".key"
				writefile(file, inputKey)
			end
			if self.Settings.OnSuccess then
				pcall(self.Settings.OnSuccess)
			end
			self:Close()
		else
			if not success then
				game:GetService("StarterGui"):SetCore("SendNotification", {
					Title = "Error",
					Text = "Key verify crashed!",
					Duration = 5
				})
			end
			keyBox.Text = "Invalid Key!"
			if self.Settings.OnFail then
				pcall(self.Settings.OnFail)
			end
		end
	end)

	getBtn.MouseButton1Click:Connect(function()
		keyBox.Text = self.Settings.Key or ""
		if setclipboard then setclipboard(self.Settings.Key) end
	end)
end

function DevKeySystem:Close()
	if self.ScreenGui then
		self.ScreenGui:Destroy()
	end
end

function DevKeySystem:Init(settings)
	self.Settings = settings or {}
	self.SaveKey = settings.SaveKey or false
	self.KeyMatched = false

	if self.SaveKey and readfile and isfile then
		local filename = (self.Settings.Title or "devkey"):gsub("%s", ""):lower() .. ".key"
		if isfile(filename) then
			local savedKey = readfile(filename)
			if self.Settings.Verify and self.Settings.Verify(savedKey) then
				self.KeyMatched = true
				if self.Settings.OnSuccess then
					pcall(self.Settings.OnSuccess)
				end
				return true
			end
		end
	end

	self:BuildUI()
	repeat task.wait() until self.KeyMatched
	return true
end

return DevKeySystem
