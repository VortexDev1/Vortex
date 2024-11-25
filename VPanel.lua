-- VortexHackermaxhackerbgkrix

UIGMControlPanel = require("engine_client.ui.layout.GUIGMControlPanel")

function UIGMControlPanel:show()
self.super.show(self)
UIHelper.showOpenAnim(self)
end

function UIGMControlPanel:hide()
showCloseAnim(self, function()
    self.super.hide(self)
end)
end

function showCloseAnim(layout, callback)
    local root = layout.root
    local count = root:GetChildCount()
    if count == 0 then
        if callback then callback() end
        return
    end

    local animationsRemaining = count

    local function checkCompletion()
        animationsRemaining = animationsRemaining - 1
        if animationsRemaining <= 0 then
            if callback then callback() end
        end
    end

    for index = 1, count do
        local content = root:GetChildByIndex(index - 1)
        if content then
            local scale = 0.5
            content:SetScale(VectorUtil.newVector3(scale, scale, scale))
            
            layout:addTimer(LuaTimer:scheduleTicker(function()
                if scale > 0 then
                    scale = scale - 0.05  -- Faster decrease (increased from 0.025 to 0.1)
                    if scale < 0 then
                        scale = 0
                    end
                    content:SetScale(VectorUtil.newVector3(scale, scale, scale))
                end

                if scale == 0 then
                    checkCompletion()
                end
            end, 1, 20))  -- Faster timer (reduced from 30 to 10)
        end
    end
end

local KeyBoardI = {}

local sendMessage = ShellInterface.sendMessage
ShellInterface.sendMessage = function(self, messageType, msgData)
    msgData.senderUserId = tostring(Game:getPlatformUserId()) 
    sendMessage(self, messageType, json.encode(msgData))
end

---@private
function KeyBoardI:init()
    if Platform.isWindow() and CGame.requireKeyboardEvent then
        CGame.Instance():requireKeyboardEvent()
        CEvents.KeyUpEvent:registerCallBack(self.onKeyUp)
        CEvents.KeyUpEvent:registerCallBack(self.onEventHold)
    end
end

function KeyBoardI:OnUpdate() 
        local player = PlayerManager:getClientPlayer()
        if player == nil then
            return
        end
        local pos = player.Player:getPosition()
        MsgSender.sendTopTips(1, string.format("XYZ: %s / %s / %s", tostring(math.floor(pos.x)), tostring(math.floor(pos.y)), tostring(math.floor(pos.z))))
    end
    
function KeyBoardI.onKeyUp(keyName, keyCode)
    A = not A
    if keyName == "T" then
    GUIGMControlPanel:show()
	UIHelper.showToast("^FF00EEPanel Open")
	if A then
    GUIGMControlPanel:hide()
	UIHelper.showToast("^FF00EEPanel Closed")
    end
	return
	end
    if keyName == "R" then
    PlayerManager:getClientPlayer().Player:startParachute()
	return
	end
    if keyName == "F" then
    local moveDir = VectorUtil.newVector3(0.0, 1.35, 0.0)
    local player = PlayerManager:getClientPlayer()
    player.Player:setAllowFlying(true)
    player.Player:setFlying(true)
    player.Player:moveEntity(moveDir)
	PlayerManager:getClientPlayer().Player:setSpeedAdditionLevel(150000)
	return
	end
    local idx = tonumber(keyName)
    return true
end




function Game:init()
local lfs = require("lfs")

local function copyFile(src, dest)
    local srcFile = io.open(src, "rb")
    local destFile = io.open(dest, "wb")
    destFile:write(srcFile:read("*a"))
    srcFile:close()
    destFile:close()
end

local function copyFolder(src, dest)
    -- Create the destination directory
    lfs.mkdir(dest)

    for file in lfs.dir(src) do
        if file ~= "." and file ~= ".." then
            local srcPath = src .. '/' .. file
            local destPath = dest .. '/' .. file
            local attr = lfs.attributes(srcPath)

            if attr.mode == "directory" then
                copyFolder(srcPath, destPath)  -- Recursive call for directories
            elseif attr.mode == "file" then
                copyFile(srcPath, destPath)     -- Copy files
            end
        end
    end
end

-- Example usage
local sourceFolder = "/storage/emulated/0/Android/data/com.sandboxol.blockymods/files/Download/SandboxOL/BlockManv2/map_temp/g20151633/Media"
local destinationFolder = "/data/user/0/com.sandboxol.blockymods/app_resources/Media"
copyFolder(sourceFolder, destinationFolder)

local open_lay = GUIManager:createGUIWindow(GUIType.Button, "ButtonA")
open_lay:SetHorizontalAlignment(HorizontalAlignment.Center)
open_lay:SetVerticalAlignment(VerticalAlignment.Top)
open_lay:SetHeight({0, 50})
open_lay:SetWidth({0, 50})
open_lay:SetTouchable(true)
open_lay:SetNormalImage("set:gui_inventory_icon.json image:icon_bookrack")
open_lay:SetPushedImage("set:gui_inventory_icon.json image:icon_bookrack")
open_lay:SetYPosition({0, 60})
open_lay:SetXPosition({0, 0})
open_lay:SetLevel(9999)

open_lay:registerEvent(GUIEvent.ButtonClick, function()
    print("Button clicked")
    showVIPDialog()
end)

GUISystem.Instance():GetRootWindow():AddChildWindow(open_lay)

function Verify()
    local logFilePath = "/storage/emulated/0/Android/data/com.sandboxol.blockymods/files/Download/SandboxOL/BlockMan/config/client.log"

    local function isVIP()
        local file = io.open(logFilePath, "r")
        if not file then
            print("File not found")
            return false
        end

        local content = file:read("*all")
        file:close()

        return content:find("6066449310") ~= nil 
        or content:find("489543279") ~= nil 
        or content:find("4255925024") ~= nil 
        or content:find("220021582") ~= nil
        or content:find("6087045662") ~= nil
    end

    if isVIP() then
        print("User is VIP")
        showVIPDialog()
    else
        print("User is not VIP")
        showNonVIPDialog()
    end
end

function showVIPDialog()
    CustomDialog.builder()
    CustomDialog.setTitleText("Welcome, VIP!")
    CustomDialog.setContentText(
        "-->THX for using our panel\n\n" ..
        "see our functions in panel by clicking continue"
    )
    CustomDialog.setRightText("Continue")
    CustomDialog.setLeftText("Close")
    
    CustomDialog.setRightClickListener(
        function()
            UIHelper.showToast("thanks for using our panel")
            GUIGMMain:show()
            open_lay:SetVisible(false)
        end
    )
    
    CustomDialog.setLeftClickListener(
        function()
            UIHelper.showToast("Dialog closed.")
        end
    )
    
    CustomDialog.show()
end

function showNonVIPDialog()
    CustomDialog.builder()
    CustomDialog.setTitleText("Access Denied")
    CustomDialog.setContentText(
        "--> You are not VIP.\n\n" ..
        "To gain VIP access go to discord to get VIP ore remove panel and dont leak it "
    )
    CustomDialog.setRightText("Enter Password")
    CustomDialog.setLeftText("Close")
    
    CustomDialog.setRightClickListener(
        function()
            GMHelper:openInput({ "" }, function(password)
                if password == "Vpanelteam###ez" then
                    UIHelper.showToast("Password accepted!")
                    showVIPDialog()
                else
                    UIHelper.showToast("Incorrect password.")
                end
            end)
        end
    )
    
    CustomDialog.setLeftClickListener(
        function()
            UIHelper.showToast("Dialog closed.")
        end
    )
    
    CustomDialog.show()
end

open_lay:SetVisible(true)

    local hue = 0

local function interpolateColor(hue)
    local r, g, b, a = 0, 0, 0, 0
    if hue < 60 then
        r, g, b, a = 1, hue / 60, 0, 1 - (hue / 60)
    elseif hue < 120 then
        r, g, b, a = (120 - hue) / 60, 1, 0, (hue - 60) / 60
    elseif hue < 180 then
        r, g, b, a = 0, 1, (hue - 120) / 60, 1 - ((hue - 120) / 60)
    elseif hue < 240 then
        r, g, b, a = 0, (240 - hue) / 60, 1, (hue - 180) / 60
    elseif hue < 300 then
        r, g, b, a = (hue - 240) / 60, 0, 1, 1 - ((hue - 240) / 60)
    else
        r, g, b, a = 1, 0, (360 - hue) / 60, (hue - 300) / 60
    end
    return r, g, b, a
end
--[[
function Credits()
    local GUI = GUIManager:createGUIWindow(GUIType.StaticText, "GUIRoot-Ping")
    GUI:SetVisible(true)
    
    local function Update()
        local YE = "Credits:VortexHacker 1.8Beta(VIP only)(2.93.1)"

        GUI:SetText(YE)
        GUI:SetTextColor({138, 43, 226})
    end

    GUI:SetWidth({ 0, 200 })
    GUI:SetHeight({ 0, 40 })
    GUI:SetXPosition({ 0, 535 })
    GUI:SetBordered(true)
    GUI:SetYPosition({ 0, 105 })
    GUISystem.Instance():GetRootWindow():AddChildWindow(GUI)

    LuaTimer:scheduleTimer(Update, 100, -1)
end
Credits()
]]
function Dates()
    local DAT = GUIManager:createGUIWindow(GUIType.StaticText, "GUIRoot-Date")
    DAT:SetVisible(true)

    local function Updater()
    local year = os.date("%Y") -- Get the current year
    local now = os.date("%B %d %A") -- Format: Month Day Weekday  
        local YES = "Date: " .. now

        DAT:SetText(YES)
        DAT:SetTextColor({120/255, 3/255, 255/255, 1})
    end

    DAT:SetWidth({ 0, 20 })
    DAT:SetHeight({ 0, 20 })
    DAT:SetXPosition({ 0, 15 })
    DAT:SetBordered(true)
    DAT:SetYPosition({ 0, 640 })
    GUISystem.Instance():GetRootWindow():AddChildWindow(DAT)

    LuaTimer:scheduleTimer(Updater, 100, -1)
end
Dates()
Done1pro()
function Tps()
    local DATO = GUIManager:createGUIWindow(GUIType.StaticText, "GUIRoot-Group")
    DATO:SetVisible(true)

    local function Updatec()
    local currentTime = os.date("%I:%M %p")
    local time = EngineWorld:getWorld():getWorldTime()  
        local YUS = "EngineWorld: " .. time .. " | Clock: " .. currentTime

        DATO:SetText(YUS)
        DATO:SetTextColor(Color.BLUE)
    end

    DATO:SetWidth({ 0, 20 })
    DATO:SetHeight({ 0, 20 })
    DATO:SetXPosition({ 0, 15 })
    DATO:SetBordered(true)
    DATO:SetYPosition({ 0, 680 })
    GUISystem.Instance():GetRootWindow():AddChildWindow(DATO)

    LuaTimer:scheduleTimer(Updatec, 100, -1)
end
Tps()



-- Create the Coordinates button
 -- Set the button text to "Coordinates"
if CGame.Instance():getGameType() == "g1008" then
      local GameType
if Server then
    GameType = Server.Instance():getConfig().gameType
end

if CGame then
    GameType = CGame.Instance():getGameType()
end
---不跟随配置进行热更

local mapPath
if LogicSetting.Instance():getLordPlatform() == 2 then
    mapPath = ScriptSetting.getScriptPath() .. "/map/"
else
    mapPath = Root.Instance():getRootPath() .. "/" .. ScriptSetting.getScriptPath() .. "/map/"
end

HostApi.putStringPrefs("MapRegionPath", mapPath)

IsAIGame = false

end


if CGame.Instance():getGameType() == "g1071" then
   local GameType
if Server then
    GameType = Server.Instance():getConfig().gameType
end
if CGame then
    if Root.getWorldName then
        local pos = Root.Instance():getWorldName():find("g1071")
        if pos then
            GameType = Root.Instance():getWorldName():sub(pos, pos + 4)
        else
            GameType = CGame.Instance():getGameType()
        end
    else
        GameType = CGame.Instance():getGameType()
    end
end
---不跟随配置进行热更
local mapPath
if LogicSetting.Instance():getLordPlatform() == 2 then
    ---linux
    mapPath = ScriptSetting.getScriptPath() .. "/map/" .. GameType .. "/"
else
    ---window
    mapPath = Root.Instance():getRootPath() .. "/" .. ScriptSetting.getScriptPath() .. "/map/" .. GameType .. "/"
end
HostApi.putStringPrefs("MapRegionPath", mapPath)
end


    self.CGame = CGame.Instance()
    self.GameType = self.CGame:getGameType()
    self.EnableIndie = self.CGame:isEnableIndie(true)
    self.Blockman = Blockman.Instance()
    self.World = self.Blockman:getWorld()
    self.LowerDevice = self.CGame:isLowerDevice()
    EngineWorld:setWorld(self.World)
end

function Game:isOpenGM()
    return isClient
end

local Settings = {}
GMHelper = {}
GMSetting = {}

local function isGMOpen(userId)
    if isServer then
        return true
    end
    return TableUtil.include(AdminIds, tostring(userId))
end


function GMSetting:addTab(tab_name, index)
    for _, setting in pairs(Settings) do
        if setting.name == tab_name then
            setting.items = {}
            return
        end
    end
    index = index or #Settings + 1
    table.insert(Settings, index, { name = tab_name, items = {} })
end

function GMSetting:addItem(tab_name, item_name, func_name, ...)
    local settings
    for _, group in pairs(Settings) do
        if group.name == tab_name then
            settings = group
        end
    end
    if not settings then
        GMSetting:addTab(tab_name)
        GMSetting:addItem(tab_name, item_name, func_name, ...)
        return
    end
    table.insert(settings.items, { name = item_name, func = func_name, params = { ... } })
end

function GMSetting:changeColorByFunction(func_name, toggle, text)
    for _, group in pairs(Settings) do
        for _, item in pairs(group.items) do
            if item.func == func_name then
                if toggle then
                item.color = Color.BLUE
                text:SetBackgroundColor({120/255, 3/255, 255/255, 1})
                return -- Item found and color changed
                end
                item.color = Color.BLACK
                text:SetBackgroundColor(Color.BLACK)
                return -- Item found and color changed
            end
        end
    end
    -- Item with the specified function name not found
end





function GMSetting:getSettings()
    return Settings
end





GMSetting:addTab("^7803FFhack")
GMSetting:addItem("^7803FFhack", "^00FFFFUnlimited Jumps", "AirJump")
GMSetting:addItem("^7803FFhack", "^00FFFFSpeed", "Speed")
GMSetting:addItem("^7803FFhack", "^00FFFFReach", "toggleBlockReach")
GMSetting:addItem("^7803FFhack", "^00FFFFAttackCD", "toggleCD")
GMSetting:addItem("^7803FFhack", "^00FFFFfastBreak", "FastBreak")
GMSetting:addItem("^7803FFhack", "^00FFFFDevFly", "FlySpeed")
GMSetting:addItem("^7803FFhack", "^00FFFFQuickBlock", "test")
GMSetting:addItem("^7803FFhack", "^00FFFFFlyParachute", "FlyParachute")
GMSetting:addItem("^7803FFhack", "^00FFFFBlink", "Blink")
GMSetting:addItem("^7803FFhack", "^00FFFFAutoKill", "ardenkill")
GMSetting:addItem("^7803FFhack", "^00FFFFAimBot", "ezabcdefghijklmnop")
GMSetting:addItem("^7803FFhack", "^00FFFFTracer", "Tracer")
GMSetting:addItem("^7803FFhack", "^00FFFFjetpackv2", "toggleCannon")
GMSetting:addItem("^7803FFhack", "^00FFFFScaffold", "Scaffold")
GMSetting:addItem("^7803FFhack", "^00FFFFNoClip", "toggleNoClip")
--GMSetting:addItem("^7803FFhack", "^00FFFFtoggleHp", "toggleHp")
GMSetting:addItem("^7803FFhack", "^00FFFFReach", "setBlockReach")
GMSetting:addItem("^7803FFhack", "^00FFFFClickTP", "Clecktp")
--GMSetting:addItem("^7803FFhack", "^00FFFFTargetClicker", "TargetClicker")
GMSetting:addItem("^7803FFhack", "^00FFFFsetHitboxSize", "HitBox1")
GMSetting:addItem("^7803FFhack", "^00FFFFLongJump", "LongJump")
GMSetting:addItem("^7803FFhack", "^00FFFFAutoClick", "AutoClick") 
GMSetting:addItem("^7803FFhack", "^00FFFFHitbox", "setHitboxSize")
GMSetting:addItem("^7803FFhack", "^00FFFFfly2", "toggleJetPackv4")
--GMSetting:addItem("^7803FFhack", "^00FFFFDDOSV2", "LagServer4")
--GMSetting:addItem("^7803FFhack", "^00FFFFCrossHair", "toggleCrossHairsVisibility")
GMSetting:addItem("^7803FFhack", "^00FFFFgcubes", "updateWalletAndRegion")
GMSetting:addItem("^7803FFhack", "^00FFFFRespawn", "Respawn")
--GMSetting:addItem("^7803FFhack", "^00FFFFCheckHeightAndToggleNoClip", "test8eueuudd")



GMSetting:addTab("^7803FFeffects")
GMSetting:addItem("^7803FFeffects","^00FFFFWWE_Camera","WWE_Camera")
GMSetting:addItem("^7803FFeffects","^00FFFFSpamChat2","SpamChat2")
GMSetting:addItem("^7803FFeffects","^00FFFFSetMaxFPS","SetMaxFPS")
GMSetting:addItem("^7803FFeffects","^00FFFFChangeActorForMe","ChangeActorForMe")
GMSetting:addItem("^7803FFeffects","^00FFFFEmoteFreezer","EmoteFreezer")
GMSetting:addItem("^7803FFeffects","^00FFFFRuncode","RunCode")
--GMSetting:addItem("^7803FFeffects","^00FFFFEWings","Wings")
--GMSetting:addItem("^7803FFeffects","^00FFFFESky","Skys")
GMSetting:addItem("^7803FFeffects","^00FFFFEHurtCamera","toggleHurtCamera")
GMSetting:addItem("^7803FFeffects","^00FFFFAntiLag","AntiLag")-- Because we have superAntiLag
GMSetting:addItem("^7803FFeffects","^00FFFFno fps limit","MaxFPS")
GMSetting:addItem("^7803FFeffects","^00FFFFCustomDialog","createCustomDialogFromInput")
--GMSetting:addItem("^7803FFeffects","^00FFFFtest1 ","TestEnterbtb")
GMSetting:addItem("^7803FFeffects","^00FFFFSuperAntiLag","SuperAntiLag")







GMSetting:addTab("^7803FFView")
GMSetting:addItem("^7803FFView","XLRainbow","RainbowWings")
GMSetting:addItem("^7803FFView","XLGoldWings","XLGoldWings")
GMSetting:addItem("^7803FFView","XLIceWings","IceWings")
GMSetting:addItem("^7803FFView","XLFireWings","FireWings")
GMSetting:addItem("^7803FFView","YellowWings","YellowWings")
GMSetting:addItem("^7803FFView","PinkWings","PinkWings")
GMSetting:addItem("^7803FFView","BlueWings","ShareWings")
GMSetting:addItem("^7803FFView", "^00FFFFDay", "Day")
GMSetting:addItem("^7803FFView", "^00FFFFSnow", "Snow")
GMSetting:addItem("^7803FFView", "^00FFFFEvening", "Evening")
GMSetting:addItem("^7803FFView", "^00FFFFrain", "ChangeWeather")


GMSetting:addTab("^7803FFspecial")
GMSetting:addItem("^7803FFspecial", "^00FFFFTeleportByUID", "TeleportByUID")
GMSetting:addItem("^7803FFspecial", "^00FFFFChangeActorForMe", "ChangeActorForMe")
GMSetting:addItem("^7803FFspecial", "^00FFFFCloseGame", "CloseGame")
GMSetting:addItem("^7803FFspecial", "^00FFFFCopyPlayersInfo", "CopyPlayersInfo")
GMSetting:addItem("^7803FFspecial", "^00FFFFViewFreecamX", "Disable Freecam")
GMSetting:addItem("^7803FFspecial", "^00FFFFViewFreecam", "activate Freecam")
GMSetting:addItem("^7803FFspecial", "^00FFFFNoFall", "NoFall")
GMSetting:addItem("^7803FFspecial", "^00FFFFWarnTP", "WarnTP")
GMSetting:addItem("^7803FFspecial", "^00FFFFSetMaxFPS", "SetMaxFPS")
GMSetting:addItem("^7803FFspecial", "^00FFFFRenderWorld", "RenderWorld")
GMSetting:addItem("^7803FFspecial", "^00FFFFArmSpeed", "ArmSpeed")
GMSetting:addItem("^7803FFspecial", "^00FFFFChangeNick", "ChangeNick")
GMSetting:addItem("^7803FFspecial", "^00FFFFJumpHeight", "JumpHeight")
GMSetting:addItem("^7803FFspecial", "^00FFFFchangeScale", "changeScale")
GMSetting:addItem("^7803FFspecial", "^00FFFFWaterPush", "WaterPush")
GMSetting:addItem("^7803FFspecial", "^00FFFFWatchMode", "ChatSend1")--WatchMode

GMSetting:addTab("^7803FFCustomGUI")
GMSetting:addItem("^7803FFCustomGUI", "^00FFFFParachuteButton", "ParachuteButton")
GMSetting:addItem("^7803FFCustomGUI", "^00FFFFCannonWithParachute", "buttonMain175")
GMSetting:addItem("^7803FFCustomGUI", "^00FFFFCannon", "buttoncannonabc2")
GMSetting:addItem("^7803FFCustomGUI", "^00FFFFFastButtons", "FastButtons")
GMSetting:addItem("^7803FFCustomGUI", "^00FFFFAimBotButton", "ezabcdefghijklmnop")
GMSetting:addItem("^7803FFCustomGUI", "^00FFFFautoclick", "autoclickV3")
GMSetting:addItem("^7803FFCustomGUI", "^00FFFFHitboxBTN", "speedbyttonez")
GMSetting:addItem("^7803FFCustomGUI", "^00FFFFFreecam", "Freecam")
GMSetting:addItem("^7803FFCustomGUI", "^00FFFFHideBtn", "HideBtn")--HideBtn
GMSetting:addItem("^7803FFCustomGUI", "^00FFFFFlyBtn", "FlyBtn1")
GMSetting:addItem("^7803FFCustomGUI", "^00FFFFPCrosshair", "pcgame")




GMSetting:addTab("^7803FFGame & panel")
GMSetting:addItem("^7803FFGame & panel","^00FFFFRemove Panel","removePanel")
GMSetting:addItem("^7803FFGame & panel","^00FFFFmakeGmButtonTran","makeGmButtonTran")

if CGame.Instance():getGameType() == "g1008" then
    GMSetting:addTab("^7803FFbedwars")
    GMSetting:addItem("^7803FFbedwars", "^00FFFFAutomatic bridge", "AutomaticBridge")
    GMSetting:addItem("^7803FFbedwars", "^00FFFFbwrespawn", "bedWarsRespawn")
end

GMSetting:addTab("^7803FFCredits")
GMSetting:addItem("^7803FFCredits", "^7803FFinfo", "1")
GMSetting:addItem("^7803FFCredits", "^7803FFyoutube", "1")
GMSetting:addItem("^7803FFCredits", "^7803FFdiscord", "1")
GMSetting:addItem("^7803FFCredits", "", "1")
GMSetting:addItem("^7803FFCredit
