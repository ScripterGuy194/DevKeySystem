📄 README.md

# DevKeySystem 🔐

A fully custom Lua-based key system for Roblox, built entirely from scratch by **@ScripterGuy194**.  
Inspired by OopssSorry’s system — but 100% original, modular, and class-driven.

---

## 🧩 Features

- 🧱 Class-based system (`ClassName = "DevKeySystem"`)
- 🔑 Key verification with customizable logic
- 💾 Optional key saving using `writefile()` / `readfile()`
- 📋 Clipboard support (copies key link with one click)
- 🧰 Draggable GUI interface
- ⚡ Lightweight & self-contained

---

## 🚀 Usage

```lua
local DevKeySystem = loadstring(game:HttpGet("https://raw.githubusercontent.com/ScripterGuy194/DevKeySystem/main/src/DevKeySystem.lua"))()
local ks = DevKeySystem.new()

ks:Init({
    Title = "Dev Key System",
    Description = "Enter your developer key below.",
    Key = "MY-SECRET-KEY",
    SaveKey = true,
    Verify = function(k)
        return k == "MY-SECRET-KEY"
    end
})
```


---

📂 File Structure
```
DevKeySystem/
├── src/
│   └── DevKeySystem.lua       # The main module class
│
├── example/
│   └── loader.lua             # Usage example (copy-paste ready)
│
├── README.md                  # This file
└── LICENSE                    # MIT License (open source)
```

---

🔧 Properties & API

Property	Description

ClassName	Always "DevKeySystem"
SaveKey	Saves the key locally if enabled
KeyMatched	Becomes true once the key is verified
KeyBox	TextBox reference for input field



---

🧠 Tips

The key is stored as a .key file using the title as filename (e.g. devkeysystem.key)

Make sure your executor supports writefile, readfile, setclipboard, etc.

For extra security, obfuscate the loader or use external key fetching.



---

📜 License

This project is licensed under the MIT License.
You are free to modify, redistribute, and use this system with proper credit.


---

👤 Author

Made by @ScripterGuy194
Built with 💡 for Roblox developers and key-auth systems.
