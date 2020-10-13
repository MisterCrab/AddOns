-- create widgets and variables
local editFrame = CreateFrame("ScrollFrame", "CopiedChatContent", UIParent, "InputScrollFrameTemplate")
local editBox = editFrame.EditBox
local btnClose = CreateFrame("Button", "ChatCopy", editFrame, "UIPanelButtonTemplate")
local escapes = {
	["|T.-|t"] = "", -- textures
	["{.-}"] = "", -- raid target icons
}

-- functions
local function CloseEditor()
	editBox:SetText("")
	editBox:ClearFocus()
	editFrame:Hide()
end

local function unescape(str)
	-- removes escape sequences which lead to bigger lines
	for k, v in pairs(escapes) do
		str = gsub(str, k, v)
	end
	return str
end

-- setup edit box
editFrame:SetPoint("CENTER")
editFrame:SetSize(500, 300)
editFrame.CharCount:Hide()
--editBox:SetFontObject("ChatFontNormal")
editBox:SetFont("Fonts\\ARIALN.ttf", 13)
editBox:SetWidth(editFrame:GetWidth()) -- multiline editboxes need a width declared!!
editBox:SetScript("OnEscapePressed", function(self)
	CloseEditor()
end)
editBox:SetAllPoints()
editFrame:Hide()

-- setup edit box closing button
btnClose:SetPoint("TOPRIGHT")
btnClose:SetSize(15, 15)
btnClose:SetText("x")
btnClose:SetFrameStrata("FULLSCREEN")
btnClose:SetScript("OnClick", function(self)
	CloseEditor()
end)

-- copy button in the chat window
local function CreateCopyBtnForChat(chatFrame)
	local btnCopy = CreateFrame("Button", "ChatCopy", chatFrame, "UIPanelButtonTemplate")
	btnCopy:SetPoint("TOPRIGHT")
	btnCopy:SetSize(50, 20)
	btnCopy:SetText("Copy")
	btnCopy:SetScript("OnClick", function(self)
		-- gets all chat messages and copies them to the edit box
		for iMsg = 1,chatFrame:GetNumMessages() do
			editBox:Insert(unescape(chatFrame:GetMessageInfo(iMsg)))
			editBox:Insert("\n")
		end
		editFrame:Show()
		editBox:HighlightText()
		editBox:SetFocus()
		self:Hide()
	end)
	-- make it less annoying
	btnCopy:Hide()
	btnCopy:SetScript("OnEnter", function(self) self:Show() end)
	btnCopy:SetScript("OnLeave", function(self) self:Hide() end)
	chatFrame:SetScript("OnEnter", function(self) btnCopy:Show() end)
	chatFrame:SetScript("OnLeave", function(self) btnCopy:Hide() end)
end

-- create copy button for all tabs
for i=1,NUM_CHAT_WINDOWS do
	CreateCopyBtnForChat(_G['ChatFrame'..i])
end