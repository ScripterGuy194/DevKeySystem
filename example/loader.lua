-- Example Loader for DevKeySystem
-- Created by ScripterGuy194

local DevKeySystem = loadstring(game:HttpGet("https://raw.githubusercontent.com/ScripterGuy194/DevKeySystem/main/src/DevKeySystem.lua"))()

local keySystem = DevKeySystem.new()
keySystem:Init({
    Title = "Dev Key System",
    Description = "Enter your access key below.",
    Key = "abc123", -- Replace with your real key
    SaveKey = true,

    Verify = function(inputKey)
        return inputKey == "abc123"
    end,

    OnSuccess = function()
        print("✅ Key Correct!")
        -- Your logic here
        print("🔓 Access granted to protected features.")
        -- Add anything else you want to run after key success
    end,

    OnFail = function()
        print("❌ Key Failed!")
    end
})
