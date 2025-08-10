-- Load Rayfield Library
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Tạo Window
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

-- Tab Shop
local Tab = Window:CreateTab("Shop", 4483362458)
Tab:CreateSection("Mua tất cả hạt giống")

-- Danh sách seeds
local seeds = {
    "Carrot", "Strawberry", "Blueberry", "Orange Tulip", "Tomato", "Corn",
    "Daffodil", "Watermelon", "Pumpkin", "Apple", "Bamboo", "Coconut",
    "Cactus", "Dragonfruit", "Mango", "Grape", "Mushroom", "Pepper",
    "Cacao", "Beanstalk", "Ember Lily", "Sugar Apple", "Burning Bud",
    "Giant Pinecone", "Elder Strawberry"
}

-- Danh sách gear
local gears = {
    "Watering Can", "Trading Ticket", "Trowel", "Recall Wrench",
    "Basic Sprinkler", "Advanced Sprinkler", "Medium Toy", "Medium Treat",
    "Godly Sprinkler", "Magnifying Glass", "Master Sprinkler", "Cleaning Spray",
    "Favourite Tool", "Harvest Tool", "Friendship Pot", "Grandmaster Sprinkler",
    "Levelup Lolipop"
}

local autoBuySeeds = false
local autoBuyGear = false

-- Toggle auto mua tất cả hạt giống
Tab:CreateToggle({
    Name = "Tự động mua tất cả hạt giống",
    CurrentValue = false,
    Flag = "AutoBuySeedsToggle",
    Callback = function(state)
        autoBuySeeds = state
    end
})

-- Tạo section mới cho gear
Tab:CreateSection("Mua tất cả gear")

-- Toggle auto mua tất cả gear
Tab:CreateToggle({
    Name = "Tự động mua tất cả gear",
    CurrentValue = false,
    Flag = "AutoBuyGearToggle",
    Callback = function(state)
        autoBuyGear = state
    end
})

-- Loop chạy nền mua hạt giống
task.spawn(function()
    while task.wait() do
        if autoBuySeeds then
            for _, seed in ipairs(seeds) do
                if not autoBuySeeds then break end
                for i = 1, 1000 do
                    if not autoBuySeeds then break end
                    game:GetService("ReplicatedStorage").GameEvents.BuySeedStock:FireServer(seed)
                    task.wait()
                end
            end
        else
            task.wait(0)
        end
    end
end)

-- Loop chạy nền mua gear
task.spawn(function()
    while task.wait() do
        if autoBuyGear then
            for _, gear in ipairs(gears) do
                if not autoBuyGear then break end
                for i = 1, 1000 do
                    if not autoBuyGear then break end
                    game:GetService("ReplicatedStorage").GameEvents.BuyGearStock:FireServer(gear)
                    task.wait()
                end
            end
        else
            task.wait(0)
        end
    end
end)
