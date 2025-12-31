local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Natural Disaster Survival",
   LoadingTitle = "NDS",
   LoadingSubtitle = "by ughuhh09/_yolo.0 on discord",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = true,
      FileName = "NDS_Config"
   },
   Discord = {
      Enabled = false,
      Invite = "noinvitelink",
      RememberJoins = true
   },
   KeySystem = false,
   KeySettings = {
      Title = "Untitled",
      Subtitle = "Key System",
      Note = "No method of obtaining the key is provided",
      FileName = "Key",
      SaveKey = true,
      GrabKeyFromSite = false,
      Key = {"Hello"}
   }
})

Rayfield:Notify({
   Title = "Wowww",
   Content = "NDS is the best",
   Duration = 6.5,
   Image = 4483362458,
   Actions = {
      Ignore = {
         Name = "Okay!",
         Callback = function()
         end
      },
   },
})

local VoidTab = Window:CreateTab("Voiding")

local toggleConnection  -- Variable to store the Heartbeat connection

local Toggle = VoidTab:CreateToggle({
   Name = "Void?",
   CurrentValue = false,
   Flag = "Toggle1",
   Callback = function(value)
      local player = game.Players.LocalPlayer
      local runService = game:GetService("RunService")

      local function teleportToTriangle()
          local pos1 = Vector3.new(0, 500, 0)
          local pos2 = Vector3.new(100, 500, 100)
          local pos3 = Vector3.new(-100, 500, 100)

          local randomPoint = math.random(1, 3)
          if randomPoint == 1 then
              player.Character:SetPrimaryPartCFrame(CFrame.new(pos1))
          elseif randomPoint == 2 then
              player.Character:SetPrimaryPartCFrame(CFrame.new(pos2))
          elseif randomPoint == 3 then
              player.Character:SetPrimaryPartCFrame(CFrame.new(pos3))
          end
      end

      if value == true then
          -- Start teleporting on Heartbeat when toggle is ON
          toggleConnection = runService.Heartbeat:Connect(function()
              teleportToTriangle()
              wait(1)  -- Adjust the wait time to control teleportation frequency
          end)
      else
          -- Stop the Heartbeat connection when toggle is OFF
          if toggleConnection then
              toggleConnection:Disconnect()
          end
      end
   end
})

local Tab2 = Window:CreateTab("Credits")
local Label = Tab2:CreateLabel("Made by ughuhh09/_yolo.0 on discord")

local tab3 = Window:CreateTab("Misc")

local button = tab3:CreateButton({
   Name = "Rejoin Game",
   Callback = function()
      game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
   end,
})

local button2 = tab3:CreateButton({
   Name = "Server Hop",
   Callback = function()
      local PlaceID = game.PlaceId
      local AllIDs = {}
      local foundAnything = ""
      local actualHour = os.date("!*t").hour
      local Deleted = false

      function TPReturner()
          local Site
          if foundAnything == "" then
              Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
          else
              Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
          end
          local ID = ""
          if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
              foundAnything = Site.nextPageCursor
          end
          local num = 0
          for i, v in pairs(Site.data) do
              if v.playing ~= v.maxPlayers then
                  num = num + 1
                  AllIDs[num] = v.id
              end
          end
      end

      function TeleportToRandomServer(retries)
          if retries > 5 then
              print("No available servers. Please try again later.")
              return
          end

          TPReturner()
          if #AllIDs > 0 then
              local Random = math.random(1, #AllIDs)
              game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, AllIDs[Random], game.Players.LocalPlayer)
          else
              retries = retries + 1
              TeleportToRandomServer(retries)
          end
      end

      TeleportToRandomServer(0)
   end,
})

local button3 = tab3:CreateButton({
   Name = "Infinite Yield",
   Callback = function()
      loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
   end,
})

local button4 = tab3:CreateButton({
   Name = "Dex Explorer",
   Callback = function()
      loadstring(game:HttpGet('https://raw.githubusercontent.com/Def-Energy/Dex-Explorer/main/source'))()
   end,
})

local button5 = tab3:CreateButton({
   Name = "Destroy GUI",
   Callback = function()
      Rayfield:Destroy()
   end
})
