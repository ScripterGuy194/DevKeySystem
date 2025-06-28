✅ README.md

# DevKeySystem 🔐
A simple, customizable Roblox Key System written entirely in Lua.  
Built by [ScripterGuy194](https://github.com/ScripterGuy194)

## 📦 Features
- Fully custom UI built with `Instance.new`
- SaveKey support via `writefile/readfile`
- Clipboard copying for key access
- OnSuccess and OnFail callbacks
- Custom ClassName: `DevKeySystem`
- No external libraries, purely Lua-based

## 🛠️ Setup

### 1. Loader Script
Place this in your executor or game loader:

```lua
local DevKeySystem = loadstring(game:HttpGet("https://raw.githubusercontent.com/ScripterGuy194/DevKeySystem/main/src/DevKeySystem.lua"))()

local keySystem = DevKeySystem.new()
keySystem:Init({
    Title = "Dev Key System",
    Description = "Enter your access key below.",
    Key = "abc123", -- Replace with your actual key
    SaveKey = true,

    Verify = function(inputKey)
        return inputKey == "abc123"
    end,

    OnSuccess = function()
        print("✅ Key Correct!")
        -- Your logic here
        print("🔓 Access granted to protected features.")
    end,

    OnFail = function()
        print("❌ Key Failed!")
    end
}) 
```

---

2. File Structure
```
DevKeySystem/
├── src/
│   └── DevKeySystem.lua     # Main source file (UI + logic)
├── example/
│   └── loader.lua           # Sample loader usage
└── README.md                # You're reading it!
```

---

📚 Documentation

Property	Description

Title	UI window title
Description	Message under the title
Key	The valid key string
SaveKey	Save key to local file using writefile
Verify	Function to validate the entered key
OnSuccess	Function to run if the key is correct
OnFail	Function to run if the key is wrong



---

💡 Credits

Inspired by the community and custom UI frameworks

Designed by ScripterGuy194

No dependencies, pure Lua
