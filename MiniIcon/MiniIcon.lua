local MiniIcon = LibStub("AceAddon-3.0"):NewAddon("MiniIcon", "AceEvent-3.0", "AceConsole-3.0")
local StdUi = LibStub('StdUi')

_G["MiniIcon"] = MiniIcon

local defaults = {
    global = {
        popup = 1,
        version = 1,
        rotationAddon = 'None',
    },
    profile = {
        rotationAddon = 'None',
    }
}

function MiniIcon:OnProfileChanged(event, db)
    self.db.profile = db.profile
end

function MiniIcon:OnProfileReset(event, db)
    for k, v in pairs(defaults) do
        db.profile[k] = v
    end
    self.db.profile = db.profile
end

function MiniIcon:OnNewProfile(event, db)
    for k, v in pairs(defaults) do
        db.profile[k] = v
    end
end

function MiniIcon:OnInitialize()
    self.db = LibStub("AceDB-3.0"):New("Rubim-MiniIconDB", defaults, true)
    self.db.RegisterCallback(self, "OnProfileChanged", "OnProfileChanged")
    self.db.RegisterCallback(self, "OnProfileCopied", "OnProfileChanged")
    self.db.RegisterCallback(self, "OnProfileReset", "OnProfileReset")
    self.db.RegisterCallback(self, "OnNewProfile", "OnNewProfile")

    C_Timer.After(5, function()

    end)
end

local uiShown = false
local window
function ConfigMenu()
    mainWindow = StdUi:Window(UIParent, 'Rubim Mini Icon', 350, 150);
    mainWindow:SetPoint('TOPRIGHT', -160, -100);
    
    mainTitle = StdUi:Label(mainWindow, 'Configuration', 12)
    StdUi:GlueTop(mainTitle, mainWindow, 0, -35, 'CENTER');

    local items = {
    };

    if ConRO then
        table.insert(items, { text = 'ConRO', value = 'MaxDps'})
    end

    if MaxDps then
        table.insert(items, { text = 'MaxDps', value = 'MaxDps'})
    end

    if Hekili then
        table.insert(items, { text = 'Hekili', value = 'Hekili'})
    end

    if HeroRotation then
        table.insert(items, { text = 'HeroRotation', value = 'HeroRotation'})
    end
    
    local dd = StdUi:Dropdown(mainWindow, 200, 20, items, MiniIcon.db.global.rotationAddon);
    dd:SetPlaceholder('-- Base Routine --');
    StdUi:GlueBelow(dd, mainTitle, 0, -35, 'CENTER');

    dd.OnValueChanged = function(self, value)
        MiniIcon.db.global.rotationAddon = value
    end;
end
SLASH_MI1 = "/mi"
SlashCmdList["MI"] = function(msg)
    ConfigMenu()
end

local safeColor = true

local function round2(num, idp)
    mult = 10 ^ (idp or 0)
    return math.floor(num * mult + 0.5) / mult
end

function roundscale(num, idp)
    mult = 10 ^ (idp or 0)
    return math.floor(num * mult + 0.5) / mult
end

local Icons = {}
Icons.topIcons = CreateFrame("Frame", nil, UIParent, BackdropTemplateMixin and "BackdropTemplate")
Icons.topIcons:SetBackdrop(nil)
Icons.topIcons:SetFrameStrata("HIGH")
Icons.topIcons:SetSize(242, 30)
Icons.topIcons:SetPoint("TOPLEFT", 0, 12) --12
Icons.topIcons.texture = Icons.topIcons:CreateTexture(nil, "TOOLTIP")
Icons.topIcons.texture:SetAllPoints(true)
Icons.topIcons.texture:SetColorTexture(0, 0, 0, 0)
Icons.topIcons:SetMovable(true)
Icons.topIcons:EnableMouse(true)
Icons.topIcons:SetScript(
        "OnMouseDown",
        function(self, button)
            if button == "LeftButton" and not self.isMoving then
                self:StartMoving()
                self.isMoving = true
            end
        end
)
Icons.topIcons:SetScript(
        "OnMouseUp",
        function(self, button)
            if button == "LeftButton" and self.isMoving then
                self:StopMovingOrSizing()
                self.isMoving = false
            end
        end
)
Icons.topIcons:SetScript(
        "OnHide",
        function(self)
            if (self.isMoving) then
                self:StopMovingOrSizing()
                self.isMoving = false
            end
        end
)


if safeColor then
    Icons.topIcons.texture:SetColorTexture(0, 0, 0, 1)
end

Icons.topIcons:SetScale(1)
Icons.topIcons:Show(1)

Icons.kickIcon = CreateFrame("Frame", nil, Icons.topIcons, BackdropTemplateMixin and "BackdropTemplate")
Icons.kickIcon:SetBackdrop(nil)
Icons.kickIcon:SetFrameStrata("TOOLTIP")
Icons.kickIcon:SetSize(1, 1)
Icons.kickIcon:SetPoint("TOPLEFT", Icons.topIcons, 24, -12) --12
Icons.kickIcon.texture = Icons.kickIcon:CreateTexture(nil, "TOOLTIP")
Icons.kickIcon.texture:SetAllPoints(true)
Icons.kickIcon.texture:SetColorTexture(0, 1, 1, 0)
Icons.kickIcon:SetScale(1)
Icons.kickIcon:Show(1)

Icons.stIcon = CreateFrame("Frame", nil, Icons.topIcons, BackdropTemplateMixin and "BackdropTemplate")
Icons.stIcon:SetBackdrop(nil)
Icons.stIcon:SetFrameStrata("TOOLTIP")
Icons.stIcon:SetSize(30, 30)
Icons.stIcon:SetPoint("TOPLEFT", Icons.topIcons, 31, 0) --12
Icons.stIcon.texture = Icons.stIcon:CreateTexture(nil, "TOOLTIP")
Icons.stIcon.texture:SetAllPoints(true)
Icons.stIcon.texture:SetColorTexture(0, 1, 0, 0)
Icons.stIcon:SetScale(1)
Icons.stIcon:Show(1)

Icons.aoeIcon = CreateFrame("Frame", nil, Icons.topIcons, BackdropTemplateMixin and "BackdropTemplate")
Icons.aoeIcon:SetBackdrop(nil)
Icons.aoeIcon:SetFrameStrata("TOOLTIP")
Icons.aoeIcon:SetSize(30, 30)
Icons.aoeIcon:SetPoint("TOPLEFT", Icons.topIcons, 61, 0) --12
Icons.aoeIcon.texture = Icons.aoeIcon:CreateTexture(nil, "TOOLTIP")
Icons.aoeIcon.texture:SetAllPoints(true)
Icons.aoeIcon.texture:SetColorTexture(1, 1, 0, 0)
Icons.aoeIcon:SetScale(1)
Icons.aoeIcon:Show(1)

Icons.gladiatorIcon = CreateFrame("Frame", nil, Icons.topIcons, BackdropTemplateMixin and "BackdropTemplate")
Icons.gladiatorIcon:SetBackdrop(nil)
Icons.gladiatorIcon:SetFrameStrata("TOOLTIP")
Icons.gladiatorIcon:SetSize(30, 30)
Icons.gladiatorIcon:SetPoint("TOPLEFT", Icons.topIcons, 91, 0) --12
Icons.gladiatorIcon.texture = Icons.gladiatorIcon:CreateTexture(nil, "TOOLTIP")
Icons.gladiatorIcon.texture:SetAllPoints(true)
Icons.gladiatorIcon.texture:SetColorTexture(0, 0, 1, 0)
Icons.gladiatorIcon:SetScale(1)
Icons.gladiatorIcon:Show(1)

Icons.passiveIcon = CreateFrame("Frame", nil, Icons.topIcons, BackdropTemplateMixin and "BackdropTemplate")
Icons.passiveIcon:SetBackdrop(nil)
Icons.passiveIcon:SetFrameStrata("TOOLTIP")
Icons.passiveIcon:SetSize(30, 30)
Icons.passiveIcon:SetPoint("TOPLEFT", Icons.topIcons, 121, 0) --12
Icons.passiveIcon.texture = Icons.passiveIcon :CreateTexture(nil, "TOOLTIP")
Icons.passiveIcon.texture:SetAllPoints(true)
Icons.passiveIcon.texture:SetColorTexture(1, 0, 0, 0)
Icons.passiveIcon:SetScale(1)
Icons.passiveIcon:Show(1)


function Icons.Arena1Icon(texture)
    Icons.class1Icon.texture:SetTexture(texture)
end

function Icons.Arena2Icon(texture)
    Icons.class2Icon.texture:SetTexture(texture)
end

function Icons.Arena3Icon(texture)
    Icons.class3Icon.texture:SetTexture(texture)
end
Icons.class1Icon = CreateFrame("Frame", nil, Icons.topIcons, BackdropTemplateMixin and "BackdropTemplate")
Icons.class1Icon:SetBackdrop(nil)
Icons.class1Icon:SetFrameStrata("TOOLTIP")
Icons.class1Icon:SetSize(30, 30)
Icons.class1Icon:SetPoint("TOPLEFT", Icons.topIcons, 121, 0) --12
Icons.class1Icon.texture = Icons.class1Icon :CreateTexture(nil, "TOOLTIP")
Icons.class1Icon.texture:SetAllPoints(true)
Icons.class1Icon.texture:SetColorTexture(1, 0, 0, 0)
Icons.class1Icon:SetScale(1)
Icons.class1Icon:Show(1)

Icons.class2Icon = CreateFrame("Frame", nil, Icons.topIcons, BackdropTemplateMixin and "BackdropTemplate")
Icons.class2Icon:SetBackdrop(nil)
Icons.class2Icon:SetFrameStrata("TOOLTIP")
Icons.class2Icon:SetSize(30, 30)
Icons.class2Icon:SetPoint("TOPLEFT", Icons.topIcons, 151, 0) --12
Icons.class2Icon.texture = Icons.class2Icon:CreateTexture(nil, "TOOLTIP")
Icons.class2Icon.texture:SetAllPoints(true)
Icons.class2Icon.texture:SetColorTexture(1, 0, 0, 0)
Icons.class2Icon:SetScale(1)
Icons.class2Icon:Show(1)

Icons.class3Icon = CreateFrame("Frame", nil, Icons.topIcons, BackdropTemplateMixin and "BackdropTemplate")
Icons.class3Icon:SetBackdrop(nil)
Icons.class3Icon:SetFrameStrata("TOOLTIP")
Icons.class3Icon:SetSize(30, 30)
Icons.class3Icon:SetPoint("TOPLEFT", Icons.topIcons, 181, 0) --12
Icons.class3Icon.texture = Icons.class3Icon:CreateTexture(nil, "TOOLTIP")
Icons.class3Icon.texture:SetAllPoints(true)
Icons.class3Icon.texture:SetColorTexture(1, 0, 0, 0)
Icons.class3Icon:SetScale(1)
Icons.class3Icon:Show(1)

--Icons.arena1.texture:SetColorTexture(0, 0.56, 0) -- Interrupt
--Icons.arena1.texture:SetColorTexture(0.56, 0, 0) -- Interrupt
Icons.arena1 = CreateFrame("Frame", nil, Icons.topIcons, BackdropTemplateMixin and "BackdropTemplate")
Icons.arena1:SetBackdrop(nil)
Icons.arena1:SetFrameStrata("TOOLTIP")
--Icons.arena1:SetSize(8, 8)
Icons.arena1:SetSize(175, 8)
Icons.arena1:SetPoint("TOPLEFT", Icons.topIcons, 213, -12) --12
Icons.arena1.texture = Icons.arena1 :CreateTexture(nil, "TOOLTIP")
Icons.arena1.texture:SetAllPoints(true)
Icons.arena1:SetScale(1)
Icons.arena1:Show(1)

Icons.arena12 = CreateFrame("Frame", nil, Icons.topIcons, BackdropTemplateMixin and "BackdropTemplate")
Icons.arena12:SetBackdrop(nil)
Icons.arena12:SetFrameStrata("TOOLTIP")
Icons.arena12:SetSize(8, 8)
Icons.arena12:SetPoint("TOPLEFT", Icons.topIcons, 213, -20) --12
Icons.arena12.texture = Icons.arena12 :CreateTexture(nil, "TOOLTIP")
Icons.arena12.texture:SetAllPoints(true)
Icons.arena12.texture:SetColorTexture(0, 0, 0, 0)
Icons.arena12:SetScale(1)
Icons.arena12:Show(1)

Icons.arena2 = CreateFrame("Frame", nil, Icons.topIcons, BackdropTemplateMixin and "BackdropTemplate")
Icons.arena2:SetBackdrop(nil)
Icons.arena2:SetFrameStrata("TOOLTIP")
Icons.arena2:SetSize(175, 8)
Icons.arena2:SetPoint("TOPLEFT", Icons.topIcons, 387, -12) --12
Icons.arena2.texture = Icons.arena2 :CreateTexture(nil, "TOOLTIP")
Icons.arena2.texture:SetAllPoints(true)
Icons.arena2:SetScale(1)
Icons.arena2:Show(1)

Icons.arena22 = CreateFrame("Frame", nil, Icons.topIcons, BackdropTemplateMixin and "BackdropTemplate")
Icons.arena22:SetBackdrop(nil)
Icons.arena22:SetFrameStrata("TOOLTIP")
Icons.arena22:SetSize(8, 8)
Icons.arena22:SetPoint("TOPLEFT", Icons.topIcons, 387, -20) --12
Icons.arena22.texture = Icons.arena22 :CreateTexture(nil, "TOOLTIP")
Icons.arena22.texture:SetAllPoints(true)
Icons.arena22.texture:SetColorTexture(0, 0, 0, 0)
Icons.arena22:SetScale(1)
Icons.arena22:Show(1)

Icons.arena3 = CreateFrame("Frame", nil, Icons.topIcons, BackdropTemplateMixin and "BackdropTemplate")
Icons.arena3:SetBackdrop(nil)
Icons.arena3:SetFrameStrata("TOOLTIP")
Icons.arena3:SetSize(175, 8)
Icons.arena3:SetPoint("TOPLEFT", Icons.topIcons, 561, -12) --12
Icons.arena3.texture = Icons.arena3 :CreateTexture(nil, "TOOLTIP")
Icons.arena3.texture:SetAllPoints(true)
Icons.arena3:SetScale(1)
Icons.arena3:Show(1)

Icons.arena32 = CreateFrame("Frame", nil, Icons.topIcons, BackdropTemplateMixin and "BackdropTemplate")
Icons.arena32:SetBackdrop(nil)
Icons.arena32:SetFrameStrata("TOOLTIP")
Icons.arena32:SetSize(8, 8)
Icons.arena32:SetPoint("TOPLEFT", Icons.topIcons, 561, -20) --12
Icons.arena32.texture = Icons.arena32 :CreateTexture(nil, "TOOLTIP")
Icons.arena32.texture:SetAllPoints(true)
Icons.arena32.texture:SetColorTexture(1, 0, 0, 0)
Icons.arena32:SetScale(1)
Icons.arena32:Show(1)

TargetColor = CreateFrame("Frame", "TargetColor", Icons.topIcons, BackdropTemplateMixin and "BackdropTemplate")
TargetColor:SetBackdrop(nil)
TargetColor:SetFrameStrata("HIGH")
TargetColor:SetSize(1, 1)
TargetColor:SetScale(1);
TargetColor:SetPoint("TOPLEFT", Icons.topIcons, 737, -12)
TargetColor.texture = TargetColor:CreateTexture(nil, "TOOLTIP")
TargetColor.texture:SetAllPoints(true)
TargetColor.texture:SetColorTexture(0, 0, 0, 1.0)

function ScaleFix()
    if GetCVar("Contrast")~="50" then SetCVar("Contrast", "50") end;
    if GetCVar("Brightness")~="50" then SetCVar("Brightness", "50") end;
    if GetCVar("Gamma")~="1.000000" then SetCVar("Gamma", "1.000000") end;

    local resolution
	local DPI = GetScreenDPIScale()
    if GetCVar("gxMaximize") == "1" then
		-- Fullscreen (only 8.2+)
		resolution = tonumber(strmatch(GetScreenResolutions(), "%dx(%d+)")) --tonumber(string.match(GetCVar("gxFullscreenResolution"), "%d+x(%d+)"))
	else 
		-- Windowed 
		resolution = select(2, GetPhysicalScreenSize()) --tonumber(string.match(GetCVar("gxWindowedResolution"), "%d+x(%d+)")) 
		
		-- Regarding Windows DPI
		-- Note: Full HD 1920x1080 offsets (100% X8 Y31 / 125% X9 Y38)
		-- You might need specific thing to get truth relative graphic area, so just contact me if you see this and can't find fix for DPI > 1 e.g. 100%
		if not showedOnce and GetScreenDPIScale() ~= 1 then 
			message("You use not 100% Windows DPI and this can may apply conflicts. Set own X and Y offsets in source.")
		end 
	end 	
	
	local myscale1 = 0.42666670680046 * (1080 / resolution)

    Icons.topIcons:SetParent(nil)
    Icons.topIcons:SetScale(myscale1)
	Icons.topIcons:SetFrameStrata("TOOLTIP")
	Icons.topIcons:SetToplevel(true)
end

--Icons.Listener:Add('Rubim_Events', 'PLAYER_ENTERING_WORLD', function(...)
    --ScaleFix()
--end)

--Icons.Listener:Add('Rubim_Events', 'CVAR_UPDATE', function(...)
  --  ScaleFix()
--end)

local updateIcon = CreateFrame("Frame", nil, UIParent, BackdropTemplateMixin and "BackdropTemplate")
function updateIcon:onUpdate(sinceLastUpdate)
    self.sinceLastUpdate = (self.sinceLastUpdate or 0) + sinceLastUpdate
    if (self.sinceLastUpdate >= 0.05) then
        --Hero Rotation
        Icons.stIcon.texture:SetTexture(nil)

        if ACTIVE_CHAT_EDIT_BOX ~= nil then
            Icons.stIcon.texture:SetTexture(nil)
            return
        end

        if SpellIsTargeting() then
            Icons.stIcon.texture:SetTexture(nil)
            return
        end

        if _G.LootFrame:IsShown() then
            Icons.stIcon.texture:SetTexture(nil)
            return
        end


        if HeroRotation and HeroRotation.MainIconFrame and HeroRotation.MainIconFrame:IsShown() and HeroRotation.MainIconFrame.Texture and HeroRotation.MainIconFrame.Texture:GetTexture() then
            Icons.stIcon.texture:SetTexture(HeroRotation.MainIconFrame.Texture:GetTexture())
        end

        if ConRO and ConRO.Spell then
            Icons.stIcon.texture:SetTexture(GetSpellTexture(ConRO.Spell))
        end

        if MaxDps and MaxDps.Spell then
            Icons.stIcon.texture:SetTexture(GetSpellTexture(MaxDps.Spell))
        end

        if Hekili and Hekili_Primary_B1 and ((Hekili_Primary_B1.outOfRange and Hekili_Primary_B1.outOfRange == false) or true) then
            Icons.stIcon.texture:SetTexture(Hekili_Primary_B1.Texture:GetTexture())
        end

        --Hekili
        --[[
        Icons.stIcon.texture:SetTexture()
        if Hekili and Hekili.Main and Hekili.Main.Texture and Hekili.Main.Texture:GetTexture() then
            Icons.stIcon.texture:SetTexture(Hekili.Main.Texture:GetTexture())
        end--]]

        self.sinceLastUpdate = 0
    end
end

updateIcon:SetScript(
        "OnUpdate",
        function(self, sinceLastUpdate)
            updateIcon:onUpdate(sinceLastUpdate)
        end
)

local function ElvUIFix()
    if not ElvUI then 
        return 
    end
    
    local _G, getmetatable, hooksecurefunc 	= 
          _G, getmetatable, hooksecurefunc
          
    local CreateFrame						= _G.CreateFrame	  
    local EnumerateFrames					= _G.EnumerateFrames
    
    local handled = { ["Frame"] = true }
    local object = CreateFrame("Frame", nil, UIParent, BackdropTemplateMixin and "BackdropTemplate")
    object.t = object:CreateTexture(nil,"BACKGROUND")
    local OldTexelSnappingBias = object.t:GetTexelSnappingBias()
    
    local function Fix(frame)
        if (frame and not frame:IsForbidden()) and frame.PixelSnapDisabled and not frame.PixelSnapTurnedOff then
            if frame.SetSnapToPixelGrid then
                frame:SetTexelSnappingBias(OldTexelSnappingBias)
            elseif frame.GetStatusBarTexture then
                local texture = frame:GetStatusBarTexture()
                if texture and texture.SetSnapToPixelGrid then                
                    texture:SetTexelSnappingBias(OldTexelSnappingBias)
                end
            end
            frame.PixelSnapTurnedOff = true 
        end
    end
    
    local function addapi(object)
        local mt = getmetatable(object).__index
        if mt.DisabledPixelSnap then 
            if mt.SetSnapToPixelGrid then hooksecurefunc(mt, 'SetSnapToPixelGrid', Fix) end
            if mt.SetStatusBarTexture then hooksecurefunc(mt, 'SetStatusBarTexture', Fix) end
            if mt.SetColorTexture then hooksecurefunc(mt, 'SetColorTexture', Fix) end
            if mt.SetVertexColor then hooksecurefunc(mt, 'SetVertexColor', Fix) end
            if mt.CreateTexture then hooksecurefunc(mt, 'CreateTexture', Fix) end
            if mt.SetTexCoord then hooksecurefunc(mt, 'SetTexCoord', Fix) end
            if mt.SetTexture then hooksecurefunc(mt, 'SetTexture', Fix) end
        end
    end
    
    addapi(object)
    addapi(object:CreateTexture())
    addapi(object:CreateFontString())
    addapi(object:CreateMaskTexture())
    object = EnumerateFrames()
    while object do
        if not object:IsForbidden() and not handled[object:GetObjectType()] then
            addapi(object)
            handled[object:GetObjectType()] = true
        end
        
        object = EnumerateFrames(object)
    end
end

local function ScaleFixUpdate(self, event, isInitialLogin, isReloadingUi)
    ScaleFix()
    ElvUIFix()
end

local ScaleFixFrame = CreateFrame("Frame", nil, UIParent, BackdropTemplateMixin and "BackdropTemplate")
ScaleFixFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
ScaleFixFrame:RegisterEvent("CVAR_UPDATE")
ScaleFixFrame:SetScript("OnEvent", ScaleFixUpdate)