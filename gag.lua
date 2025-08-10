local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Grow A Garden v1714",
    LoadingTitle = "Grow A Garden Script",
    LoadingSubtitle = "By Chi",
    ConfigurationSaving = {
       Enabled = true,
       FolderName = "MyScripts",
       FileName = "MyUIConfig"
    },
    KeySystem = false
})

local Tab = Window:CreateTab("Shop", 4483362458)
Tab:CreateSection("Mua tất cả hạt giống")

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

local autoBuySeeds = false
local autoBuyGear = false

Tab:CreateToggle({
    Name = "Tự động mua tất cả hạt giống",
    CurrentValue = false,
    Flag = "AutoBuySeedsToggle",
    Callback = function(state)
        autoBuySeeds = state
    end
})

Tab:CreateSection("Mua tất cả gear")

Tab:CreateToggle({
    Name = "Tự động mua tất cả gear",
    CurrentValue = false,
    Flag = "AutoBuyGearToggle",
    Callback = function(state)
        autoBuyGear = state
    end
})

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BuySeedEvent = ReplicatedStorage.GameEvents:WaitForChild("BuySeedStock")
local BuyGearEvent = ReplicatedStorage.GameEvents:WaitForChild("BuyGearStock")

local function safeBuy(event, item)
    local success, err = pcall(function()
        event:FireServer(item)
    end)
    if not success then
        warn("[AutoBuy] Lỗi khi mua "..item..": "..tostring(err))
    end
    return success
end

-- Task mua seeds: mỗi loại 10 lần rồi sang loại khác, lặp lại từ đầu
task.spawn(function()
    while true do
        if autoBuySeeds then
            for _, seed in ipairs(seeds) do
                if not autoBuySeeds then break end
                local boughtCount = 0
                while boughtCount < 10 and autoBuySeeds do
                    local success = safeBuy(BuySeedEvent, seed)
                    if not success then
                        -- Nếu không mua được, tạm dừng để tránh spam
                        task.wait(0.5)
                    else
                        boughtCount = boughtCount + 1
                        task.wait(0.05)
                    end
                end
            end
        else
            task.wait(0.2)
        end
    end
end)

-- Task mua gear: mỗi loại 10 lần rồi sang loại khác, lặp lại từ đầu
task.spawn(function()
    while true do
        if autoBuyGear then
            for _, gear in ipairs(gears) do
                if not autoBuyGear then break end
                local boughtCount = 0
                while boughtCount < 10 and autoBuyGear do
                    local success = safeBuy(BuyGearEvent, gear)
                    if not success then
                        task.wait(0.5)
                    else
                        boughtCount = boughtCount + 1
                        task.wait(0.05)
                    end
                end
            end
        else
            task.wait(0.2)
        end
    end
end)
