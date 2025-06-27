local DevKeySystem = loadstring(game:HttpGet("https://raw.githubusercontent.com/YourUsername/DevKeySystem/main/src/DevKeySystem.lua"))()
local ks = DevKeySystem.new()

ks:Init({
    Title = "Dev Key System",
    Description = "Paste your developer key",
    Key = "MY-SECRET-KEY",
    SaveKey = true,
    Verify = function(input)
        return input == "MY-SECRET-KEY"
    end
})
