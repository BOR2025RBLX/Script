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
    KeySystem = false,
    Theme = "DarkBlue"  -- Đây nhé, thêm dòng này để dùng theme Dark Blue
})

local Tab = Window:CreateTab("Shop", 4483362458)
Tab:CreateSection("Tự động mua")

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

local eggs = {
    "Common Egg",
    "Common Summer Egg",
    "Rare Summer Egg",
    "Mythical Egg",
    "Paradise Egg",
    "Bug Egg"
}

local autoBuySeeds = false
local autoBuyGear = false
local autoBuyEggs = false

Tab:CreateToggle({
    Name = "Tự động mua Seed Shop",
    CurrentValue = false,
    Flag = "AutoBuySeedsToggle",
    Callback = function(state)
        autoBuySeeds = state
    end
})

Tab:CreateSection("Tự động mua")

Tab:CreateToggle({
    Name = "Tự động mua Gear Shop",
    CurrentValue = false,
    Flag = "AutoBuyGearToggle",
    Callback = function(state)
        autoBuyGear = state
    end
})

Tab:CreateSection("Tự động mua")

Tab:CreateToggle({
    Name = "Tự động mua Egg Shop",
    CurrentValue = false,
    Flag = "AutoBuyEggsToggle",
    Callback = function(state)
        autoBuyEggs = state
    end
})

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BuySeedEvent = ReplicatedStorage.GameEvents:WaitForChild("BuySeedStock")
local BuyGearEvent = ReplicatedStorage.GameEvents:WaitForChild("BuyGearStock")
local BuyEggEvent = ReplicatedStorage.GameEvents:WaitForChild("BuyPetEgg")

local function safeBuy(event, item)
    local success, err = pcall(function()
        event:FireServer(item)
    end)
    if not success then
        warn("[AutoBuy] Lỗi khi mua "..item..": "..tostring(err))
    end
    return success
end

-- Auto mua seeds, mỗi loại 10 lần
task.spawn(function()
    while true do
        if autoBuySeeds then
            for _, seed in ipairs(seeds) do
                if not autoBuySeeds then break end
                local boughtCount = 0
                while boughtCount < 10 and autoBuySeeds do
                    local success = safeBuy(BuySeedEvent, seed)
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

-- Auto mua gear, mỗi loại 10 lần
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

-- Auto mua trứng, mỗi loại tối đa 3 quả
task.spawn(function()
    while true do
        if autoBuyEggs then
            for _, egg in ipairs(eggs) do
                if not autoBuyEggs then break end
                local boughtCount = 0
                while boughtCount < 3 and autoBuyEggs do
                    local success = safeBuy(BuyEggEvent, egg)
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
