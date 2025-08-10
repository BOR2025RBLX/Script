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

task.spawn(function()
    while true do
        task.wait(0.05) -- delay nhỏ đủ để tránh lag
        if autoBuySeeds then
            for _, seed in ipairs(seeds) do
                if not autoBuySeeds then break end
                local bought = true
                while bought and autoBuySeeds do
                    -- Gửi request mua, nếu lỗi (giả định hết hàng) thì thôi
                    bought = safeBuy(BuySeedEvent, seed)
                    task.wait(0.05)
                end
            end
        else
            task.wait(0.2)
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(0.05)
        if autoBuyGear then
            for _, gear in ipairs(gears) do
                if not autoBuyGear then break end
                local bought = true
                while bought and autoBuyGear do
                    bought = safeBuy(BuyGearEvent, gear)
                    task.wait(0.05)
                end
            end
        else
            task.wait(0.2)
        end
    end
end)
