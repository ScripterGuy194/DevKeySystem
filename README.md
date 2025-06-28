# 🔐 DevKeySystem

A customizable, class-based Roblox key system written entirely in Lua. Designed and maintained by [ScripterGuy194](https://github.com/ScripterGuy194). Inspired by OopssSorry, but built from scratch to be your own fully owned key system.

[![Join Our Discord](https://img.shields.io/badge/Join%20Discord-5865F2?style=for-the-badge&logo=discord&logoColor=white)](https://discord.gg/Pap524PMYs)

---

## 📁 Project Structure

```
DevKeySystem/
├── README.md                # This file
├── example/
│   └── loader.lua           # Sample loader using the key system
└── src/
    └── DevKeySystem.lua     # Full implementation of the DevKeySystem class
```

---

✨ Features

✅ Class-based (DevKeySystem.new())

🖱️ Clean, draggable user interface

💾 Optional local key saving using writefile

🔐 Custom Verify, OnSuccess, and OnFail support

📋 Auto copy key to clipboard with setclipboard

🧠 Local file check with isfile / readfile

⚡ Load external scripts on success



---

| Setting       | Type       | Required | Description                                                      |
|---------------|------------|----------|------------------------------------------------------------------|
| Title         | string     | ✖        | Title displayed on the GUI                                       |
| Description   | string     | ✖        | Helper text shown under the title                                |
| Key           | string     | ✅       | The correct key the user must enter                              |
| SaveKey       | boolean    | ✖        | Whether to save the key to local file                            |
| Verify        | function   | ✖        | Custom function for key validation (`function(key): boolean`)    |
| OnSuccess     | function   | ✖        | Function to execute if key is valid                              |
| OnFail        | function   | ✖        | Function to run if the key is invalid                            |



---

🚀 How to Use

Put this in your loader (example/loader.lua):
```
local DevKeySystem = loadstring(game:HttpGet("https://raw.githubusercontent.com/ScripterGuy194/DevKeySystem/main/src/DevKeySystem.lua"))()

local system = DevKeySystem.new()
system:Init({
    Title = "Dev Key System",
    Description = "Enter your key to continue.",
    Key = "mysecretkey123",
    SaveKey = true,
    Verify = function(input)
        return input == "mysecretkey123"
    end,
    OnSuccess = function()
        print("✅ Access Granted!")
        loadstring(game:HttpGet("https://yourwebsite.com/protected.lua"))()
    end,
    OnFail = function()
        warn("❌ Invalid Key!")
    end
})
```

---

💡 Tips

🔁 To change keys, just update the Key value in your loader.

🗑️ To force re-entry, delete the saved .key file.

🔒 Your GUI will auto-close on success.



---

🧑‍💻 Credits

Created by ScripterGuy194
Inspired by OopssSorry


---

💬 Need Help?

Join our community on Discord:
