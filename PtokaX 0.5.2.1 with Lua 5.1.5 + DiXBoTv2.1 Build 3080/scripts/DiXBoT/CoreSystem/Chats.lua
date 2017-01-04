Chats = {
	UserConnected = {
	--	doJoinChat = function(user,data)
	--		table.insert(tCoroutine, coroutine.create(function()
	--			Chats.Func.doChatsMyINFO(user,data)
	--		end))
	--	end,
	},

	RegConnected = {
	--	doJoinChat = function(user,data)
	--		table.insert(tCoroutine, coroutine.create(function()
	--			Chats.Func.doChatsMyINFO(user,data)
	--		end))
	--	end,
	},

	OpConnected = {
	--	doJoinChat = function(user,data)
	--		table.insert(tCoroutine, coroutine.create(function()
	--			Chats.Func.doChatsMyINFO(user,data)
	--		end))
	--	end,
	},
	
	UserDisconnected = {
	--	doUpdateChat = function(user)
	--		for sChat in pairs(tChats) do
	--			if tChats[sChat].bStatus then
	--				if tChats[sChat].bProfAllow[user.iProfile] and not (tChats[sChat].bExclude[user.sNick] or tChats[sChat].bPrivate) then
	--					Chats.Func.doChatsMyINFO(user,data)
	--				elseif tChats[sChat].bGuest[user.sNick] then
	--					Chats.Func.doChatsMyINFO(user,data)
	--				end
	--			end
	--		end
	--	end,
	},
	
	RegDisconnected = {
	--	doUpdateChat = function(user)
	--		for sChat in pairs(tChats) do
	--			if tChats[sChat].bStatus then
	--				if tChats[sChat].bProfAllow[user.iProfile] and not (tChats[sChat].bExclude[user.sNick] or tChats[sChat].bPrivate) then
	--					Chats.Func.doChatsMyINFO(user,data)
	--				elseif tChats[sChat].bGuest[user.sNick] then
	--					Chats.Func.doChatsMyINFO(user,data)
	--				end
	--			end
	--		end
	--	end,
	},
	
	OpConnected = {
	--	doUpdateChat = function(user)
	--		for sChat in pairs(tChats) do
	--			if tChats[sChat].bStatus then
	--				if tChats[sChat].bProfAllow[user.iProfile] and not (tChats[sChat].bExclude[user.sNick] or tChats[sChat].bPrivate) then
	--					Chats.Func.doChatsMyINFO(user,data)
	--				elseif tChats[sChat].bGuest[user.sNick] then
	--					Chats.Func.doChatsMyINFO(user,data)
	--				end
	--			end
	--		end
	--	end,
	},

	ToArrival = {
		doChats = function(user,data)
			local s,e,toChat = string.find(data, "%S+%s*(%S+)")
			local t = SetMan.GetString(29)
			if tChats[toChat] then
				local _,_,prefix,cmd = data:find("%b<> (["..t.."])(.+)|")
				if not prefix then
					if tChats[toChat].sBy == user.sNick or tChats[toChat].bProfAllow[user.iProfile] or tChats[toChat].bGuest[user.sNick] then
						if (tChats[toChat].bProfAllow[user.iProfile] and not tChats[toChat].bPrivate) or tChats[toChat].bGuest[user.sNick] or tChats[toChat].sBy == user.sNick then
							local s,e,talk = string.find(data, "$To:%s+%S+%s+From:%s+%S+%s+$<%S+>%s+(.+)")
							if not tChats[toChat].bPrivate then
								for nProf in pairs(tChats[toChat].bProfAllow) do
									if tChats[toChat].bProfAuto[nProf] then
										local t = Core.GetOnlineUsers(nProf)
										for i=1, #t do
											if t[i].sNick:lower() ~= user.sNick:lower() and not tChats[toChat].bExclude[t[i].sNick] then
												Core.SendToNick(t[i].sNick, "$To: "..t[i].sNick.." From: "..toChat.." $<"..user.sNick.."> "..talk)
											end
										end
									end
								end
							end
							local tTmp = tChats[toChat].bGuest
							tTmp[tChats[toChat].sBy] = true
							for sUser in pairs(tTmp) do
								local tUser = Core.GetUser(sUser)
								if tUser and sUser:lower() ~= user.sNick:lower() and not tChats[toChat].bExclude[sUser] then
									if tChats[toChat].bProfAllow[tUser.iProfile] or tChats[toChat].bPrivate then
										if tChats[toChat].bPrivate or (not tChats[toChat].bProfAuto[tUser.iProfile]) then
											Core.SendToUser(tUser, "$To: "..sUser.." From: "..toChat.." $<"..user.sNick.."> "..talk)
										else
											tChats[toChat].bGuest[sUser] = nil
										end
									end
								end
							end
						else
							if tChats[toChat].bPrivate then
								Core.SendPmToNick(user.sNick, toChat, "*** Error! - You're not allowed to join this Chat. Please contact [ "..(tChats[toChat].sBy or "an Operator").." ] for access.")
							else
								Core.SendPmToNick(user.sNick, toChat, "*** Error! - You're not a member of this Chat. Type !chatjoin here to Join.")
							end
						end
					else
						Core.SendPmToNick(user.sNick, toChat, "*** Error! - Your are not allowed in this chat.")
					end
				end
			end
		end,
	},
	
	GetNickListArrival = {
		doJoinChat = function(user,data)
			table.insert(tCoroutine, coroutine.create(function()
				Chats.Func.doChatsMyINFO(user,data)
			end))
		end,
	},

	Func = {

		doChatJoin = function(user,data)
			local sChat
			local _,_,sChat = string.find(data, "$To: (%S+) From:")
			if not sChat then doArg1(data) if arg and tChats[arg] then sChat = arg end end
			if sChat and tChats[sChat] then
				if not tChats[sChat].bPrivate then
					if tChats[sChat] and tChats[sChat].bProfAllow[user.iProfile] then
						if not (tChats[sChat].bProfAuto[user.iProfile] or tChats[sChat].bGuest[user.sNick]) or tChats[sChat].bExclude[user.sNick] then
							tChats[sChat].bGuest[user.sNick] = true
							if tChats[sChat].bExclude[user.sNick] then
								tChats[sChat].bExclude[user.sNick] = nil
							end
							SaveToFile("DiXBoT/CoreSystem/Chats/tChats.lua", tChats,"tChats")
							doReturn = "You have joined [ "..sChat.." ]. Type !chatpart in PM to this chat to leave."
						else
							doReturn = "Error! - You're already a member of this Chat."
						end
					else
						doReturn = "Error! - You're not allowed to join this Chat."
					end
				else
					doReturn = "Error! - You're not allowed to join this Chat. Please contact [ "..(tChats[sChat].sBy or "an Operator").." ] for access."
				end
			else
				doReturn = "Error! - Please type this command in PM to the Chat you wish to join."
			end
		end,
		
		doChatPart = function(user,data)
			local sChat
			local _,_,sChat = string.find(data, "$To: (%S+) From:")
			if not sChat then doArg1(data) if arg and tChats[arg] then sChat = arg end end
			if sChat and tChats[sChat] then
				if not tChats[sChat].bPrivate then
					if tChats[sChat] and tChats[sChat].bProfAllow[user.iProfile] then
						if not (tChats[sChat].bProfAuto[user.iProfile] or tChats[sChat].bGuest[user.sNick]) then
							doReturn = "Error! - You're not a member of this Chat."
						elseif tChats[sChat].bExclude[user.sNick] then
							doReturn = "Error! - You have already left this Chat."
						else
							if tChats[sChat].bProfAuto[user.iProfile] then
								tChats[sChat].bExclude[user.sNick] = true
								SaveToFile("DiXBoT/CoreSystem/Chats/tChats.lua", tChats,"tChats")
							end
							if tChats[sChat].bGuest[user.sNick] then
								tChats[sChat].bGuest[user.sNick] = nil
								SaveToFile("DiXBoT/CoreSystem/Chats/tChats.lua", tChats,"tChats")
							end
							SaveToFile("DiXBoT/CoreSystem/Chats/tChats.lua", tChats,"tChats")
							doReturn = "You've left from [ "..sChat.." ]. Type !joinchat in PM to this Chat to rejoin."
						end
					else
						doReturn = "Error! - You're not a member of this Chat."
					end
				else
					doReturn = "Error! - You cannot Part a Private Chat."
				end
			else
				doReturn = "Error! - Please type this command in PM to the Chat you wish to Leave."
			end
		end,
		
		doChatInvite = function(user,data)
			local sChat
			local sWho
			local _,_,sChat = string.find(data, "$To: (%S+) From:")
			local s,e,cmd,sWho = string.find(data, "$To:%s+%S+%s+From:%s+%S+%s+$<%S+>%s+(%S+)%s+(%S+)")
			if not (sChat and sWho) then doArg2(data) if (arg and arg2) and tChats[arg] then sChat = arg sWho = arg2 end end
			if sChat and sWho then
				if tChats[sChat] then
					if tChats[sChat].bGuest[user.sNick] or tChats[sChat].sBy == user.sNick or tChats[sChat].bProfAllow[Core.GetUserValue(user,15)] then
						if not tChats[sChat].bGuest[sWho] then
							tChats[sChat].bGuest[sWho] = true
							if tChats[sChat].bExclude[sWho] then
								tChats[sChat].bExclude[sWho] = nil
							end
							SaveToFile("DiXBoT/CoreSystem/Chats/tChats.lua", tChats,"tChats")
							Chats.Func.doChatsMyINFO()
							Core.SendPmToNick(sWho, sChat, "*** You have been invited to join this Chat by "..user.sNick)
							doReturn = "You have invited [ "..sWho.." ] to Join [ "..sChat.." ]."
						else
							doReturn = "Error! - [ "..sWho.." ] is already a member of this Chat."
						end
					else
						doReturn = "Error! - You are not allowed to Invite users to this Chat."
					end
				else
					doReturn = "Error! - Please type this command in PM to the Chat."
				end
			else
				doReturn = "Error! - Please type this command in PM to the Chat."
			end
		end,
		
		doChatUnInvite = function(user,data)
			local sChat
			local sWho
			local _,_,sChat = string.find(data, "$To: (%S+) From:")
			local s,e,cmd,sWho = string.find(data, "$To:%s+%S+%s+From:%s+%S+%s+$<%S+>%s+(%S+)%s+(%S+)")
			if not (sChat and sWho) then doArg2(data) if (arg and arg2) and tChats[arg] then sChat = arg sWho = arg2 end end
			if sChat and sWho then
				if tChats[sChat] then
					if tChats[sChat].bGuest[user.sNick] or tChats[sChat].sBy == user.sNick then
						if tChats[sChat].bGuest[sWho] then
							tChats[sChat].bGuest[sWho] = nil
							if tChats[sChat].bExclude[sWho] then
								tChats[sChat].bExclude[sWho] = nil
							end
							SaveToFile("DiXBoT/CoreSystem/Chats/tChats.lua", tChats,"tChats")
							Core.SendPmToNick(sWho, sChat, "*** You have been removed from this Chat by "..user.sNick)
							Core.SendToNick(sWho,"$Quit "..sChat)
							doReturn = "You have Uninvited [ "..sWho.." ] from [ "..sChat.." ]."
						else
							doReturn = "Error! - [ "..sWho.." ] is not a member of this Chat."
						end
					else
						doReturn = "Error! - You are not allowed to Uninvite users from this Chat."
					end
				else
					doReturn = "Error! - Please type this command in PM to the Chat."
				end
			else
				doReturn = "Error! - Please type this command in PM to the Chat."
			end
		end,
		
		doChatStatus = function(user,data)
			local header = "\n\n\t"..string.rep(":", 80).."\n\t"..(SetMan.GetString(0) or "No HubName Entered").." Chat Status:\n\t"..string.rep(":", 80).."\n"
			local footer = "\t"..string.rep(":", 80).."\n\tType !help to view available commands.\n\t"..string.rep(":", 80)..""
			local lines = ""
			local sProfAllow = "None"
			local sGuest = "None"
			local sChat
			local _,_,sChat = string.find(data, "$To: (%S+) From:")
			if not sChat then doArg1(data) if arg and tChats[arg] then sChat = arg end end

			if sChat then

				for sName in pairs(tChats[sChat].bGuest) do
					if sName then
						if sGuest == "None" then sGuest = "" end
						local tUser = Core.GetUser(sName)
						if tUser then
							sGuest = sGuest.."\n\t\t"..string.format("%-20.25s",sName).."\t (Online)"
						else
							sGuest = sGuest.."\n\t\t"..string.format("%-20.25s",sName).."\t (Offline)"
						end
					end
				end
				if not tChats[sChat].bPrivate then
					local t = ProfMan.GetProfiles()
					for i=0, (#t) do
						if tChats[sChat].bProfAllow[i] then
							if sProfAllow == "None" then sProfAllow = "" end
							if tChats[sChat].bProfAuto[i] then
								sProfAllow = sProfAllow.."\n\t\t"..string.format("%-20.25s",(GetProfileName(i) or "Unreg")).."\t (AutoJoin True)"
							else
								sProfAllow = sProfAllow.."\n\t\t"..string.format("%-20.25s",(GetProfileName(i) or "Unreg")).."\ (AutoJoin False)"
							end
						end
					end
				end
			local t = {
				[1] = {"Name:", sChat},	
				[2] = {"Desc:", (tChats[sChat].sDesc or "N/A")},
				[3] = {"Email:", (tChats[sChat].sEmail or "N/A")},
				[4] = {"Created By:", (tChats[sChat].sBy or "N/A")},
				[5] = {string.rep("-",25), ""},
				[6] = {"Status:", tostring(tChats[sChat].bStatus or "FALSE"):upper()},
				[7] = {"Private:", tostring(tChats[sChat].bPrivate or "FALSE"):upper()},
				[8] = {string.rep("-",25), ""},
				[9] = {"Guests:", sGuest},
				[10] = {string.rep("-",25), ""},
				[11] = {"Profiles:", sProfAllow},
				}

				for i=1, #t do
					if t[i][2] then
						local line = "\t"..string.format("%-30.35s",t[i][1])
						local line2 = (t[i][2] or "")
						lines = lines.." "..line.."\t "..line2.."\n"
					end
					doReturn = header..lines..footer
				end
			else
				doMemClear()
				doReturn = "Error! - Type !chatconfig [ ChatName ] or type the cmd in PM to a chat."
			end
		end,
	
		doChatNew = function(user,data)
			doArg1(data)
			if arg == nil then
				doReturn = "Error! - Type !chatnew [ Chat Name ] to add a new Chat."
			elseif tChats[arg] then
				doReturn = "Error! - A Chat named [ "..arg.." ] already exists."
			elseif string.find(arg, "[%%*\<>/\\]") or arg:find("&#124;") or arg:find("&#36;") then   --$|<>:?*"/\    --^$()%.[]*+-?)
				doReturn = "Error! - Chat Name cannot contain blank spaces or character such as \"$%*\<>/\\\"."
			else
				tChats[arg] = {
					["bProfAllow"] = {},
					["bProfAuto"] = {},
					["bGuest"] = {},
					["bPrivate"] = false,
					["bExclude"] = {},
					["bKey"] = true,
					["bStatus"] = true,
					["sBy"] = user.sNick,
					["sDesc"] = "",
					["sEmail"] = "",
				}
				tBots[arg] = 1
				SaveToFile("DiXBoT/CoreSystem/Chats/tChats.lua", tChats,"tChats")
				Chats.Func.doChatsMyINFO()
				doReturn = "Chat [ "..arg.." ] has been added."
			end
		end,
		
		doChatDel = function(user,data)
			doArg1(data)
			if arg == nil then
				doReturn = "Error! - Type !chatdel [ Chat Name ] to delete a Chat."
			elseif not tChats[arg] then
				doReturn = "Error! - A Chat named [ "..arg.." ] do not exists."
			else
				tChats[arg] = nil
				Core.SendToAll("$Quit "..arg)
				SaveToFile("DiXBoT/CoreSystem/Chats/tChats.lua", tChats,"tChats")
				Chats.Func.doChatsMyINFO()
				doReturn = "Chat [ "..arg.." ] has been deleted."
			end
		end,
		
		SetChatName = function(user,data)
			doArg2(data)
			if (arg or arg2) == nil then
				doReturn = "Error! - Type !chatname [ Old name ] [ New name ] to rename a Chat."
			elseif not tChats[arg] then
				doReturn = "Error! - A Chat named [ "..arg.." ] do not exists."
			elseif tChats[arg2] then
				doReturn = "Error! - A Chat named [ "..arg.." ] already exists."
			elseif string.find(arg, "[%%*\<>/\\]") or arg:find("&#124;") or arg:find("&#36;") then   --$|<>:?*"/\    --^$()%.[]*+-?)
				doReturn = "Error! - Chat Name cannot contain blank spaces or character such as \"$%*\<>/\\\"."
			else
				tChats[arg2] = tChats[arg]
				tChats[arg] = nil
				Core.SendToAll("$Quit "..arg)
				SaveToFile("DiXBoT/CoreSystem/Chats/tChats.lua", tChats,"tChats")
				Chats.Func.doChatsMyINFO()
				doReturn = "Chat [ "..arg.." ] has been renamed to [ "..arg2.." ]."
			end
		end,
		
		SetChatDesc = function(user,data)
			doArg2(data)
			if (arg or arg2) == nil then
				doReturn = "Error! - Type !chatdesc [ Chat name ] [ Chat Description ] to change this setting."
			elseif not tChats[arg] then
				doReturn = "Error! - A Chat named [ "..arg.." ] do not exists."
			else
				tChats[arg].sDesc = arg2
				SaveToFile("DiXBoT/CoreSystem/Chats/tChats.lua", tChats,"tChats")
				Chats.Func.doChatsMyINFO()
				doReturn = "Chat [ "..arg.." ] Desccription has been set to [ "..arg2.." ]."
			end	
		end,
		
		SetChatMail = function(user,data)
			doArg2(data)
			if (arg or arg2) == nil then
				doReturn = "Error! - Type !chatmail [ Chat name ] [ Chat Mail ] to change this setting."
			elseif not tChats[arg] then
				doReturn = "Error! - A Chat named [ "..arg.." ] do not exists."
			else
				tChats[arg].sEmail = arg2
				SaveToFile("DiXBoT/CoreSystem/Chats/tChats.lua", tChats,"tChats")
				Chats.Func.doChatsMyINFO()
				doReturn = "Chat [ "..arg.." ] Email has been set to [ "..arg2.." ]."
			end	
		end,
		
		SetChatStatus = function(user,data)
			doArg2(data)
			if (arg or arg2) == nil then
				doReturn = "Error! - Type !chatstatus [ Chat Name ] [ True/False ] to change this setting."
			elseif not tChats[arg] then
				doReturn = "Error! - A Chat named [ "..arg.." ] do not exists."
			else
				if arg2:lower() == "true" then
					tChats[arg].bStatus = true
					SaveToFile("DiXBoT/CoreSystem/Chats/tChats.lua", tChats,"tChats")
					Chats.Func.doChatsMyINFO()
					doReturn = "Chat [ "..arg.." ] has been set to [ "..arg2:upper().." ]."
				elseif arg2:lower() == "false" then
					tChats[arg].bStatus = false
					SaveToFile("DiXBoT/CoreSystem/Chats/tChats.lua", tChats,"tChats")
					Core.SendToAll("$Quit "..arg)
					doReturn = "Chat [ "..arg.." ] has been set to [ "..arg2:upper().." ]."
				else
					doReturn = "Error! - Type !chatstatus [ Chat Name ] [ True/False ] to change this setting."
				end
			end
		end,
		
		SetChatPrivate = function(user,data)
			doArg2(data)
			if (arg or arg2) == nil then
				doReturn = "Error! - Type !chatprivate [ Chat Name ] [ True/False] to change this setting."
			elseif not tChats[arg] then
				doReturn = "Error! - A Chat named [ "..arg.." ] do not exists."
			elseif arg2:lower() == "true" then
				Core.SendToAll("$Quit "..arg)
				tChats[arg].bPrivate = true
				if not tChats[arg].bGuest[user.sNick] then
					tChats[arg].bGuest[user.sNick] = true
				end
				SaveToFile("DiXBoT/CoreSystem/Chats/tChats.lua", tChats,"tChats")
				table.insert(tCoroutine, coroutine.create(function()
					Chats.Func.doChatsMyINFO()
				end))
				doReturn = "Chat [ "..arg.." ] Private has been set to [ "..arg2:upper().." ]."
			elseif arg2:lower() == "false" then
				tChats[arg].bPrivate = nil
				Chats.Func.doChatsMyINFO()
				SaveToFile("DiXBoT/CoreSystem/Chats/tChats.lua", tChats,"tChats")
				doReturn = "Chat [ "..arg.." ] Private has been set to [ "..arg2:upper().." ]."
			else
				doReturn = "Error! - Type !chatprivate [ Chat Name ] [ True/False] to change this setting."
			end
		end,
		
		SetChatAutoJoin = function(user,data)
			local uLevel, sLevel = doProfiles() 
			uLevel["unreg"] = -1 sLevel = sLevel.."/Unreg"
			doArg3(data)
			if (arg or arg2 or arg3) == nil then
				doReturn = "Error! - Type !chatautojoin [ Chat Name ] [ Profile ] [ True/False ] to change this setting."
			elseif not tChats[arg] then
				doReturn = "Error! - A Chat named [ "..arg.." ] do not exists."
			elseif uLevel[arg2:lower()] == nil then
				doReturn = "[ "..arg2.." ] is not a valide Profile. Please use [ "..sLevel.." ]."
			elseif arg3:lower() == "true" then
				tChats[arg].bProfAllow[uLevel[arg2:lower()]] = true
				tChats[arg].bProfAuto[uLevel[arg2:lower()]] = true
				SaveToFile("DiXBoT/CoreSystem/Chats/tChats.lua", tChats,"tChats")
				Chats.Func.doChatsMyINFO()
				doReturn = "Chat [ "..arg.." ] Autojoin for profile [ "..(GetProfileName(uLevel[arg2:lower()]) or "Unreg").." ] has been set to [ "..arg3:upper().." ]."
			elseif arg3:lower() == "false" then
				tChats[arg].bProfAuto[uLevel[arg2:lower()]] = nil
				SaveToFile("DiXBoT/CoreSystem/Chats/tChats.lua", tChats,"tChats")
				doReturn = "Chat [ "..arg.." ] Autojoin for profile [ "..(GetProfileName(uLevel[arg2:lower()]) or "Unreg").." ] has been set to [ "..arg3:upper().." ]."
			else
				doReturn = "Error! - Type !chatautojoin [ Chat Name ] [ Profile ] [ True/False ] to change this setting."
			end
		end,
		
		SetChatProf = function(user,data)
			local uLevel, sLevel = doProfiles() 
			uLevel["unreg"] = -1 sLevel = sLevel.."/Unreg"
			doArg3(data)
			if (arg or arg2 or arg3) == nil then
				doReturn = "Error! - Type !chatprof [ Chat Name ] [ Profile ] [ True/False ] to change this setting."
			elseif not tChats[arg] then
				doReturn = "Error! - A Chat named [ "..arg.." ] do not exists."
			elseif uLevel[arg2:lower()] == nil then
				doReturn = "[ "..arg2.." ] is not a valide Profile. Please use [ "..sLevel.." ]."
			elseif arg3:lower() == "true" then
				tChats[arg].bProfAllow[uLevel[arg2:lower()]] = true
				SaveToFile("DiXBoT/CoreSystem/Chats/tChats.lua", tChats,"tChats")
				Chats.Func.doChatsMyINFO()
				doReturn = "Chat [ "..arg.." ] Allowed profile [ "..(GetProfileName(uLevel[arg2:lower()]) or "Unreg").." ] has been set to [ "..arg3:upper().." ]."
			elseif arg3:lower() == "false" then
				tChats[arg].bProfAllow[uLevel[arg2:lower()]] = nil
				SaveToFile("DiXBoT/CoreSystem/Chats/tChats.lua", tChats,"tChats")
				if uLevel[arg2:lower()] == -1 then
					Core.SendToAll("$Quit "..arg)
					Chats.Func.doChatsMyINFO()
				else
					Core.SendToProfile(uLevel[arg2:lower()], "$Quit "..arg)
				end
				doReturn = "Chat [ "..arg.." ] Allowed profile [ "..(GetProfileName(uLevel[arg2:lower()]) or "Unreg").." ] has been set to [ "..arg3:upper().." ]."
			else
				doReturn = "Error! - Type !chatprof [ Chat Name ] [ Profile ] [ True/False ] to change this setting."
			end
		end,
	
		doLoadBots = function()
			for sBots in pairs(tChats) do
				if tChats[sBots].Active then
					if string.len((SetMan.GetString(0) or "").." : "..tChats[sBots].sDesc.." ["..tChats[sBots].sBy.."]") > 63 then
						Core.RegBot(sBots, tChats[sBots].Desc.." ["..tChats[sBots].sBy.."]", "dixbot@dixbot.com", true)
					else
						Core.RegBot(sBots, (SetMan.GetString(0) or "").." : "..tChats[sBots].sDesc.." ["..tChats[sBots].sBy.."]", "dixbot@dixbot.com", true)
					end
				end
			end
		end,
		
		doChatUsersOnline = function(sChat)
			local nCount = 0
			for n in pairs(tChats[sChat].bProfAuto) do
				if n == -1 then
					nCount = nCount + (Core.GetUsersCount() - Core.GetOnlineRegs())
				else
					nCount = nCount + #Core.GetOnlineUsers(n) --#Core.GetOnlineUsers(i-1)
				end
			end
			for sUser in pairs(tChats[sChat].bGuest) do
				if Core.GetUser(sUser) then
					nCount = nCount + 1
				end
			end
			return nCount
		end,
		
		doChatsMyINFO = function(user,data)
			if user then
				for sChat in pairs(tChats) do
					if tChats[sChat].bStatus then
						if tChats[sChat].bProfAllow[user.iProfile] and not (tChats[sChat].bExclude[user.sNick] or tChats[sChat].bPrivate) then
							Core.SendToUser(user,"$MyINFO $ALL "..sChat.." ["..Chats.Func.doChatUsersOnline(sChat).."] "..(tChats[sChat].Desc or "").."$ $ $"..(tChats[sChat].sEmail or "").."$$|$OpList "..sChat.."$$|")
						elseif tChats[sChat].bGuest[user.sNick] then
							Core.SendToUser(user,"$MyINFO $ALL "..sChat.." ["..Chats.Func.doChatUsersOnline(sChat).."] "..(tChats[sChat].Desc or "").."$ $ $"..(tChats[sChat].sEmail or "").."$$|$OpList "..sChat.."$$|")
							--$MyINFO $ALL [DiXBoT] DiXBoT v2.1 Build 2830$ $$dixbot@dixbot.com$$|
						end
						if user.iProfile == 0 then
							Core.SendToUser(user, "$MyINFO $ALL "..sChat.." ["..Chats.Func.doChatUsersOnline(sChat).."] "..(tChats[sChat].sDesc or "").."$ $ $"..(tChats[sChat].sEmail or "").."$$|$OpList "..sChat.."$$|")
						end
					end
				end
			else
				for sChat in pairs(tChats) do
					if tChats[sChat].bStatus then
						if not tChats[sChat].bPrivate then
							for i in pairs(tChats[sChat].bProfAllow) do
								if GetProfileName(i) then
									Core.SendToProfile(i, "$MyINFO $ALL "..sChat.." ["..Chats.Func.doChatUsersOnline(sChat).."] "..(tChats[sChat].sDesc or "").."$ $ $"..(tChats[sChat].sEmail or "").."$$|$OpList "..sChat.."$$|")
								elseif i == -1 then
									Core.SendToAll("$MyINFO $ALL "..sChat.." ["..Chats.Func.doChatUsersOnline(sChat).."] "..(tChats[sChat].sDesc or "").."$ $ $"..(tChats[sChat].sEmail or "").."$$|$OpList "..sChat.."$$|")
								end
							end
						end
						for sUser in pairs(tChats[sChat].bGuest) do
							if Core.GetUser(sUser) then
								Core.SendToNick(sUser, "$MyINFO $ALL "..sChat.." ["..Chats.Func.doChatUsersOnline(sChat).."] "..(tChats[sChat].sDesc or "").."$ $ $"..(tChats[sChat].sEmail or "").."$$|$OpList "..sChat.."$$|")
							end
						end
						Core.SendToProfile(0, "$MyINFO $ALL "..sChat.." ["..Chats.Func.doChatUsersOnline(sChat).."] "..(tChats[sChat].sDesc or "").."$ $ $"..(tChats[sChat].sEmail or "").."$$|$OpList "..sChat.."$$|")
					end
				end
			end
			doMemClear()
		end,

		doLevChatRC = function(user,data)
			local t = ProfMan.GetProfiles()
			for i=1, table.getn(t) do
				Core.SendToNick(user.sNick, "$UserCommand 1 15  • Hub Config\\Chat Settings\\New Level Chat\\"..t[i].sProfileName.."$<%[mynick]> !levchat %[line: Enter ChatName. Ex: MyChat] "..t[i].sProfileName.."&#124;")
			end
			doMemClear()
		end,

		doLevChatAddRC = function(user,data)
			local t = ProfMan.GetProfiles()
			for sChat in pairs(tChats) do
				if tChats[sChat].Levels then
					for i=1, table.getn(t) do
						Core.SendToNick(user.sNick, "$UserCommand 1 15  • Hub Config\\Chat Settings\\Level Chat Profiles\\"..sChat.."\\Add Profile\\"..t[i].sProfileName.."$<%[mynick]> !levchatprof add "..sChat.." "..t[i].sProfileName.."&#124;")
						Core.SendToNick(user.sNick, "$UserCommand 1 15  • Hub Config\\Chat Settings\\Level Chat Profiles\\"..sChat.."\\Remove Profile\\"..t[i].sProfileName.."$<%[mynick]> !levchatprof del "..sChat.." "..t[i].sProfileName.."&#124;")
					end
				end
			end
			doMemClear()
		end,

	},

	Asserts = {
		[1] = "DiXBoT/CoreSystem/Chats/tChats.lua",
	},

	["OnStartup"] = {
		doRegChats = function(user,data)
			for sChats in pairs(tChats) do
				if not tBots[sChats] then
					tBots[sChats] = 1
				end
			end
			--Chats.Func.doLoadBots()
			Chats.Func.doChatsMyINFO()
		end,

	},
	
	DxbMgrArrival = {
		doChats = {"chats",function(user)
			table.insert(tCoroutine, coroutine.create(function()
				local sChatList = "$CHATS §CHATLIST "
				for sChat in pairs(tChats) do
					if tChats[sChat].bStatus then
						sChatList = sChatList..sChat.."\\true,"
					else
						sChatList = sChatList..sChat.."\\false,"
					end
				end
				Core.SendToUser(user,"$DXB "..sChatList)
			end))
		end,},
		
--[[ Old style chat
	["[DiXChaT]"] = {
		["Levels"] = {
			[0] = 1,
		},
		["Key"] = 1,
		["Active"] = true,
		["Desc"] = "Level Chat",
		["By"] = "Snooze",
		["bStatus"] = true,
	},
]]
		doChatsInfo = {"chatinfo",function(user,data)
			dxbArg1(data)
			if arg and tChats[arg] then
				local sAuto = ""
				local sProf = ""
				local t = ProfMan.GetProfiles()
				for i=1, (#t+1) do
					if t[i] then
						if t[i].tProfilePermissions.bIsOP then
							sProf = sProf..(GetProfileName(i-1) or "Unreg").."\\0\\"..tostring(tChats[arg].bProfAllow[i-1]).."\\,"
							sAuto = sAuto..(GetProfileName(i-1) or "Unreg").."\\0\\"..tostring(tChats[arg].bProfAuto[i-1]).."\\,"
						else
							sProf = sProf..(GetProfileName(i-1) or "Unreg").."\\1\\"..tostring(tChats[arg].bProfAllow[i-1]).."\\,"
							sAuto = sAuto..(GetProfileName(i-1) or "Unreg").."\\1\\"..tostring(tChats[arg].bProfAuto[i-1]).."\\,"
						end
					else
						sProf = sProf..(GetProfileName(i-1) or "Unreg").."\\1\\"..tostring(tChats[arg].bProfAllow[i-1]).."\\,"
						sAuto = sAuto..(GetProfileName(i-1) or "Unreg").."\\1\\"..tostring(tChats[arg].bProfAuto[i-1]).."\\,"
					end
				end
				local t = {
					["chatname"] = arg,
					["chatdesc"] = (tChats[arg].sDesc or ""),
					["chatemail"] = (tChats[arg].sEmail or ""),
					["autojoin"] = sAuto,
					["prof"] = sProf,
					["guest"] = tostring(tChats[arg].bAllowGuest or "false"),
					["private"] = tostring(tChats[arg].bPrivate or "false"),
				}
				local sConf = "$CHATS"
				for a,b in pairs(t) do
					sConf = sConf.."§"..a.." "..b
				end
				Core.SendToUser(user,"$DXB "..sConf)
			end
			doMemClear()
		end,},
	},

	DxbLoad = {
		doLoadChats = function()
			dofile(tCoreConfig.System.wPath.."DiXBoT/CoreSystem/Chats/ini/CMD.ini")
			dofile(tCoreConfig.System.wPath.."DiXBoT/CoreSystem/Chats/ini/LANG.ini")
			dofile(tCoreConfig.System.wPath.."DiXBoT/CoreSystem/Chats/ini/CONF.ini")
			if Chats.Conf.Lang then
				local f = io.open(tCoreConfig.System.wPath.."DiXBoT/CoreSystem/Chats/lang/"..Chats.Conf.Lang..".lang", "r")
				if f then
					dofile(tCoreConfig.System.wPath.."DiXBoT/CoreSystem/Chats/lang/"..Chats.Conf.Lang..".lang")
				else
					Chats.Conf.Lang = false
					SaveToFile("DiXBoT/CoreSystem/Chats/ini/CONF.ini", Chats.Conf,"Chats.Conf")
				end
			else
				Chats.Lang2 = {}
			end
		end,
	},

	Lang2 = {},
}
DxbModule = {Chats,Chats.Lang2}