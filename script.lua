
function playerTeleportTo(target) 
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = target
    -- print("Teleport Player To", target)
end

_G.AutoFarmLevel = false

local DiscordLib =
    loadstring(game:HttpGet "https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/discord")()

local win = DiscordLib:Window("Jujutsu Infinite ")

local serv = win:Server("Auto Farm", "")

local tgls = serv:Channel("Auto Farm All Mobs In Map")

tgls:Seperator()

tgls:Label("Hi Beta Tester.")

tgls:Seperator()

tgls:Toggle(
    "Auto-Farm",
    false,
    function(bool)
        print(bool)
        _G.AutoFarmLevel = not _G.AutoFarmLevel

        spawn(function()
            while _G.AutoFarmLevel do
                for i, mob in pairs(game:GetService("Workspace").Objects.Mobs:GetChildren()) do
                    print(i, mob)

                    -- ใช้ pcall เพื่อป้องกันข้อผิดพลาด
                    local success, err = pcall(function()
                        -- ตรวจสอบว่ามี Humanoid และ HumanoidRootPart อยู่ใน mob หรือไม่
                        if mob:FindFirstChild("Humanoid") and mob:FindFirstChild("HumanoidRootPart") then
                            repeat
                                wait()
                                for i in {1, 2, 3, 4, 5} do
                                    playerTeleportTo(mob.HumanoidRootPart.CFrame)
                                    wait(0.001)
                                    local args = {
                                        i,
                                        {
                                            mob.Humanoid
                                        }
                                    }
                                    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Server"):WaitForChild("Combat"):WaitForChild("M1"):FireServer(unpack(args))
                                end
                            until mob.Humanoid.Health <= 0
                            playerTeleportTo(CFrame.new(3884.92121, 653.905518, 104.022949))
                        else
                            print("Mob does not have Humanoid or HumanoidRootPart:", mob.Name)
                        end
                    end)

                    -- ตรวจสอบว่ามีข้อผิดพลาดเกิดขึ้นหรือไม่
                    if not success then
                        print("Error occurred:", err)
                        -- คุณสามารถเลือกที่จะข้ามหรือทำอย่างอื่นเมื่อเกิดข้อผิดพลาด
                    end
                end
            end
        end)

    end
)

tgls:Seperator()


