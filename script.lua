local OrionLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/jensonhirst/Orion/main/source'))()

local Window = OrionLib:MakeWindow({
    Name = "Grow A Garden Auto Buy",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "AutoBuyConfig"
})

local Tab = Window:MakeTab({
    Name = "Shop",
    Icon = "rbxassetid://4483362458",
    PremiumOnly = false
})

Tab:AddSection({
    Name = "Auto Buy Settings"
})

local seeds = {
    "Carrot", "Strawberry", "Blueberry", "Orange Tulip", "Tomato", "Corn",
    "Daffodil", "Watermelon", "Pumpkin", "Apple", "Bamboo", "Coconut",
    "Cactus", "Dragonfruit", "Mango", "Grape", "Mushroom", "Pepper",
    "Cacao", "Beanstalk", "Ember Lily", "Sugar Apple", "Burning Bud",
    "Giant Pinecone", "Elder Strawberry"
}

local gears = {
    "Watering Can", "Trading Ticket", "Trowel", "Recall Wrench",
    "Basic Sprinkler", "Advanced Sprinkler", "Medium Toy", "Medium Treat",
    "Godly Sprinkler", "Magnifying Glass", "Master Sprinkler", "Cleaning Spray",
    "Favourite Tool", "Harvest Tool", "Friendship Pot", "Grandmaster Sprinkler",
    "Levelup Lolipop"
}

-- Toggle tự động mua seed
local autoBuySeedsToggle = Tab:AddToggle({
    Name = "Tự động mua tất cả hạt giống",
    Default = false,
    Save = true,
    Flag = "AutoBuySeeds",
    Callback = function(value)
        -- Nếu muốn, có thể thêm xử lý khi bật/tắt toggle
    end
})

-- Toggle tự động mua gear
local autoBuyGearsToggle = Tab:AddToggle({
    Name = "Tự động mua tất cả gear",
    Default = false,
    Save = true,
    Flag = "AutoBuyGears",
    Callback = function(value)
        -- Nếu muốn, có thể thêm xử lý khi bật/tắt toggle
    end
})

-- Hàm an toàn gọi event mua
local function safeBuy(eventName, itemName)
    local success, err = pcall(function()
        local event = game:GetService("ReplicatedStorage").GameEvents:FindFirstChild(eventName)
        if event then
            event:FireServer(itemName)
        else
            warn("[AutoBuy] Không tìm thấy event "..eventName)
        end
    end)
    if not success then
        warn("[AutoBuy] Lỗi khi mua "..itemName..": "..tostring(err))
    end
end

-- Task chạy nền auto mua seed
task.spawn(function()
    while task.wait(0.5) do
        if OrionLib.Flags["AutoBuySeeds"].Value then
            for _, seed in ipairs(seeds) do
                if not OrionLib.Flags["AutoBuySeeds"].Value then break end
                for i = 1, 10 do -- mua 10 lần mỗi seed tránh spam quá nhiều
                    if not OrionLib.Flags["AutoBuySeeds"].Value then break end
                    safeBuy("BuySeedStock", seed)
                    task.wait(0.1)
                end
            end
        else
            task.wait(1)
        end
    end
end)

-- Task chạy nền auto mua gear
task.spawn(function()
    while task.wait(0.5) do
        if OrionLib.Flags["AutoBuyGears"].Value then
            for _, gear in ipairs(gears) do
                if not OrionLib.Flags["AutoBuyGears"].Value then break end
                for i = 1, 10 do -- mua 10 lần mỗi gear
                    if not OrionLib.Flags["AutoBuyGears"].Value then break end
                    safeBuy("BuyGearStock", gear)
                    task.wait(0.1)
                end
            end
        else
            task.wait(1)
        end
    end
end)

OrionLib:Init()
