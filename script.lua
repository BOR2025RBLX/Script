-- Load Rayfield UI
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Tạo cửa sổ
local Window = Rayfield:CreateWindow({
    Name = "Hide and Seek Hack",
    LoadingTitle = "Hide and Seek Script",
    LoadingSubtitle = "By Chi",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "MyScripts",
        FileName = "HideAndSeekUI"
    },
    KeySystem = false
})

-- Tạo tab chính
local Tab = Window:CreateTab("Main", 4483362458)
Tab:CreateSection("Cheat Functions")

-- Nút Reload = 0
Tab:CreateButton({
    Name = "Instant Reload",
    Callback = function()
        -- Gửi remote reload
        game:GetService("ReplicatedStorage").Assets.Blaster.Remotes.Reload:FireServer()
    end
})

-- Nút Reveal ESP Hiders
Tab:CreateButton({
    Name = "Show Hider ESP",
    Callback = function()
        -- Gửi remote reveal hiders
        game:GetService("ReplicatedStorage").Network["PlayerMarkers/RevealHiders"]:FireServer()
    end
})
